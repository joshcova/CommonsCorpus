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


### read in the unique speakers data from the TWFY repository divided by legislative terms (see unique_speakers_TWFY.ipynb)

uk_45 <- read.csv("./unique_speaker_45.csv")
uk_cld_45 <- uk_df_cam %>% dplyr::filter(session==45)

n_missing_45 <- nrow(uk_cld_45) - nrow(uk_45)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_45, ncol = ncol(uk_45)))
colnames(na_rows) <- colnames(uk_45)

uk_45_padded <- rbind(uk_45, na_rows)
combined_df_45 <- cbind(uk_45_padded, uk_cld_45)

write.csv(combined_df_45, "./combined_df_45.csv")

### LEGISLATURE 46

uk_46 <- read.csv("./unique_speaker_46.csv")
uk_cld_46 <- uk_df_cam %>% dplyr::filter(session==46)

n_missing_46 <- nrow(uk_cld_46) - nrow(uk_46)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_46, ncol = ncol(uk_46)))
colnames(na_rows) <- colnames(uk_46)

uk_46_padded <- rbind(uk_46, na_rows)
combined_df_46 <- cbind(uk_46_padded, uk_cld_46)

write.csv(combined_df_46, "./combined_df_46.csv")

### LEGISLATURE 47


uk_47 <- read.csv("./unique_speaker_47.csv")
uk_cld_47 <- uk_df_cam %>% dplyr::filter(session==47)

n_missing_47 <- nrow(uk_cld_47) - nrow(uk_47)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_47, ncol = ncol(uk_47)))
colnames(na_rows) <- colnames(uk_47)

uk_47_padded <- rbind(uk_47, na_rows)
combined_df_47 <- cbind(uk_47_padded, uk_cld_47)

write.csv(combined_df_47, "./combined_df_47.csv")

### LEGISLATURE 48

uk_48 <- read.csv("./unique_speaker_48.csv")
uk_48_B <- read.csv("./unique_speaker_48_B.csv")
uk_48 <- rbind(uk_48, uk_48_B) %>% distinct(twfy_member_id, .keep_all = T)
uk_cld_48 <- uk_df_cam %>% dplyr::filter(session==48)

n_missing_48 <- nrow(uk_48) - nrow(uk_cld_48)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_48, ncol = ncol(uk_cld_48)))
colnames(na_rows) <- colnames(uk_cld_48)

uk_cld_48_padded <- rbind(uk_cld_48, na_rows)
combined_df_48 <- cbind(uk_cld_48_padded, uk_48)

write.csv(combined_df_48, "./combined_df_48.csv")

### LEGISLATURE 49

uk_49 <- read.csv("./unique_speaker_49.csv")
uk_cld_49 <- uk_df_cam %>% dplyr::filter(session==49)

n_missing_49 <- nrow(uk_cld_49) - nrow(uk_49)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_49, ncol = ncol(uk_49)))
colnames(na_rows) <- colnames(uk_49)

uk_49_padded <- rbind(uk_49, na_rows)
combined_df_49 <- cbind(uk_49_padded, uk_cld_49)

write.csv(combined_df_49, "./combined_df_49.csv")

### LEGISLATURE 50

uk_50 <- read.csv("./unique_speaker_50.csv")
uk_50_B <- read.csv("./unique_speaker_50_B.csv")
uk_50 <- rbind(uk_50, uk_50_B) %>% distinct(twfy_member_id, .keep_all = T)

uk_cld_50 <- uk_df_cam %>% dplyr::filter(session==50)
n_missing_50 <- nrow(uk_50) - nrow(uk_cld_50)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_50, ncol = ncol(uk_cld_50)))
colnames(na_rows) <- colnames(uk_cld_50)

uk_cld_50_padded <- rbind(uk_cld_50, na_rows)
combined_df_50 <- cbind(uk_cld_50_padded, uk_50)

write.csv(combined_df_50, "./combined_df_50.csv")

### LEGISLATURE 51

uk_51 <- read.csv("./unique_speaker_51.csv")
uk_cld_51 <- uk_df_cam %>% dplyr::filter(session==51)

n_missing_51 <- nrow(uk_51) - nrow(uk_cld_51)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_51, ncol = ncol(uk_cld_51)))
colnames(na_rows) <- colnames(uk_cld_51)

uk_cld_51_padded <- rbind(uk_cld_51, na_rows)
combined_df_51 <- cbind(uk_cld_51_padded, uk_51)

write.csv(combined_df_51, "./combined_df_51.csv")

### LEGISLATURE 52

uk_52 <- read.csv("./unique_speaker_52.csv")
uk_52_B <- read.csv("./unique_speaker_52_B.csv")
uk_52 <- rbind(uk_52, uk_52_B) %>% distinct(twfy_member_id, .keep_all = T)

uk_cld_52 <- uk_df_cam %>% dplyr::filter(session==52)
n_missing_52 <- nrow(uk_52) - nrow(uk_cld_52)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_52, ncol = ncol(uk_cld_52)))
colnames(na_rows) <- colnames(uk_cld_52)

