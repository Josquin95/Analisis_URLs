# Importacion del dataset
db_URLB <- read.csv("~/SDCAW/Preprocesamiento/resources/datasetAnomalous.csv", sep=";", comment.char="#")
db_URLG <- read.csv("~/SDCAW/Preprocesamiento/resources/dataset.csv", sep=";", comment.char="#")

# Eliminacion de columnas URL, Peticion, host, coneccion, cockie
column_remove <- c(1,2,24,25,26)
atributos <- db_URLB[,-column_remove]
atributos <- as.matrix(as.data.frame(atributos))

#install.packages("kohonen")
library(kohonen)

# Crear kohonen som
atributos.grid <- somgrid(xdim = 5, ydim = 5, topo = "rectangular")

set.seed(2)
atributos.som <- som(atributos,
                     grid = atributos.grid,
                     rlen = 300,
                     alpha = c(0.1,0.01),
                     keep.data = TRUE,
                     n.hood = "circular",
                     toroidal = TRUE)

summary(atributos.som)


plot(atributos.som, type="changes") #shows if learning convergence has been achieved
plot(atributos.som, type="counts")  #shows how many samples are in each cell
plot(atributos.som, type="codes") #shows the weights of the samples on each node (unsuitable for more than 4 dims)
plot(atributos.som, type="quality")  #the U-matrix.
plot(atributos.som, type="dist.neighbours")
plot(atributos.som, type="property", property=atributos.som$codes[,1],
     main=colnames(atributos.som$data)[1]) #shows the heatmap of a given input variable
plot(atributos.som, type="property", property=atributos.som$codes[,2],
     main=colnames(atributos.som$data)[2]) #shows the heatmap of a given input variable
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[3]) #shows the heatmap of a given input variable
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[4])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[5])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[6])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[7])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[8])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[9])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[10])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[11])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[12])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[13])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[14])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[15])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[16])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[17])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[18])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[19])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[20])
plot(atributos.som, type="property", property=atributos.som$codes[,3],
     main=colnames(atributos.som$data)[21])

atributos.hclust <- hclust(dist(atributos.som$codes))
plot(atributos.hclust, hang = -1)

num_clusters <- 6
atributos.clusters <- cutree(atributos.hclust, num_clusters)

plot(atributos.som, type="mapping", 
     bgcol = rainbow(num_clusters, alpha = 1)[atributos.clusters], main = "Kohonen SOM") 
add.cluster.boundaries(atributos.som, atributos.clusters)
