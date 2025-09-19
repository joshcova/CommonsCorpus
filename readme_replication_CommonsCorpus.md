In this repository you can find information on how the CommonsCorpus dataset was constructed as well as the replication code for analyses that were conducted to examine the parliamentary salience of Brexit and the minimum wage. 

The actual data can be found here: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/KXDDJU

This repository is divided into the following folders:

    scraping_twfy: Coding pipeline to scrape information from the TWFY repository

    integration_cld_twfy: Coding pipeline on how speaker ID information has been reconciled with socio-demographic data contained in the Comparative Legislators Database.

    example_UK_parliamentary_data: Replication files to replicate the analysis in the article/working paper on Brexit and the minimum wage

1. raw_data_scraping_code

This folder contains the following files illustrating how to scrape parliamentary speech data:

    scraping_file_TWFY.ipynb: this file details how to scrape speaker information and the raw text of the parliamentary speeches from the repository available on the TWFY website (https://www.theyworkforyou.com/pwdata/scrapedxml/debates/)
    unique_speaker_TWFY.ipnb: this file illustrates how to extract the names of the unique speakers from the scraped parliamentary data

2. annoted_data_code

This folder contains the following files illustrating how to annotate the parliamentary speech data, divided into two sub-folders

code:

    cld_data_unique_speakers.R: this file illustrates how to extract the names of the unique speakers from the Comparative Legislators Database (CLD)
    llm_fuzzy_matching.ipynb: this file illustrates how to conduct fuzzy matching between the unique speakers from the TWFY dataset and the CLD.
    annotation_UK_parliamentary_data.ipynb: this file illustrates how to incorporate the data from the CLD to the existing corpus of scraped parliamentary debates. By running this code we can thus obtain annotated parliamentary speeches.
    concatenation_UK_parliamentary_data.ipynb: this file illustrates how to concatenate and standardized the annotated dataset of parliamentary speeches to produce the .csv files that are available here: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/KXDDJU

data:

    combined_46.csv: this file contains the unprocessed (unmatched) list of unique speakers from the CLD and the TWFY online repository for the 46th legislature, as an example. 
    unique_speakers_integrated.xlsx: this file contains the names of the matched unique speakers as matched by OpenAI's GPT 4o. In other words, for every unique record available in the TWFY dataset, there is a match with the CLD dataset containing the socio-demographic and party-political information of the MP.
    partyfacts_uk.xlsx: this file contains the partyfacts database information for all UK parties present in the repository

3. example_CommonsCorpus

This folder contains the files necessary to replicate the analysis present in the article/working paper on the parliamentary salience of Brexit and the minimum wage. 