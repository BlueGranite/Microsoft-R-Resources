#SQL Server R Services Tutorial

###Prerequisites
- Download and install the free [Microsoft R Client](https://msdn.microsoft.com/en-us/microsoft-r/notes/r-client-notes) on your local workstation. 
R Client includes the ScaleR (rx[...]) functions in the RevoScaleR package.
- Download and install an R IDE such as [RStudio](https://www.rstudio.com/products/rstudio/download) 
or [R Tools for Visual Studio](https://www.visualstudio.com/en-us/features/rtvs-vs.aspx).
- Download and install SQL Server Management Studio.
- Download and install Visual Studio and SQL Server Data Tools (only needed for Activity 3 - Reporting Services).
- Verify access to an instance of SQL Server 2016 configured for R Services.
- Verify access to an instance of SQL Server 2016 that has the 
[WideWorldImportersDW](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers) sample database.

###Activity 1 - Develop in R
1. In RStudio, open the RevoScaleR-vs-Traditional.R file (from the *sql-server-r-services* folder in this GitHub repo).
2. Install the RODBC package (i.e. install.packages("RODBC") ) if needed. RevoScaleR should already be available if you have Microsoft R Client installed.
3. Run the setup code in sequence to reference the RODBC and RevoScaleR libraries and reset your compute context to "local" if you have already been using a SQL compute context outside of this tutorial.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-01.PNG)

4. Replace [SERVERNAME] in *sql.conn.string* with your SQL Server instance. You may need to change the trusted connection to Uid= and Pwd= depending on your authentication type. Once your connection string is ready, run the code to add *sql.conn.string* and *source.query* to your R environment. The source query is a very simple query running against the WWI Fact.Order table. For simplicity, it does not join to any dimensions to get descriptions.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-02.PNG)

5.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-03.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-04.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-05.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-06.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-07.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-08.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-09.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-10.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-11.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-12.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-13.PNG)

###Activity 2 - Adapt R Code for SQL Server


###Activity 3 - Visualize an R Plot in Reporting Services
