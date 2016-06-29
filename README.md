![BlueGranite](https://raw.githubusercontent.com/BlueGranite/BlueGranite.github.io/master/assets/images/Blue-Granite-Logo.png)

#Microsoft R Resources

Materials from BlueGranite's [Microsoft R: A Revolution in Advanced Analytics](https://www.blue-granite.com/webinar-microsoft-r-a-revolution-of-advanced-analytics) webinar




###[SQL Server 2016](https://github.com/BlueGranite/Microsoft-R-Resources/blob/master/sql-server-r-services/Readme.md)
The SQL Server R Services sample files utilize introductory R examples with the new Wide World Importers DW database. The demo utilizes a basic source query from the Fact.Orders table and shows how to work with the same data using R in both a traditional context as well as using RevoScaleR with various rx functions. Shifting to SQL, the same code can be adapted for use in SQL Server and embedded in stored procedures with minimal changes. The final component uses a Reporting Services (SSRS) report to connect to an embedded SQL stored procedure and plot the resulting histogram in SSRS.

In order to work through everything in the tutorial, you will need:

- Access to the RevoScaleR functions (i.e. by installing Microsoft R Client)

- Access to a version of SQL Server 2016 with R Services installed 

- The WideWorldImportersDW sample database on the SQL instance

- SQL Server Data Tools (for the Reporting Services content only)

| Category | Application | File Name |
| ------------- |:-:| :-:|
| R | R IDE (RStudio or R Tools for Visual Studio) | RevoScaleR-vs-Traditional.R |
| SQL | Management Studio or Data Tools | R-Services-Example.sql |
| Reporting Services | Data Tools | R-Services-Sample-Reports.zip |

*View the SQL Server 2016 [R Services Tutorial](https://github.com/BlueGranite/Microsoft-R-Resources/blob/master/sql-server-r-services/Tutorial.md)*  


###[Power BI](https://github.com/BlueGranite/Microsoft-R-Resources/blob/master/power-bi/Readme.md)

In order to work through the tutorial, you will need:

- Microsoft Power BI Desktop

| Category | Application | File Name |
| ------------- |:-:| :-:|
| Power BI  | Power BI Desktop | gameconsole.pbix |
| Data Source | Any text reader | gameconsole.csv |

*View the [Power BI Tutorial](https://github.com/BlueGranite/Microsoft-R-Resources/blob/master/power-bi/Tutorial.md)* 


###[R Server on HDInsight](https://github.com/BlueGranite/Microsoft-R-Resources/blob/master/hdinsight-r-server-spark/Readme.md)

In order to work through the tutorial, you will need:

- An Azure subscription
- SSH client such as PuTTY

| Category | Application | File Name |
| ------------- |:-:| :-:|
| R | RStudio (on R Server edge node) | HDInsight.R |
| Data Source | Any text reader | income.csv |

*View the [HDInsight Tutorial](https://github.com/BlueGranite/Microsoft-R-Resources/blob/master/hdinsight-r-server-spark/Tutorial.md)

  
  
### Additional Resources

######CRAN (Open-source R) - [https://cran.r-project.org/](https://cran.r-project.org/)

######Microsoft R Portal - [https://mran.revolutionanalytics.com/](https://mran.revolutionanalytics.com/)

######Getting Started with R - [https://mran.revolutionanalytics.com/documents/getting-started/](https://mran.revolutionanalytics.com/documents/getting-started/)

######Microsoft R Strategy - [http://www.zdnet.com/article/microsofts-r-strategy/](http://www.zdnet.com/article/microsofts-r-strategy/)

######R Server Home Page - [https://www.microsoft.com/en-us/server-cloud/products/r-server/](https://www.microsoft.com/en-us/server-cloud/products/r-server/)

######SQL Server 2016 E-Book - [https://blogs.msdn.microsoft.com/microsoft_press/2015/12/22/free-ebook-introducing-microsoft-sql-server-2016-mission-critical-applications-deeper-insights-hyperscale-cloud-preview-edition/](https://blogs.msdn.microsoft.com/microsoft_press/2015/12/22/free-ebook-introducing-microsoft-sql-server-2016-mission-critical-applications-deeper-insights-hyperscale-cloud-preview-edition/)

######Azure Data Science Virtual Machine - [https://azure.microsoft.com/en-us/marketplace/partners/microsoft-ads/standard-data-science-vm/](https://azure.microsoft.com/en-us/marketplace/partners/microsoft-ads/standard-data-science-vm/)

######Azure ML FAQ - [https://azure.microsoft.com/en-us/documentation/articles/machine-learning-faq/?cdn=disable](https://azure.microsoft.com/en-us/documentation/articles/machine-learning-faq/?cdn=disable)

######Azure ML Templates with SQL Server R Services - [https://gallery.cortanaintelligence.com/Collection/ML-Templates-with-SQL-Server-R-Services-1](https://gallery.cortanaintelligence.com/Collection/ML-Templates-with-SQL-Server-R-Services-1)

######Azure ML Fraud Detection Template - [https://gallery.cortanaintelligence.com/Collection/Online-Fraud-Detection-Template-1](https://gallery.cortanaintelligence.com/Collection/Online-Fraud-Detection-Template-1)

######R Server for HDInsight - [https://azure.microsoft.com/en-us/services/hdinsight/r-server/ ](https://azure.microsoft.com/en-us/services/hdinsight/r-server/)

######Create Power BI Visuals Using R - [https://powerbi.microsoft.com/en-us/documentation/powerbi-desktop-r-visuals/](https://powerbi.microsoft.com/en-us/documentation/powerbi-desktop-r-visuals/)

######Connected Cows presentation - [https://www.youtube.com/watch?v=oY0mxwySaSo ](https://www.youtube.com/watch?v=oY0mxwySaSo)

####BlueGranite Blogs

######Advanced Analytics

[http://www.blue-granite.com/blog/built-in-analytics-why-r-matters-to-a-sql-server-professional](http://www.blue-granite.com/blog/built-in-analytics-why-r-matters-to-a-sql-server-professional)

[http://www.blue-granite.com/blog/hiring-retention-with-predictive-analytics](http://www.blue-granite.com/blog/hiring-retention-with-predictive-analytics)

[http://www.blue-granite.com/blog/hands-on-labs-azure-ml] (http://www.blue-granite.com/blog/hands-on-labs-azure-ml)

[http://www.blue-granite.com/blog/top-6-use-cases-to-help-you-understand-big-data-analytics](http://www.blue-granite.com/blog/top-6-use-cases-to-help-you-understand-big-data-analytics)

######Data Lakes / Hadoop

[http://www.blue-granite.com/blog/5-reasons-to-get-excited-about-sql-server-2016-and-big-data](http://www.blue-granite.com/blog/5-reasons-to-get-excited-about-sql-server-2016-and-big-data)

[http://www.blue-granite.com/blog/apache-solr-3-analytic-use-cases](http://www.blue-granite.com/blog/apache-solr-3-analytic-use-cases)

[http://www.blue-granite.com/blog/make-big-data-easy-with-microsoft-azure-data-lake](http://www.blue-granite.com/blog/make-big-data-easy-with-microsoft-azure-data-lake)

[http://www.blue-granite.com/blog/demo-day-exploratory-analysis-spark-hdinsight](http://www.blue-granite.com/blog/demo-day-exploratory-analysis-spark-hdinsight)

######Power BI  / Azure

[http://www.blue-granite.com/blog/tour-of-the-power-bi-ecosystem](http://www.blue-granite.com/blog/tour-of-the-power-bi-ecosystem)

[http://www.blue-granite.com/blog/new-microsoft-power-bi-governance-and-deployment-whitepaper](http://www.blue-granite.com/blog/new-microsoft-power-bi-governance-and-deployment-whitepaper)

[http://www.blue-granite.com/blog/3-pointers-to-make-your-microsoft-power-bi-report-a-winner](http://www.blue-granite.com/blog/3-pointers-to-make-your-microsoft-power-bi-report-a-winner)

[http://www.blue-granite.com/blog/improve-the-effectiveness-of-your-bi-and-analytics-programs-with-a-data-catalog](http://www.blue-granite.com/blog/improve-the-effectiveness-of-your-bi-and-analytics-programs-with-a-data-catalog)

[http://www.blue-granite.com/blog/video-overview-of-microsoft-bi-reporting-tool-integration](http://www.blue-granite.com/blog/video-overview-of-microsoft-bi-reporting-tool-integration)

[http://www.blue-granite.com/blog/automate-pulling-in-life-changing-external-data-with-azure-logic-apps](http://www.blue-granite.com/blog/automate-pulling-in-life-changing-external-data-with-azure-logic-apps)

######SQL 2016

[http://www.blue-granite.com/blog/top-3-reasons-to-upgrade-to-sql-server-2016-reporting-services](http://www.blue-granite.com/blog/top-3-reasons-to-upgrade-to-sql-server-2016-reporting-services)

[http://www.blue-granite.com/blog/3-reasons-to-upgrade-to-sql-server-analysis-services-2016](http://www.blue-granite.com/blog/3-reasons-to-upgrade-to-sql-server-analysis-services-2016)

[http://www.blue-granite.com/blog/top-3-reasons-to-upgrade-your-analytics-environment-to-sql-server-2016](http://www.blue-granite.com/blog/top-3-reasons-to-upgrade-your-analytics-environment-to-sql-server-2016)

