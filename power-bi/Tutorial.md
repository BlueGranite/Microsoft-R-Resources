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
1. The first time you use Power BI, you will need to locate your local R installation. This is a one-time setup unless you upgrade R in the future.  
2. Open Power BI Desktop. Close the startup window with *Get Data*, recent files, etc. if it appears.  
3. Go to *File*, select *Options and settings*, and then select *Options*.  
4. Under the *Global* heading, select *R Scripting*. Power BI attempts to automatically detect a local R installation. If you have multiple versions of R installed, you can select an alternate version from the menu.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-config-01.PNG)

5. Click *OK* when done.  


###Activity 2 - Load Data with R Script
1. From the main report canvas, select *Get Data* on the *Home* tab, then select *More...*.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-script-01.PNG)

2. Choose *R Script* from the list of data sources and then click *Connect*.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-script-02.PNG)

3. Copy and paste the following code into the *Execute R Script* window, then click OK. This code simply references a remote CSV file and loads it into a data frame without transforming it in any way. In the real world, to take true advantage of the R Script, you can do some more advanced data cleansing and transformation with R prior to executing the script. 
```R
source <- "https://cdn.rawgit.com/BlueGranite/Microsoft-R-Resources/master/power-bi/gameconsole.csv"  
game.console <- read.csv(source, header = TRUE)
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-script-03.PNG)  

4. On the *Navigator* window, check the box next to *game.console* and then click *Load*. You should see "game console" appears in the "Fields" panel with three fields: Console, Date, and Search.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-script-04.PNG)


###Activity 3 - Plot a Time Series Forecast with R Visual
1. Click on the *R* visual in the *Visualizations* panel. You may also receive a message stating that you need to Enable Script Visuals. If so, select *Enable*. An *R script editor* appears on the report canvas. A message states that you need to drag fields into the Values area.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-visual-01.PNG)

2. Drag *Console*, *Date*, and *Search* from the Fields panel into *Values*. Note that the R script editor changes to show these fields and adds them to a data frame.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-visual-02.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-visual-03.PNG)

3. Copy and paste the following code into the *R script editor*, then click *Run*. After a few seconds, you should see a plot display on the report.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/power-bi/tutorial-assets/screenshot-pbi-visual-04.PNG)
