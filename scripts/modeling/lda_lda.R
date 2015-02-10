# Load package
library(lda)

# Define vocab list
corpus <- lexicalize(episode.scripts$script)
wc <- word.counts(corpus$documents, corpus$vocab)
wc <- wc[wc > 1]
vocab.no.stopwords <- names(sort(wc, decreasing=T)[201:length(corpus$vocab)])
vocab.no.stopwords <- vocab.no.stopwords[nchar(vocab.no.stopwords) > 2]

# Fit lda
corpus.no.stopwords <- lexicalize(episode.scripts$script, vocab=vocab.no.stopwords)
lda.model <- lda.collapsed.gibbs.sampler(corpus.no.stopwords, K=50, vocab=vocab.no.stopwords, num.iterations=50, alpha=0.1, eta=0.1, trace=1L)
