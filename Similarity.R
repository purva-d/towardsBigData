library(ggplot2)
library(tm)
library(devtools)
library(textreuse)

## load the corpus. 
## dataset folder contains 2 text files
my.corpus<-Corpus(DirSource(".//datasets",pattern = ".txt"))
## removing the stopwords
my.corpus<-tm_map(my.corpus,removeWords,stopwords("english"))

## term document matrix
my.tdm<-TermDocumentMatrix(my.corpus)
## document term matrix
my.dtm<-DocumentTermMatrix(my.corpus,control = list(weighting=weightTfIdf,stopWords=TRUE))

## to data frame
my.df<-as.data.frame(inspect(my.tdm))

## normalizing
my.df.scale<-scale(my.df)

## calculating euclidean distance as measure of similarity
d <- dist(my.df.scale,method="euclidean")

## hierarchical representation
fit <- hclust(d,method="ward.D")
plot(fit)
