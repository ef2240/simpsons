# Load package
library(topicmodels)

# Fit LDA
lda.model <- LDA(dtm.no.stopwords, k=50, method="Gibbs", control=list(verbose=5, delta=0.01, iter=1000))
terms10 <- terms(lda.model, 10)
topics(lda.model, 2)
