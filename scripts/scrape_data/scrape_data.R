# Scrape and clean scripts
source("scripts/scrape_data/scrape_scripts.R")
episode.ids <- scrapeEpisodeIDs()
episode.webpages <- scrapePages(episode.ids)
scripts <- extractScripts(episode.webpages, episode.ids)

# Save data
save(episode.ids, episode.webpages, scripts, file="data/scripts.RData")
