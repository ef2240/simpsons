# Load packages
library(topicmodels)
library(tm)

# Fit LDA
c <- Corpus(VectorSource(scripts))
dtm <- DocumentTermMatrix(c)
lda <- LDA(dtm, k=50)
