![BlueGranite](https://raw.githubusercontent.com/BlueGranite/BlueGranite.github.io/master/assets/images/Blue-Granite-Logo.png)

#R Server on Azure HDInsight

R Server on Azure HDInsight is a convenient way to utilize R in a distributed environment. In the following tutorial, you will create an HDInsight cluster that includes R Server using the Azure Portal. You will then install RStudio on the R Server edge node. Finally, you will use R to manage HDFS resources, change compute contexts, and build models under each context. General familiarity with HDInsight, HDFS, and R is assumed.

###Objectives
- Create an R Server on Azure HDInsight cluster
- Install RStudio on the cluster
- Run a sample R script exploring the ability to work with Hadoop commands, change compute contexts, and build models

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
- Follow the instructions from Azure documentation to [install R Studio](https://azure.microsoft.com/en-us/documentation/articles/hdinsight-hadoop-r-server-install-r-studio/) on your R Server edge node. You will need to wait for your cluster to be ready before you can proceed with these steps. You will also need your SSH client installed to connect to the cluster.
- After completing the steps from Azure documentation, be sure to leave R Studio open in your browser at localhost:8787.

###Activity 3 - Use R to Manage Hadoop and Build Models under Different Compute Contexts
R Server on HDInsight offers processing under a variety of compute contexts such as Local, Local Parallel, and Spark. In this activity, you will explore changing between different contexts and building logistic regression models under each.
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-04.PNG)  

- Enter the following command into your SSH client while it is connected to the R Server edge node. This copies the income.csv file to your cluster's storage. Optionally, you can also verify that income copied correctly by typing *ls* into the console after having run the *wget* command.
```
wget https://cdn.rawgit.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/income.csv
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-05.PNG)  

- Open the tutorial's *[HDInsight.R](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/HDInsight.R)* script in RStudio at localhost:8787 (or copy and paste the code in this tutorial as needed). 
- Run the following R code to reset the compute context to Local if needed. Note the *rx* prefix, which means that you are using a ScaleR function.
```R
rxSetComputeContext('local')
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-06.PNG)  

- Run the following R code to check the Hadoop version.
```R
rxHadoopVersion()
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-07.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-08.PNG)  

- Run the following R code in sequence to make a new directory in HDFS, copy the income.csv file (that you downloaded earlier using your SSH client) into the directory, and list the directory contents. Note that you used the *rxHadoop[...]* commands instead of standard shell commands such as *mkdir* and *ls*.
```R
rxHadoopMakeDir("/data/income/")
rxHadoopCopyFromLocal("~/income.csv", "/data/income/")
rxHadoopListFiles("/data", recursive = TRUE)
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-09.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-10.PNG)  

- Run the following R code in sequence to set the file path, verify that you are reading from HDFS, build a text object from the CSV file, and then view the structure of the object.
```R
incomepath <- file.path("/data/income/income.csv")
hdfsFS <-RxHdfsFileSystem()
incomedata <- RxTextData(incomepath, fileSystem = hdfsFS, stringsAsFactors = TRUE)
rxGetVarInfo(incomedata)
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-11.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-12.PNG)  

- Run the following R code in sequence to build a logistic regression model under the Local context.
```R
incomeformula <- "IncBin ~ age + education + race + sex"
model <- rxLogit(formula = incomeformula, data = incomedata)
summary(model)
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-13.PNG)  
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-14.PNG)

- Run the following R code in sequence to switch to Local Parallel and build a logistic regression model in the new context.
```R
rxSetComputeContext('localpar')
model <- rxLogit(formula = incomeformula, data = incomedata)
summary(model)
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-15.PNG) 

- Run the following R code in sequence to switch to Spark and build a logistic regression model in the new context.
```R
spark <-RxSpark()
rxSetComputeContext(spark)
model <- rxLogit(formula = incomeformula, data = incomedata)
summary(model)
```
![](https://raw.githubusercontent.com/BlueGranite/Microsoft-R-Resources/master/hdinsight-r-server-spark/tutorial-assets/screenshot-hdi-cluster-16.PNG)
