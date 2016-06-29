![BlueGranite](https://raw.githubusercontent.com/BlueGranite/BlueGranite.github.io/master/assets/images/Blue-Granite-Logo.png)

#R Server on Spark with Azure HDInsight

There are two different ways to apply R in Power BI: the *R Script* for loading and transforming data, and the *R Visual* for additional enhancement and data visualization. The following tutorial walks through a basic scenario using both.

###Objectives
- Create an R Server on Azure HDInsight cluster
- Run a sample R script exploring the ability to change compute contexts

###Prerequisites
- An Azure subscription
- An SSH client such as [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)


###Activity 1 - Create an R Server on HDInsight Cluster
- In a browser, navigate to the Azure Portal at [https://portal.azure.com](https://portal.azure.com). Sign in with the Microsoft account associated with your Azure subscription if prompted.  
- Once in the Azure Portal, click *New* in the upper left menu, select *Data and Analytics*, and then select *HDInsight*.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-01.PNG)

- Enter a unique *Cluster Name* and click on *Select Cluster Type*. Select the *R Server on Spark* option and click *Select*.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-02.PNG)

- Under *Credentials*, enter separate logins for the cluster admin and SSH user. Remember the SSH credentials since you will need these later to connect to your cluster. When ready, click *Select*.  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-03.PNG)

- Configure the rest of the cluster options as required. When ready, click *Create* at the bottom of the panel. It may take up to 40 minutes to create your cluster. While you wait, you will see a notification in the upper right corner showing progress.  

###Activity 2 - Install R Studio on the R Server Edge Node
- Follow the instructions from Azure documentation to [install R Studio](https://azure.microsoft.com/en-us/documentation/articles/hdinsight-hadoop-r-server-install-r-studio/) on your R Server edge node. You will need to wait for your cluster to be ready before you can proceed with these steps, and you will also need your SSH client available to connect.
- After completing the steps from Azure documentation, be sure to leave R Studio open in your browser at localhost:8787.

###Activity 3 - Use R to Manage Hadoop and Build Models under Different Compute Contexts
R Server on HDInsight offers processing under a variety of compute contexts. In this activity, you will explore changing between different contexts and building logistic regression models under each.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-04.PNG)  

- Enter the following command into your SSH client while it is connected to the R Server edge node. This copies the income.csv file to your cluster's storage. Optionally, you can also verify that income copied correctly by typing *ls* into the console after having run the *wget* command.
```
wget https://cdn.rawgit.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/income.csv
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-05.PNG)  

- Open the tutorial's *HDInsight.R* script in RStudio at localhost:8787. 
- Run the following command to reset the compute context to Local if needed.
```R
rxSetComputeContext('local')
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-06.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-07.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-08.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-09.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-10.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-11.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-12.PNG)  
