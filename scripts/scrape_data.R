# Load package
library(RCurl)

# Get list of episodes
main.page <- getURL("http://www.springfieldspringfield.co.uk/episode_scripts.php?tv-show=the-simpsons")
episode.start.inds <- gregexpr("s[0-9]{2}e[0-9]{2}", main.page)[[1]]
all.episodes <- substring(main.page, episode.start.inds, episode.start.inds + attr(episode.start.inds, "match.length") - 1)

# Scrape episode scripts
all.urls <- sprintf("http://www.springfieldspringfield.co.uk/view_episode_scripts.php?tv-show=the-simpsons&episode=%s", all.episodes)
html.code <- sapply(all.urls, getURL)
html.code.split <- strsplit(html.code, "\n")
scripts <- sapply(html.code.split, function(x) x[203])

cleanScript <- function(char){
  cleaned <- gsub("\\t|\\r|\\[[[:alnum:]|[:space:]]*\\]|<br>", " ", char)
  cleaned <- gsub("-|\\.|\\?|\"|\'\'|!", " ", cleaned)
  cleaned <- gsub("[[:space:]]{2,}", " ", cleaned)
  cleaned <- tolower(cleaned)
  return(cleaned)
}
gsub("\\[[[:alnum:]|[:space:]]*\\]", " ", "Homer, when you forgive someone[br]you can't throw it back at them like that.<br>\r \r Aw, what a gyp.<br>\r \r - Mmm.<br>[br]- Remember when I--\r \r - Homer![br]- Oh, yeah.<br> I forgot already.<br>\r \r    <br> [ Groans ]- Well, that's nothing,because you have a gambling problem!")
