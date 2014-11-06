# Load package
library(tm)

# Fit document term matrix
c <- Corpus(VectorSource(scripts))
dtm <- DocumentTermMatrix(c, control=list(stopwords=T, weighting=weightTfIdf))

# Find top terms
top.terms <- lapply(rowapply_simple_triplet_matrix(dtm, function(x) which(x > 0.02)), function(x) colnames(dtm)[x])
top.terms[[176]]
