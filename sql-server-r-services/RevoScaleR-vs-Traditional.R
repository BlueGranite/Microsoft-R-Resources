###
#Basic Connectivity to SQL Server with RevoScaleR
#Compares traditional ODBC connection with ScaleR rx[...]
#Uses WideWorldImportersDW sample database for SQL Server 2016
###

library(RODBC) 
library(RevoScaleR)

#reset compute context to local in case it is sql server
local <- RxLocalSeq()
rxSetComputeContext(local)

#connection string and source query (replace SERVERNAME and use Uid and Pwd if needed)
sql.conn.string <- 'driver={SQL Server};server=[SERVERNAME];database=WideWorldImportersDW;trusted_connection=true'
source.query <- paste("SELECT CASE WHEN [Order Date Key] = [Picked Date Key]",
                      "THEN 1 ELSE 0 END AS SameDayFulfillment,",
                      "[City Key] AS city,[Stock Item Key] AS item,",
                      "[Picker Key] AS picker,[Quantity] AS quantity",
                      "FROM [Fact].[Order]",
                      "WHERE [WWI Order ID] >= 63968")

#traditional ODBC connection to SQL Server
wwi.conn.odbc <- odbcDriverConnect(sql.conn.string)

#connect with RODBC and preview orders
orders <- sqlQuery(wwi.conn.odbc, source.query)
head(orders)

#traditional logistic regression
order.logit <- glm(SameDayFulfillment ~ city + item + picker + quantity, data = orders)
order.logit


#__RevoScaleR functions__
#change compute context to SQL Server with RevoScaleR
wwi.conn.rx <- sql.conn.string
sql_share_directory <- paste("c:\\AllShare\\", Sys.getenv("USERNAME"), sep = "")
  #the directory above may already exist. if not, uncomment below
  #dir.create(sql_share_directory, recursive = TRUE)
sql <- RxInSqlServer(connectionString = wwi.conn.rx, shareDir = sql_share_directory)  
rxSetComputeContext(sql)

#query database from SQL Server compute context
inDataSource <- RxSqlServerData(sqlQuery = source.query, connectionString = wwi.conn.rx, rowsPerRead=500) 

#method to import data to local data frame if desired
localDf <- rxImport(inDataSource)

#otherwise#
#perform logistic regression in-database on data from SQL Server compute context
order.logit.rx <- rxLogit(SameDayFulfillment ~ city + item + picker + quantity, data = inDataSource)
order.logit.rx