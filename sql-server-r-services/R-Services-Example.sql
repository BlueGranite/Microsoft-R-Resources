/*
SQL SERVER R SERVICES SAMPLE

2016 BlueGranite

Showcases a basic example of adapting an R script and input for use in R Services
Companion to RevoScaleR-vs-Traditional.R logistic regression example
*/

--sp_configure 'external scripts enabled', 1;
--RECONFIGURE

USE WideWorldImportersDW
GO

--logit model adapted for SQL Server
EXEC sp_execute_external_script
@language = N'R',
@script = N'df <- InputDataSet
			order.logit <- rxLogit(SameDayFulfillment ~ city + item + picker + quantity, data = df)
			print(order.logit)',
@input_data_1 = N'SELECT CASE WHEN [Order Date Key] = [Picked Date Key]
                      THEN 1 ELSE 0 END AS SameDayFulfillment,
					  [City Key] AS city,
					  [Stock Item Key] AS item,
					  [Picker Key] AS picker,
					  [Quantity] AS quantity
                  FROM [Fact].[Order]
                  WHERE [WWI Order ID] >= 63968;'
GO

--embed model in a stored procedure
ALTER PROCEDURE sp_EmbeddedRSample AS
BEGIN
EXEC sp_execute_external_script
@language = N'R',
@script = N'order.logit <- rxLogit(SameDayFulfillment ~ city + item + picker + quantity, data = InputDataSet)
			OutputDataSet <- data.frame(as.raw(serialize(order.logit, connection=NULL)))',
@input_data_1 = N'SELECT CASE WHEN [Order Date Key] = [Picked Date Key]
                      THEN 1 ELSE 0 END AS SameDayFulfillment,
					  [City Key] AS city,
					  [Stock Item Key] AS item,
					  [Picker Key] AS picker,
					  [Quantity] AS quantity
                  FROM [Fact].[Order]
                  WHERE [WWI Order ID] >= 63968;'
WITH RESULT SETS ((model varbinary(max)))
END
GO

--Create table for model output and insert model into new table
IF OBJECT_ID('dbo.RServicesModels', 'U') IS NOT NULL 
	DROP TABLE dbo.RServicesModels
GO

CREATE TABLE dbo.RServicesModels (
	ModelName varchar(100) not null default('default model') primary key, 
	Model varbinary(max) not null)
INSERT INTO dbo.RServicesModels (Model)
EXEC sp_EmbeddedRSample 
GO

--SELECT Model FROM dbo.RServicesModels

--Create stored procedure for predicting same day fulfillment using the logit model
ALTER PROCEDURE sp_PredictRSample (@city int, @item int, @picker int, @quantity int)
AS 
	DECLARE @logitModel varbinary(max) = (SELECT TOP 1 Model FROM dbo.RServicesModels);
BEGIN
	EXEC sp_execute_external_script
		@language = N'R',
		@script = N'df <- InputDataSet
					model <- unserialize(logitModel)
					df$prediction <- rxPredict(model, data = df)
					df$prediction <- as.numeric(df$prediction)
					OutputDataSet <- df',
		@input_data_1 = N'SELECT @city as city, @item as item, @picker as picker, @quantity as quantity;',
		@params = N'@logitModel varbinary(max), @city int, @item int, @picker int, @quantity int',
		@logitModel = @logitModel,
		@city = @city,
		@item = @item,
		@picker = @picker,
		@quantity = @quantity
		WITH RESULT SETS (([City] int, [Item] int, [Picker] int, [Quantity] int, [PredictedSameDayFulfillment] float))
END
GO

--Execute sp_PredictRSample to predict same day fulfillment using sample data
DECLARE	@return_value int
EXEC	@return_value = [dbo].[sp_PredictRSample]
		@city = 44806,
		@item = 140,
		@picker = 20,
		@quantity = 200