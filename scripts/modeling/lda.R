# Load package
library(topicmodels)

# Fit LDA
lda.model <- LDA(dtm.no.stopwords, k=50, method="Gibbs", control=list(verbose=5))
