## load libraries

library(legislatoR)
library(dplyr)

# get information on MPs

uk_political <- legislatoR::get_political(legislature = "gbr")
uk_core <- legislatoR::get_core(legislature = "gbr")

uk_df <- merge(uk_core, uk_political, by = "pageid")

# select relevant legislative periods

uk_df <- uk_df %>% dplyr::select(name, wikidataid, pageid, ethnicity, religion, sex, birth, 
                                 death, birthplace, deathplace, session, party, constituency) %>% 
  filter(session>=45) %>% 
  rename(name_cld = name)
