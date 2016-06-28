![BlueGranite](https://raw.githubusercontent.com/BlueGranite/BlueGranite.github.io/master/assets/images/Blue-Granite-Logo.png)

#R Server on Spark with Azure HDInsight

There are two different ways to apply R in Power BI: the *R Script* for loading and transforming data, and the *R Visual* for additional enhancement and data visualization. The following tutorial walks through a basic scenario using both.

###Objectives
- Create an R Server on Azure HDInsight cluster
- Run a sample R script exploring the ability to change compute contexts

###Prerequisites
- An Azure subscription


###Activity 1 - Create an R Server on HDInsight Cluster
- In a browser, navigate to the Azure Portal at [https://portal.azure.com](https://portal.azure.com). Sign in with the Microsoft account associated with your Azure subscription if prompted.  
- Once in the Azure Portal, click *New* in the upper left menu, select *Data and Analytics*, and then select *HDInsight*.  
- Enter a unique *Cluster Name* and click on *Select Cluster Type*. Select the *R Server on Spark* option and click *Select*.  
- Configure the rest of the cluster options as required. When ready, click *Create*. It may take up to 40 minutes to create your cluster. While you wait, you will see a notification in the upper right corner showing progress.  

###Activity 2 - Run R Scripts on your Cluster
