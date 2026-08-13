#O tutoria da Kelly Hidalgo (https://github.com/khidalgo85/Binning) foi utilizado como referência

setwd("/home/freitas/Work/LBMM/EvoEcoBio/minHash")

#Importa os pacotes
library(dplyr)
library(stringr)
library(tidyverse)
library(pheatmap)

#Importa o arquivo com as distâncias obtidas no MinHash
data <- read.table("distancias.tsv", comment.char = '', 
                   header = TRUE ) %>% 
  rename(X = X.query) 

#Deixa apenas os nomes das amostras
data$X <- str_remove_all(data$X, "minhash/")
data$X <- str_remove_all(data$X, ".fastq.gz")

names <- c("X", data[,1])

#Altera o nome das colunas
colnames(data) <- names

#Transforma a coluna X em nomes das linhas
data <- column_to_rownames(data, var="X")

#Cria o heatmap
pheatmap(data)