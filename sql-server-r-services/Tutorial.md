#SQL Server R Services Tutorial

This tutorial walks through some basic development and deployment scenarios for R Services in SQL Server 2016. You will use sample order data and take R code that can be run standalone in RStudio or another R IDE, adapt it for use in SQL Server, and then consume it both in SQL Management Studio as well as from Reporting Services. 

###Objectives
- Learn about some of the Microsoft R "RevoScaleR" functions
- Adapt R code for a logistic regression model for use in SQL Server
- Embed R code in SQL Server stored procedures
- Make predictions on new data using a trained R model stored in SQL Server
- View a plot in Reporting Services using R output from SQL Server

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
1. In RStudio, open the *RevoScaleR-vs-Traditional.R* file (from the *sql-server-r-services* folder in this GitHub repo).  

2. Install the RODBC package (i.e. install.packages("RODBC") ) if needed. RevoScaleR should already be available if you have Microsoft R Client installed.  

3. Run the setup code in sequence to reference the RODBC and RevoScaleR libraries and reset your compute context to "local" if you have already been using a SQL compute context outside of this tutorial.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-01.PNG)

4. Replace [SERVERNAME] in *sql.conn.string* with your SQL Server instance. You may need to change the trusted connection to Uid= and Pwd= depending on your authentication type. Once your connection string is ready, run the code to add *sql.conn.string* and *source.query* to your R environment. The source query is a very simple query running against the WWI Fact.Order table. For simplicity, it does not join to any dimensions to get descriptions.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-02.PNG)

5. You will now look at one traditional method to analyze data from SQL Server. You will create an ODBC connection and import data from SQL Server into a local data frame named *orders*. Run the following code to load data and get the first few observations.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-03.PNG)

6. Look at the first few observations. *SameDayFulfillment* is an engineered feature with a 0/1 value noting if an order was packed the same day that it was placed. If 1, it was same day fulfillment. If 0, it was not. The other variables are unmodified key values from the Fact.Order table. You should also notice the *orders* data frame in your environment window with 29913 observations and 5 variables.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-04.PNG)

7. You will now run a very basic logistic regression using the built-in *glm* function on the local data frame and view the coefficients.    
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-05.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-06.PNG)  

8. Now that you've seen the traditional method, you will switch your *compute context* and process data in-database instead of locally. You will also change from traditional functions to the ScaleR "rx"-prefixed functions from the RevoScaleR package. Run the following code to change your compute context from local to SQL Server.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-07.PNG)

9. Run the following code to build your SQL query.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-08.PNG)

10. The following code using *rxImport()* is here for information more than function. *If* you wanted to bring your data into a local data frame, you can use rxImport with the in-database object.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-09.PNG)

11. Otherwise, run the following code to train a logistic regression model using the SQL data object. Not that you now use the *rxLogit()* function (equivalent to glm above). You could take it a step further on your own and use the *rxPredict()* function with new data to classify whether or not additional orders would be fulfilled same day or not.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-10.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-11.PNG)

12. Finally, run the following code to produce a histogram displaying the quantity of items per order. Note the positive/right skew where most orders have fifty items or less and the rest of the bins compose a long tail to the right.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-12.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-r-13.PNG)

Don't worry about analyzing this data. The logistic regression and histogram are simple examples that will be used to show how to embed and work with your R code in SQL Server. The plot will surface again in the later Reporting Services activity.

###Activity 2 - Adapt R Code for SQL Server
1. In Management Studio, open the *R-Services-Example.sql* file (from the sql-server-r-services folder in this GitHub repo).  
2. Connect to your SQL instance that has the WWI DW sample database and R Services installed.  
3. Execute the following code to verify that you are using the correct database.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-sql-01.PNG)

4. You will not take some time to explore a very basic example of the new *sp_execute_external_script* stored procedure, which allows you to work with R code using R Services. The required parameters are @language, @script, and @input_dataset_1. There are additional optional parameters that are not currently being used. @script is where the adapted R code goes. Note that except for changing the source data to *InputDataSet*, the code itself is similar to the logistic regression you ran earlier in RStudio. The final line of @script is there simply to print to stdout. Likewise, note that @input_dataset_1 is similar to the source SQL query that you used in RStudio. Execute the code and note that the output on the *Messages* tab in Management Studio. Does it appear similar to the rxLogit() output in RStudio?  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-sql-02.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-sql-03.PNG)

5. The prior execution outputed to stdout, but now you will wrap that code in another stored procedure for repeatable use. In the following code, note the changes. You are now creating a stored procedure called *dbo.sp_EmbeddedRSample*. Instead of printing the output, you are serializing the trained model, converting it to a data frame, and storing it in *OutputDataSet*. Finally, note the addition of *WITH RESULT SETS* at the end and how a binary model is the new output. Execute the code to create the new stored procedure.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-sql-04.PNG)

6. Execute the following code to create a table that is used to store the model. The final section executes the earlier stored procedure and inserts the model into the new table.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-sql-05.PNG)

7. You will now create a *second* stored procedure to predict same day fulfillments based on the earlier model. Note that the new *dbo.sp_PredictRSample* procedure takes a number of parameters that correspond to the SQL input you have already been familiar with. The procedure uses the model you trained earlier, and the output includes the new data used to predict as well as a new column called *PredictedSameDayFulfillment*.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-sql-06.PNG)

8. Run the following code, which executes the prediction stored procedure with one record of sample data. Note that the output in this case was ~0.67, which unconvincingly leans toward same day fulfillment because it is closer to 1 than 0.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-sql-07.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-sql-08.PNG)

9. Change the *quantity* value and note the new prediction. In this case, increasing the quantity ordered to *1000* results in a predicted value much closer to 0. Based on the established training data, high-quantity orders likely cannot be fulfilled same day as easily. In the real world, this could be due to lack of inventory or other factors.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-sql-10.PNG)
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-sql-11.PNG)

10. As a final step, you will create a new stored procedure as a lead-in for the next Reporting Services activity. Execute the following code to create the *dbo.sp_HistogramSample* procedure. Note that the output is binary as it was when you embedded the R model earlier. While the final output will be the same image as what you viewed in RStudio, this R code is noticeably different than what you ran in RStudio. While you cannot see the image in Management Studio, the binary can be consumed in client tools such as Reporting Services.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-sql-12.PNG)

###Activity 3 - Visualize an R Plot in Reporting Services
1. Download and unzip the *R-Services-Sample-Reports.zip* file (from the *sql-server-r-services* folder in this GitHub repo). 
2. Open the *R-Services-Sample-Reports* solution in the latest version of SQL Server Data Tools.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-ssrs-01.PNG)

3. Open the *SampleHistogram.rdl* file from Solution Explorer.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-ssrs-02.PNG)

4. Open *WideWorldImportersDW" under *Data Sources* in Report Data. Change the connection string to your own SQL Server instance.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-ssrs-03.PNG)

5. Expand *Datasets* in Report Data and view *Dataset1*. Note how the dataset uses the *sp_HistogramSample* stored procedure as a source. You may need to use the dropdown menu and select the stored procedure using your own SQL connection.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-ssrs-04.PNG)

6. Right-click on the empty image object on the report canvas, then select *Image Properties*. In the Properties window, note how the image is using a Database source, selecting the plot from DataSet1, and using the jpeg MIME type.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-ssrs-05.PNG)

7. Click *Preview* to view the report, and you should see the same histogram that you viewed in RStudio.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/sql-server-r-services/tutorial-assets/screenshot-ssrs-06.PNG)
