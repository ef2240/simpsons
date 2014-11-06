# Load package
library(topicmodels)

# Fit LDA
lda.model <- LDA(dtm, k=50)
terms(lda.model, 5)
