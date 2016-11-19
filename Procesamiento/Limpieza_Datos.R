## Limpieza datos
dataset_B <- read.csv("~/SDCAW/Preprocesamiento/resources/dataset_B.csv", sep=";")

## Outliers

#install.packages("outliers")
#install.packages("ggplot2")
library(outliers)
library(ggplot2)

outlier_url <- function(dataset,variablA,variableB){
  plot <- ggplot(dataset,aes(as.factor(variablA),variableB))
  plot <- plot + geom_boxplot(aes(as.factor(variablA), variableB), outlier.colour = "red",
                              outlier.shape = 1) + labs(title = "Outliers Peticion", x = "Dataset ", y = "Tamaño ")
  return(plot)
}


