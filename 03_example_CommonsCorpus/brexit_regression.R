## clear environment

rm(list =  ls())

# load libraries

library(reshape2)
library(dplyr)
library(ggplot2)
library(modelsummary)
library(readxl)

# read in mapping for constituency-local authority district from the ONS's Open Geography Portal 

uk_mapping <- read.csv("./Ward_to_PCON_to_LAD_to_UTLA_(December_2023)_Lookup_in_the_UK.csv")

# Select only constituency and local authority district

uk_mapping <- uk_mapping %>% dplyr::select(PCON23NM, LAD23NM) %>% distinct(PCON23NM, .keep_all = T)

# read in average wage data (weekly wages)

wage_data <- read.csv("./gross_wage_LAD.csv", check.names = F)

wage_data <- merge(wage_data, uk_mapping, by = "LAD23NM")

wage_data <- reshape2::melt(wage_data, id.vars = c("LAD23NM"), variable.name = "year", value.name = "weekly_wage")

# read in local gdp data

local_gdp_data <- readxl::read_excel("./LAD_GDP_data.xlsx")
local_gdp_data <- local_gdp_data %>% select(-`ITL1 Region`, -`LA code`)

local_gdp_data <- reshape2::melt(local_gdp_data, id.vars = c("LA name"), variable.name = "year", value.name = "local_gdp", id.name = "LAD23NM")
local_gdp_data <- local_gdp_data %>% rename(LAD23NM = `LA name`)

local_gdp_data$year <- as.numeric(as.character(local_gdp_data$year))
local_gdp_data$local_gdp <- log(as.numeric(local_gdp_data$local_gdp))

econ_data <- merge(wage_data, local_gdp_data, by = c("LAD23NM", "year"))

# read in parliamentary data containing information on the salience of Brexit as well as 
# number of jobseekers' allowance/universal credit claimants at the constituency level

commons_corpus_brexit <- read.csv("./commons_corpus_brexit.csv")
commons_corpus_brexit <- commons_corpus_brexit %>% 
  mutate(party_2 = case_when(
    party %in% c("Labour Party", "Social Democratic and Labour Party", 
                 "Labour and Co-operative") ~ "Labour Party",
    party %in% c("Conservative Party") ~ "Conservative Party",
    party %in% c("Liberal Democrats") ~ "Liberal Democrats",
    T ~ "Others"
  )) %>% 
  rename(LAD23NM = constituency)

commons_corpus_brexit$year <- as.numeric(stringr::str_extract(commons_corpus_brexit$month_year, "^.{4}"))

commons_corpus_brexit <- merge(commons_corpus_brexit, econ_data, by = c("LAD23NM", "year"))

commons_corpus_brexit$weekly_wage <- as.numeric(commons_corpus_brexit$weekly_wage)

commons_corpus_brexit$unique_id <- paste(commons_corpus_brexit$Constituency, commons_corpus_brexit$Date, sep = "_")
commons_corpus_brexit <- commons_corpus_brexit %>% 
  distinct(unique_id, .keep_all = T)

commons_corpus_brexit <- commons_corpus_brexit %>% 
  mutate(Cons_Binary = case_when(party_2 == "Conservative Party" ~ "Conservative", 
                                 T ~ "Other"))

commons_corpus_brexit$party_2 <- as.factor(commons_corpus_brexit$party_2)
commons_corpus_brexit$party_2 <- relevel(commons_corpus_brexit$party_2, ref = "Others")

commons_corpus_brexit$Cons_Binary <- as.factor(commons_corpus_brexit$Cons_Binary)
commons_corpus_brexit$Cons_Binary <- relevel(commons_corpus_brexit$Cons_Binary, ref = "Other")

commons_corpus_brexit$count_monthly_speech <- commons_corpus_brexit$count_false + commons_corpus_brexit$count_true

commons_corpus_brexit$share_true <- commons_corpus_brexit$share_true*100

### summary statistics

commons_corpus_brexit_sum_statistics <- commons_corpus_brexit %>% 
  dplyr::select(share_true, local_gdp, weekly_wage, Value)

datasummary(All(commons_corpus_brexit_sum_statistics) ~ Mean + SD + Max + Min + Median, 
            data = commons_corpus_brexit_sum_statistics,
            output = "latex")

### regression analysis

mod0_a <- lm(I(share_true*100) ~ log(weekly_wage)  + Cons_Binary, data = commons_corpus_brexit)
mod0_b <- lm(I(share_true*100) ~ Value + Cons_Binary, data = commons_corpus_brexit)
mod0_c <- lm(I(share_true*100) ~ local_gdp + Cons_Binary, data = commons_corpus_brexit)
mod0_d <- lm(I(share_true*100) ~ log(weekly_wage) + Value + local_gdp + Cons_Binary, data = commons_corpus_brexit)

mods_list <- list(mod0_a, mod0_b, mod0_c, mod0_d)

modelplot(mods_list, stars = T, 
          coef_omit = c("Intercept"),
          coef_rename = c("Value"="Number of JSA/UC claimants",
                          "log(weekly_wage)"="Log Gross wage (week)",
                          "Cons_BinaryConservative" = "Conservative Party",
                          "local_gdp" = "Log GDP per capita"))

### regression analysis: interaction plot

commons_corpus_brexit$log_wage <- log(commons_corpus_brexit$weekly_wage)

mod_interaction <- lm(I(share_true*100) ~ log_wage*Cons_Binary, data = commons_corpus_brexit)

sjPlot::plot_model(mod_interaction, type = "pred", terms = c("log_wage", "Cons_Binary"))+
  labs(x="Weekly Gross Wage (log)", y="Share of parliamentary interventions on Brexit", title = "Salience on Brexit in Parliament as predicted by constituency weekly gross wage and partisanship of MP")+
  theme_minimal()+
  guides(color = guide_legend(title = "Party"))
