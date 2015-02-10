# Load package
library(syuzhet)

# Run sentiment analysis
word.counts <- sapply(strsplit(episode.scripts$script, " "), length)
episode.nrc.sentiments <- get_nrc_sentiment(episode.scripts$script)
rownames(episode.nrc.sentiments) <- episode.scripts$title
episode.nrc.sentiments <- sweep(episode.nrc.sentiments, 1, word.counts, "/")
episode.nrc.sentiments <- data.frame(season=episode.scripts$season, episode.nrc.sentiments)
