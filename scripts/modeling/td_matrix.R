# Load package
library(tm)
library(slam)

# Create corpus
c <- Corpus(VectorSource(episode.scripts$script))

# Create list of stopwords
dtm <- DocumentTermMatrix(c)
num.eps <- colapply_simple_triplet_matrix(dtm, function(x) sum(x > 0))
most.common.words <- names(sort(num.eps, decreasing = T)[1:250])
custom.stopwords <- unique(c(most.common.words, stopwords("SMART")))

# Find document term matrix
dtm.no.stopwords <- DocumentTermMatrix(c, list(stopwords=custom.stopwords, removeNumbers=T))

# Find tf-idf
tf.idf <- DocumentTermMatrix(c, control=list(stopwords=custom.stopwords, weighting=weightTfIdf, removeNumbers=T))

# Find top terms
top.terms <- lapply(rowapply_simple_triplet_matrix(tf.idf, function(x) which(x > 0.03)), function(x) colnames(tf.idf)[x])
