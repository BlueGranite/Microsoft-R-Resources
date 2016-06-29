####### Set Local Context #######
rxSetComputeContext('local')

####### Hadoop Command #######
rxHadoopVersion()
rxHadoopMakeDir("/data/income/")
rxHadoopCopyFromLocal("~/income.csv", "/data/income/")
rxHadoopListFiles("/data", recursive = TRUE)

####### Load income.csv from Hadoop #######
incomepath <- file.path("/data/income/income.csv")
hdfsFS <-RxHdfsFileSystem()
incomedata <- RxTextData(incomepath, fileSystem = hdfsFS, stringsAsFactors = TRUE)
rxGetVarInfo(incomedata)

####### Create Logistic Regression Model #######
incomeformula <- "IncBin ~ age + education + race + sex"
model <- rxLogit(formula = incomeformula, data = incomedata)
summary(model)


####### Create Logistic Regression Model Using Local Parallel Context #######
rxSetComputeContext('localpar')
model <- rxLogit(formula = incomeformula, data = incomedata)
summary(model)


####### Create Logistic Regression Model Using Spark Context #######
spark <-RxSpark()
rxSetComputeContext(spark)
model <- rxLogit(formula = incomeformula, data = incomedata)
summary(model)
