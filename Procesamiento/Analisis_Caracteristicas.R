# Importacion del dataset
db_URLB <- read.csv("~/SDCAW/Preprocesamiento/resources/datasetAnomalous.csv", sep=";", comment.char="#")
db_URLG <- read.csv("~/SDCAW/Preprocesamiento/resources/dataset.csv", sep=";", comment.char="#")

# Mezcla de datasets

URLs <- merge(db_URLG,db_URLB)
b_URLB