uk_cld_52_padded <- rbind(uk_cld_52, na_rows)
combined_df_52 <- cbind(uk_cld_52_padded, uk_52)

write.csv(combined_df_52, "./combined_df_52.csv")


#### LEGISLATURE 53

uk_53 <- read.csv("./unique_speaker_53.csv")
uk_cld_53 <- uk_df_cam %>% dplyr::filter(session==53)

n_missing_53 <- nrow(uk_53) - nrow(uk_cld_53)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_53, ncol = ncol(uk_cld_53)))
colnames(na_rows) <- colnames(uk_cld_53)

uk_cld_53_padded <- rbind(uk_cld_53, na_rows)
combined_df_53 <- cbind(uk_cld_53_padded, uk_53)

write.csv(combined_df_53, "./combined_df_53.csv")

### LEGISLATURE 54

uk_54 <- read.csv("./unique_speaker_54.csv")

uk_54_B <- read.csv("./unique_speaker_54_B.csv")
uk_54_B <- uk_54_B %>% dplyr::select(-speaker_id)

uk_54 <- rbind(uk_54, uk_54_B) %>% distinct(twfy_member_id, .keep_all = T)

uk_cld_54 <- uk_df_cam %>% dplyr::filter(session==54)
n_missing_54 <- nrow(uk_54) - nrow(uk_cld_54)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_54, ncol = ncol(uk_cld_54)))
colnames(na_rows) <- colnames(uk_cld_54)

uk_cld_54_padded <- rbind(uk_cld_54, na_rows)
combined_df_54 <- cbind(uk_cld_54_padded, uk_54)

write.csv(combined_df_54, "./combined_df_54.csv")

### LEGISLATURE 55

uk_55 <- read.csv("./unique_speaker_55.csv")
# cleaning up duplicates due to change in tag
uk_55_clean <- uk_55 %>%
  mutate(twfy_member_id = na_if(twfy_member_id, "")) %>%
  arrange(speaker, desc(!is.na(twfy_member_id))) %>%
  distinct(speaker, .keep_all = TRUE)

#checking duplicates removed
dropped_rows <- anti_join(uk_55, uk_55_clean, by = names(uk_55))

uk_cld_55 <- uk_df_cam %>% dplyr::filter(session==55)

n_missing_55 <- nrow(uk_55_clean) - nrow(uk_cld_55)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_55, ncol = ncol(uk_cld_55)))
colnames(na_rows) <- colnames(uk_cld_55)
uk_cld_55_padded <- rbind(uk_cld_55, na_rows)
combined_df_55 <- cbind(uk_cld_55_padded, uk_55_clean)

write.csv(combined_df_55, "./combined_df_55.csv")

#### LEGISLATURE 56

uk_56 <- read.csv("./unique_speaker_56.csv")

uk_cld_56 <- uk_df_cam %>% dplyr::filter(session==56)
n_missing_56 <- nrow(uk_cld_56) - nrow(uk_56)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_56, ncol = ncol(uk_56)))
colnames(na_rows) <- colnames(uk_56)

uk_56_padded <- rbind(uk_56, na_rows)
combined_df_56 <- cbind(uk_56_padded, uk_cld_56)

write.csv(combined_df_56, "./combined_df_56.csv")

### LEGISLATURE 57

uk_57 <- read.csv("./unique_speaker_57.csv")

uk_cld_57 <- uk_df_cam %>% dplyr::filter(session==57)
n_missing_57 <- nrow(uk_cld_57) - nrow(uk_57)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_57, ncol = ncol(uk_57)))
colnames(na_rows) <- colnames(uk_57)

uk_57_padded <- rbind(uk_57, na_rows)
combined_df_57 <- cbind(uk_57_padded, uk_cld_57)

write.csv(combined_df_57, "./combined_df_57.csv")

#### LEGISLATURE 58

uk_58 <- read.csv("./unique_speaker_58.csv")
uk_58 <- uk_58 %>% rename(person_id = speaker_id)

uk_58_B <- read.csv("./unique_speaker_58_B.csv")
uk_58_B <- uk_58_B %>%
  mutate(twfy_member_id = NA)

uk_58 <- rbind(uk_58, uk_58_B) %>% distinct(person_id, .keep_all = T)

uk_cld_58 <- uk_df_cam %>% dplyr::filter(session==58)

n_missing_58 <- nrow(uk_58) - nrow(uk_cld_58)
na_rows <- as.data.frame(matrix(NA, nrow = n_missing_58, ncol = ncol(uk_cld_58)))
colnames(na_rows) <- colnames(uk_cld_58)

uk_cld_58_padded <- rbind(uk_cld_58, na_rows)
combined_df_58 <- cbind(uk_cld_58_padded, uk_58)

write.csv(combined_df_58, "./combined_df_58.csv")