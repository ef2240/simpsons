# Load package
library(RCurl)

# Get list of episodes
scrapeEpisodeIDs <- function(){
  main.page <- getURL("http://www.springfieldspringfield.co.uk/episode_scripts.php?tv-show=the-simpsons")
  episode.start.inds <- gregexpr("s[0-9]{2}e[0-9]{2}", main.page)[[1]]
  episode.ids <- substring(main.page, episode.start.inds, episode.start.inds + attr(episode.start.inds, "match.length") - 1)
  return(episode.ids)
}

# Scrape episode pages
scrapePages <- function(episode.ids){
  all.urls <- sprintf("http://www.springfieldspringfield.co.uk/view_episode_scripts.php?tv-show=the-simpsons&episode=%s", episode.ids)
  html.code <- sapply(all.urls, getURL)
  return(html.code)
}

# Extract and clean scripts
extractScripts <- function(html.code, episode.ids){
  html.code.split <- strsplit(html.code, "\n")
  scripts <- sapply(html.code.split, function(x) x[203])
  scripts.clean <- cleanScript(scripts)
  names(scripts.clean) <- episode.ids
  return(scripts.clean)
}

# Function to clean scripts
cleanScript <- function(char){
  char <- iconv(char, "latin1", "ASCII", "")
  end.intro <- regexpr("\t\t\t *D'oh!|\\(tires screeching\\)\r  D'oh!|\r \r D'oh!|\t\t\t1\r D'oh!\r|\r  D'oh!\r|\\(playing the blues\\) D'oh!|D'oh! \\(tires screech|\\[ Groans \\]\r - D'oh!|\\[ Tires Screeching \\]\r D'oh!|\\(gasps\\) D'oh!|\t\t\tAh! D'oh!|\t\t\tOoh! D'oh! * \\)*|\t\t\t\r D'oh!|\r \r - D'oh!", substring(char, 1, 250), perl=T)
  char <- substring(char, end.intro + attr(end.intro, "match.length"))
  cleaned <- gsub("\\t|\\r|\\[br\\]|<br>|\\|", " ", char, perl=T)
  cleaned <- gsub("\\[.*?\\]|\\(.*?\\)", " ", cleaned, perl=T)
  cleaned <- gsub("[[:punct:]]+ ", " ", cleaned, perl=T)
  cleaned <- gsub("-|\"|\'\'", " ", cleaned, perl=T)
  cleaned <- gsub("[[:space:]]{2,}", " ", cleaned, perl=T)
  cleaned <- gsub("[[:blank:]]+$|^[[:blank:]]+", "", cleaned, perl=T)
  cleaned <- tolower(cleaned)
  cleaned <- gsub(" shh$", "", cleaned, perl=T)
  cleaned[nchar(cleaned) < 1000] <- NA
  return(cleaned)
}
