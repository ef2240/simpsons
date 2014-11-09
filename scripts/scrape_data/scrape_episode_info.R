# Load package
library(XML)

# Scrape wikipedia pages
seasons <- 1:25
urls <- sprintf("http://en.wikipedia.org/wiki/The_Simpsons_(season_%d)", seasons)
pages <- lapply(urls, readHTMLTable, stringsAsFactors=F)

# Extract episode info
episode.dfs <- lapply(pages, function(x) x[[2]])
cleanDFs <- function(df, season){
  descs <- df[seq(2, nrow(df), 2), 1]
  rows <- df[seq(1, nrow(df), 2), ]
  descs.cleaned <- gsub("\\[.+?\\]", "", descs)
  episode.id <- sprintf("s%02de%02d", season, as.numeric(rows$"No. in\nseason"))
  df.info <- data.frame(episode.id,
                        season,
                        num.in.season=as.numeric(rows$"No. in\nseason"),
                        num.in.series=as.numeric(rows$"No. in\nseries"),
                        title=rows$Title,
                        description=descs.cleaned,
                        stringsAsFactors=F
  )
}
episode.info <- mapply(FUN=cleanDFs, episode.dfs, seasons, SIMPLIFY=F)
episode.info <- do.call(rbind, episode.info)

# Save workspace
save(episode.info, file="data/episode_info.RData")
