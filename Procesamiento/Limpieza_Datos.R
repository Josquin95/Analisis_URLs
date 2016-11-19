
## Outliers

#install.packages("outliers")
#install.packages("ggplot2")
library(outliers)
library(ggplot2)

outlier_url <- function(dataset,variablA,variableB){
  plot <- ggplot(dataset,aes(as.factor(variablA),variableB))
  plot <- plot + geom_boxplot(aes(as.factor(variablA), variableB), outlier.colour = "red",
                              outlier.shape = 1) + labs(jtitle = "Outliers Peticion", x = "Dataset ", y = "Tamaño ")
  return(plot)
}

formato_url <- function(dataset){
  dataset <- as.data.frame(dataset)
  dataset$Peticion <- as.factor(dataset$Peticion)
  dataset$URL <- as.character(dataset$URL)
  dataset$URL_Length <- as.numeric(dataset$URL_Length)
  dataset$EXE <- as.numeric(dataset$EXE)
  dataset$JAVA <- as.numeric(dataset$JAVA)
  dataset$OLD <- as.numeric(dataset$OLD)
  dataset$BAK <- as.numeric(dataset$BAK)
  dataset$Admiracion <- as.numeric(dataset$Admiracion)
  dataset$ComillasDobles <- as.numeric(dataset$ComillasDobles)
  dataset$Numeral <- as.numeric(dataset$Numeral)
  dataset$Pesos <- as.numeric(dataset$Pesos)
  dataset$Porcentaje <- as.numeric(dataset$Porcentaje)
  dataset$Ampersand <- as.numeric(dataset$ComillaSimple)
  dataset$ParantesisAbierto <- as.numeric(dataset$ParantesisAbierto)
  dataset$ParentesisCerrado <- as.numeric(dataset$ParentesisCerrado)
  dataset$Asterisco <- as.numeric(dataset$Asterisco)
  dataset$Mas <- as.numeric(dataset$Mas)
  dataset$Coma <- as.numeric(dataset$Coma)
  dataset$Menos <- as.numeric(dataset$Menos)
  dataset$Punto <- as.numeric(dataset$Punto)
  dataset$Slash <- as.numeric(dataset$Slash)
  dataset$TotalCaracteres <- as.numeric(dataset$TotalCaracteres)
  dataset$Host <- as.character(dataset$Host)
  dataset$Cookie <- as.character(dataset$Cookie)
  dataset$Connection <- as.character(dataset$Connection)
}




