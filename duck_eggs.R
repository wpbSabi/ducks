# Author: Sabi Horvat, March 2021
# github: www.github.com/wpbsabi
# twitter: @tourofdata - mobile.twitter.com/tourofdata
# Description: Takes data, adds 0 value for any missing dates, and creates one GIF with two plots
# Updated: November 2022

library(cowplot)
library(gganimate)
library(ggtext)
library(lubridate)
library(magick)
library(tidyverse)

df <- read_csv('data/data_eggs_laid.csv',
               col_type = cols(day = col_integer(),
                               date = col_date(format="%m/%d/%Y"),
                               quantity = col_integer(),
                               cumulative = col_integer())) %>%
      select(-ducks)

### Verify there are no missing days; add a zero egg count on any missing days
# Drop the day, as this will be recalculated
df <- df %>% select(date, quantity, cumulative)
# Create a data frame with all possible days to check for all days
# d <- as.Date(0:364, origin = "2021-01-01")
d <- as.Date(0:1000, origin = "2020-04-08")
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
df$ducks[df$d >= as.Date('2022-05-31')] <- 2
###

# Create the first plot, eggs laid by day
p1 <- ggplot() +
  geom_line(data = df,
            aes(x = as.Date(day, origin = '2020-04-08'), y = quantity),
            size = 1,
            color = df$ducks) +
            # color = 'pink') + 
  geom_point(data = df,
             aes(x = as.Date(day, origin = '2020-04-08'), y = quantity),
             fill = 'pink',
             shape = 21,
             size = 3,
             color = 'black') +
  scale_x_date(date_labels = '%Y-%b', breaks = 'month') +
  theme_minimal() +
  theme(plot.title = element_textbox_simple(size = 15, 
                                            lineheight = 1, 
                                            padding = margin(5.5, 5.5, 5.5, 5.5),
                                            margin = margin(0, 0, 5.5, 0)),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(angle = 90, size = 12),
        axis.text.y = element_text(size = 12)) +
  ggtitle("<b>Our Ducks Started Laying Eggs at 6 months of Age</b>
           <br><span style = 'color:blue;'>4 ducks (blue)</span>
           <br><span style = 'color:darkgreen;'>3 ducks (green) </span>
           <br><span style = 'color:red;'>2 ducks (red)</span>") +
  xlab('\n\nDays since ducks started laying eggs (1st egg on November 5th, 2020)\n\n') +
  ylab('\n\n# Eggs laid per day\n\n') + 
  geom_vline(xintercept = as.Date('2021-01-01'), linetype = 'dotted', color = 'grey') +
  geom_vline(xintercept = as.Date('2022-01-01'), linetype = 'dotted', color = 'grey') + 
  transition_reveal(day) 

# Create the 2nd plot, Cumulative eggs laid by day
p2 <- ggplot() +
  geom_line(data = df, 
            aes(x = as.Date(day, origin = '2020-04-08'), y = cumulative),
            size = 2,
            color = df$ducks) +
            # color = 'pink') + 
  geom_point(data = df,
             aes(x = as.Date(day, origin = '2020-04-08'), y = cumulative),
             fill = 'pink',
             shape = 21,
             size = 3,
             color = 'black') +
  scale_x_date(date_labels = '%Y-%b', breaks = 'month') +
  theme_minimal() +
  theme(plot.title = element_textbox(hjust = 0.5,
                                     size = 15, 
                                     padding=margin(5.5, 5.5, 5.5, 5.5)),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(angle = 90, size = 12),
        axis.text.y = element_text(size = 12)) +
  ggtitle("\n<b>\nCumulative Eggs Laid</b>
          <br><span style = 'color:darkgrey;'>2020 (year 1): 14 eggs per duck</span>
          <br><span style = 'color:darkgrey;'>2021 (year 2): 208 eggs per duck</span>
           <br><span style = 'color:darkgrey;'>2022 (year 3): 189 eggs per duck</span>") +
  xlab('\n\nDays since ducks started laying eggs (1st egg on November 5th, 2020)\n\n') +
  ylab('\n\n# Cumulative Eggs Laid \n\n') + 
  geom_vline(xintercept = as.Date('2021-01-01'), linetype = 'dotted', color = 'grey') +
  geom_vline(xintercept = as.Date('2022-01-01'), linetype = 'dotted', color = 'grey') + 
  transition_reveal(day)

# Create the two GIFs and combine 
a_gif <- animate(p1, 
                 fps = 10,
                 end_pause = 10,
                 width = 700, 
                 height = 500)
b_gif <- animate(p2, 
                 fps = 10,
                 end_pause = 10,
                 width = 700, 
                 height = 500)
a_mgif <- image_read(a_gif)
b_mgif <- image_read(b_gif)
new_gif <- image_append(c(a_mgif[1], b_mgif[1]))
for(i in 2:100){
  combined <- image_append(c(a_mgif[i], b_mgif[i]))
  new_gif <- c(new_gif, combined)
}

anim_save(filename = 'images/daily_duck_egg_count.gif', 
          animation = new_gif)
