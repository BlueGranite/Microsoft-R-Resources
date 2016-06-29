![BlueGranite](https://raw.githubusercontent.com/BlueGranite/BlueGranite.github.io/master/assets/images/Blue-Granite-Logo.png)

#R in Microsoft Power BI Tutorial

There are two different ways to apply R in Power BI: the *R Script* for loading and transforming data, and the *R Visual* for additional enhancement and data visualization. The following tutorial walks through a basic scenario using both.

###Objectives
- Configure R in Power BI
- Use the R Script for loading data
- Create an R Visual

###Prerequisites
- Download and install the free [Microsoft Power BI Desktop](https://powerbi.microsoft.com/en-us/desktop) application.
- A local R installation (such as [Microsoft R Open](https://mran.revolutionanalytics.com/open)).


###Activity 1 - Configure R in Power BI
- The first time you use Power BI, you will need to locate your local R installation. This is a one-time setup unless you upgrade R in the future.  
- Open Power BI Desktop. Close the startup window with *Get Data*, recent files, etc. if it appears.  
- Go to *File*, select *Options and settings*, and then select *Options*.  
- Under the *Global* heading, select *R Scripting*. Power BI attempts to automatically detect a local R installation. If you have multiple versions of R installed, you can select an alternate version from the menu.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-config-01.PNG)

- Click *OK* when done.  


###Activity 2 - Load Data with R Script
- From the main report canvas, select *Get Data* on the *Home* tab, then select *More...*.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-script-01.PNG)

- Choose *R Script* from the list of data sources and then click *Connect*.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-script-02.PNG)

- Copy and paste the following code into the *Execute R Script* window, then click OK. This code simply references a remote CSV file and loads it into a data frame without transforming it in any way. In the real world, to take true advantage of the R Script, you can do some more advanced data cleansing and transformation with R prior to executing the script. 
```R
source <- "https://cdn.rawgit.com/BlueGranite/Microsoft-R-Resources/master/power-bi/gameconsole.csv"  
game.console <- read.csv(source, header = TRUE)
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-script-03.PNG)  

- On the *Navigator* window, check the box next to *game.console* and then click *Load*. You should see "game console" appears in the "Fields" panel with three fields: Console, Date, and Search.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-script-04.PNG)


###Activity 3 - Plot a Time Series Forecast with R Visual
- Click on the *R* visual in the *Visualizations* panel. You may also receive a message stating that you need to Enable Script Visuals. If so, select *Enable*. An *R script editor* appears on the report canvas. A message states that you need to drag fields into the Values area.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-visual-01.PNG)

- Drag *Console*, *Date*, and *Search* from the Fields panel into *Values*. Note that the R script editor changes to show these fields and adds them to a data frame.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-visual-02.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-visual-03.PNG)

- Copy and paste the following code into the *R script editor*, then click *Run*. (Note that you may need to first install the *forecast* package in your local R environment using *install.packages("forecast")* ). After a few seconds, you should see a plot display on the report.  
```R
library(forecast)

# group searches by date
dataset <- aggregate(Search ~ Date, data = dataset, FUN= sum)

# create a time series based on month
ts <- ts(dataset$Search, frequency=4)

# pull out the seasonal, trend, and irregular components from the time series (train the forecast model)
decom <- stl(ts, s.window = "periodic")

# predict the next 3 months of searches
pred <- forecast(decom, h = 12)

# plot the predicted searches
plot(pred)
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-visual-04.PNG)

- Add a second R visual to the report canvas and drag the *Console*, *Date*, and *Search* from the Fields panel into *Values*.
- Copy and paste the following code into the new *R script editor*, then click *Run*. This script also requires the *forecast* package. After a few seconds, you should see a plot display on the report.
```R
library(forecast)

# group searches by date
dataset <- aggregate(Search ~ Date, data = dataset, FUN= sum)

# create a time series based on month
ts <- ts(dataset$Search, frequency=4)

# pull out the seasonal, trend, and irregular components from the time series (train the forecast model)
decom <- stl(ts, s.window = "periodic")

plot(decom)
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-visual-05.PNG)

- Add a Slicer visualization to the report canvas and add *Console* to the slicer's *Values*. Check the box next to each of the three gaming consoles to see how the forecast changes for each.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-visual-06.PNG)
