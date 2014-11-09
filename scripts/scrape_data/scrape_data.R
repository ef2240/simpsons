# Scrape episode info
source("scripts/scrape_data/scrape_episode_info.R")
seasons <- 1:25
episode.dfs <- scrapeInfo(seasons)
episode.info <- mapply(FUN=cleanDFs, episode.dfs, seasons, SIMPLIFY=F)
episode.info <- do.call(rbind, episode.info)

# Scrape and clean scripts
source("scripts/scrape_data/scrape_scripts.R")
episode.webpages <- scrapePages(episode.info$episode.id)
scripts <- extractScripts(episode.webpages, episode.info$episode.id)

# Remove missing scripts
scripts <- scripts[!is.na(scripts)]

# Merge scripts with episode info
scripts.df <- data.frame(episode.id=names(scripts), script=scripts, stringsAsFactors=F)
episode.scripts <- merge(episode.info, scripts.df)

# Save data
save(episode.webpages, file="data/script_webpages.RData")
save(episode.scripts, file="data/scripts.RData")
