library(tidyverse)
# I need to make a list of the metabolites that appear in the top 500 rows or less that predict consumer liking
# this means I will filter the rows: rmse <2?
df <- readxl::read_xlsx("data/model_results.xlsx")
#then I will select the Variables column and separate the 4 values into their own column and stack them, then summarise the number of times each appears
df1 <- df %>% filter(RMSE < 3) %>% select(Variables) %>% separate_longer_delim(Variables,delim = ", ") %>% count(Variables) %>% 
  arrange(desc(n))
writexl::write_xlsx(df1, "../Papaya Imaging/data/important_metabolites.xlsx")
#or after stacking them use unique to make a list of names that appear (only works if the variables are limited)
df2 <- df %>% filter(RMSE < 1.6) %>% select(Variables) %>% separate_longer_delim(Variables,delim = ", ") %>% unique()
# sort models by best performance
df %>% arrange(RMSE, desc(R_squared)) %>% slice(1:50) %>% select(Variables) %>% separate_longer_delim(Variables,delim = ", ") %>% count(Variables) %>% 
  arrange(desc(n))
