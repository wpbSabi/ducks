# Author: Sabi Horvat, January 2023
# github: www.github.com/wpbsabi
# Description: Takes data, adds 0 value for any missing dates, and creates one GIF with two plots

library(formattable)
library(lubridate)
library(tidyverse)

df <- read_csv('data/data_eggs_laid.csv',
               col_type = cols(day = col_integer(),
                               date = col_date(format="%m/%d/%Y"),
                               quantity = col_integer(),
                               cumulative = col_integer())) %>%
      select(-ducks)

# replace null values with 0
df$quantity[is.na(df$quantity)] = 0

### Verify there are no missing days; add a zero egg count on any missing days
# Drop the day, as this will be recalculated
df <- df %>% select(date, quantity, cumulative)
# Create a data frame with all possible days to check for all days
# d <- as.Date(0:364, origin = "2021-01-01")
d <- as.Date(0:2000, origin = "2020-04-08")
d <- data.frame(d)
# Add any missing dates and recalculate the day of the year and cumulative
df_dates <- left_join(d, df, by = c('d' = 'date'))
df_dates[is.na(df_dates)] <- 0
df_dates$day <- seq.int(nrow(df_dates))
df_dates$cumulative <- cumsum(df_dates$quantity)
df <- df_dates
# Update the number of ducks based on dates
df$ducks[df$d < as.Date('2022-05-31')] <- 3 # little poof passed on 5/30
df$ducks[df$d < as.Date('2021-07-06')] <- 4 # peaky passed on 7/5
df$ducks[df$d < as.Date('2023-01-01')] <- 2 # roundy and big poof
df$ducks[df$d >= as.Date('2023-01-01')] <- 5 # + strawberry, blueberry, and lightning

###

# Add month and year by data
df$year <- year(df$d)
df$month <- month(df$d)
# df$month_name <- month.name[df$month]
df <- df %>% arrange(month)


# Create a table that aggregates eggs laid by month (columns) and year (rows)
df_table <- df %>% 
  filter(year < 2024) %>%
  select(year, month, quantity) %>%
  group_by(year, month) %>%
  summarise('eggs' = sum(quantity))  %>%
  arrange(month) %>%
  pivot_wider(names_from = month, values_from = eggs) %>%
  arrange(year)

# Replace null values with 0
df_table[is.na(df_table)] = 0

# Change the column names
colnames(df_table) = c("Year", "Jan","Feb","Mar",
                           "Apr","May","Jun",
                           "Jul","Aug","Sep",
                           "Oct","Nov","Dec")

# Add a "Total" column for each year that sums the eggs from all months
df_table$Total <- rowSums(df_table) - df_table$Year

# Add an "Eggs_per_Duck" column that averages the eggs per year per duck
df_table <- df_table %>% 
  mutate(Eggs_per_Duck = round(
    ifelse(Year == 2020, Total / 4, 
           ifelse(
             Year == 2021, 
             (Jan + Feb + Mar + Apr + May + Jun) / 4 + (Jul + Aug + Sep + Oct + Nov + Dec) / 3, 
             ifelse(Year == 2022, (Jan + Feb + Mar + Apr + May) / 3 + (Jun + Jul + Aug + Sep + Oct + Nov + Dec) / 2, 
                    (Jan + Feb + Mar + Apr + May + Jun + Jul) / 5 + (Aug + Sep + Oct + Nov + Dec) / 6 # 2023
                    )))))

# View the table
formattable(df_table)
