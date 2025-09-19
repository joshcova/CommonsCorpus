# Load libraries
library(tidyverse)
library(readxl)
library(lubridate)


data_dir <- "applications/" #change to your working directory

# Load data
salience_df <- read_excel(file.path(data_dir, "minimumwage_speech_df.xlsx"))
stance_df <- read_excel(file.path(data_dir, "minimumwage_stance_results.xlsx"))

# Define main parties
main_parties <- c("Labour Party", "Conservative Party")

# Define colors
party_colors <- c("PRO" = "blue", "CON" = "red")
salience_colors <- c("Labour Party" = "red", "Conservative Party" = "blue")


# ---- SALIENCE PLOT ----

salience_over_time <- salience_df %>%
  filter(party %in% main_parties) %>%
  mutate(year = year(date)) %>%
  count(year, party, name = "speech_count")

ggplot(salience_over_time, aes(x = year, y = speech_count, color = party)) +
  geom_smooth(se = FALSE, method = "loess", span = 0.2) +
  scale_color_manual(values = salience_colors) +
  scale_x_continuous(breaks = scales::breaks_width(5)) +
  labs(x = "Year", y = "Number of Speeches", color = "Party") +
  theme_minimal(base_size = 14) +
  labs(color = NULL) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(hjust = 0.5, size = 16),
    plot.subtitle = element_text(hjust = 0.5, color = "gray30"),
    legend.position = "bottom"
  )

# ---- STANCE PLOT ----
percentage_distribution <- stance_df %>%
  filter(party %in% main_parties, year(date) > 1990) %>%
  mutate(year = year(date)) %>%
  count(year, party, stance_label, name = "count") %>%
  mutate(count = as.numeric(count)) %>%
  group_by(year, party) %>%
  mutate(percentage = 100 * count / sum(count)) %>%
  ungroup() %>%
  filter(stance_label %in% c("PRO", "CON"))

ggplot(percentage_distribution, aes(x = year, y = percentage, color = stance_label)) +
  geom_smooth(se = FALSE, method = "loess", span = 0.3) +
  facet_wrap(~ party, ncol = 1) +
  scale_color_manual(values = party_colors, labels = c("PRO" = "Positive", "CON" = "Negative")) +
  scale_y_continuous(limits = c(0, 100), name = "Percentage of Mentions (%)") +
  scale_x_continuous(breaks = sort(unique(percentage_distribution$year)), name = "Year") +
  guides(color = guide_legend(nrow = 1)) +
  labs(color = NULL) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(hjust = 0.5, size = 16),
    strip.text = element_text(size = 14, face = "bold")
  )
