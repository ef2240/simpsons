# Load package
library(RCurl)

# Get list of episodes
main.page <- getURL("http://www.springfieldspringfield.co.uk/episode_scripts.php?tv-show=the-simpsons")
episode.start.inds <- gregexpr("s[0-9]{2}e[0-9]{2}", main.page)[[1]]
all.episodes <- substring(main.page, episode.start.inds, episode.start.inds + attr(episode.start.inds, "match.length") - 1)

# Scrape episode scripts
all.urls <- sprintf("http://www.springfieldspringfield.co.uk/view_episode_scripts.php?tv-show=the-simpsons&episode=%s", all.episodes)
html.code <- sapply(all.urls, getURL)
rows <- strsplit(html.code, "\n")
scripts <- sapply(rows, function(x) x[203])