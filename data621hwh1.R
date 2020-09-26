library(AppliedPredictiveModeling)
transparentTheme(trans = .4)
library(caret)
featurePlot(x = iris[, 1:4], 
            y = iris$Species, 
            plot = "pairs",
            ## Add a key at the top
            auto.key = list(columns = 3))
library(mlbench)
set.seed(200)
trainingData <- mlbench.friedman1(200, sd = 1)
## We convert the ' x ' data from a matrix to a data frame
## One reason is that this will give the columns names.
trainingData$x <- data.frame(trainingData$x)
## Look at the data using
featurePlot(trainingData$x, trainingData$y)
## or other methods.
## This creates a list with a vector ' y ' and a matrix
## of predictors ' x ' . Also simulate a large test set to
## estimate the true error rate with good precision:
testData <- mlbench.friedman1(5000, sd = 1)
testData$x <- data.frame(testData$x)



library(caret)
knnModel <- train(x = trainingData$x,
                  y = trainingData$y,
                  prProc = c("center", "scale"),
                  tuneLength = 10)

knnModel

knnPred <- predict(knnModel, newdata = testData$x)
## The function ' postResample ' can be used to get the test set
## perforamnce values
postResample(pred = knnPred, obs = testData$y)


