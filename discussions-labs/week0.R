
packages <- c("here", "janitor", "tidyverse", "sf", "terra", "tmap", "spData", "spDataLarge", "geodata", "kableExtra", "viridisLite")
installed_packages <- packages %in% rownames(installed.packages())

if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

install.packages("spDataLarge", repos = c("https://geocompx.r-universe.dev", "https://cloud.r-project.org"))


library(here)
library(janitor)
library(tidyverse)
library(sf)
library(kableExtra)


gdw_df <- read_csv(
  here("discussions-labs", "data", "gdw.csv")
) |> clean_names() #makes the column names into lowercase snake


# show first 10 rows 
head(gdw_df, 10)
# show last 10 rows
tail(gdw_df, 10)

# html tables
head(gdw_df, 10) |> kable()
tail(gdw_df, 10) |> kable()


# how many rows and columns in the df
dim(gdw_df)
ncol(gdw_df)
nrow(gdw_df)


# print column names
names(gdw_df)


country_df <- gdw_df[, "country"]
country_vec <- gdw_df[["country"]]



gdw_df |> 
  group_by(dam_type) |> 
  summarise(count = n()) |> 
  ungroup()
  


sub_dam <- gdw_df |> 
  filter(dam_type == "Dam") |> 
  arrange(year_dam) 


gdw_df |> 
  group_by(country) |> 
  summarise(mean_dam_hgt_m = mean(dam_hgt_m, na.rm = TRUE)) |> 
  ungroup() |> 
  ggplot(aes(x= country, y = mean_dam_hgt_m)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

  
