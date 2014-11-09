# Load package
library(XML)

# Scrape wikipedia pages
scrapeInfo <- function(seasons){
  urls <- sprintf("http://en.wikipedia.org/wiki/The_Simpsons_(season_%d)", seasons)
  pages <- lapply(urls, readHTMLTable, stringsAsFactors=F)
  episode.dfs <- lapply(pages, function(x) x[[2]])
  return(episode.dfs)
}

# Extract episode info
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
