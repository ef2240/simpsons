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

# Clean scripts
cleanScript <- function(char){
  char <- iconv(char, "latin1", "ASCII", "")
  end.intro <- regexpr("[ Screams ]", char, fixed=T)
  char <- substring(char, end.intro + attr(end.intro, "match.length"))
  cleaned <- gsub("\\t|\\r|\\[br\\]|<br>", " ", char, perl=T)
  cleaned <- gsub("\\[.*?\\]", " ", cleaned, perl=T)
  cleaned <- gsub("[[:punct:]]+ ", " ", cleaned, perl=T)
  cleaned <- gsub("\"|\'\'", " ", cleaned, perl=T)
  cleaned <- gsub("[[:space:]]{2,}", " ", cleaned, perl=T)
  cleaned <- gsub("[[:blank:]]+$|^[[:blank:]]+", "", cleaned, perl=T)
  cleaned <- tolower(cleaned)
  return(cleaned)
}
scripts.clean <- cleanScript(scripts)
