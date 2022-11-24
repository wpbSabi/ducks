# Author: Sabi Horvat, March 2021
# github: www.github.com/wpbsabi
# twitter: @tourofdata - mobile.twitter.com/tourofdata
# Description: Takes data, adds 0 value for any missing dates, and creates one GIF with two plots
# Updated: November 2022

library(gganimate)
library(ggtext)
library(lubridate)
library(magick)
library(tidyverse)

df <- read_csv('data_eggs_laid.csv',
               col_type = cols(day=col_integer(),
                               date=col_date(format="%m/%d/%Y"),
                               quantity=col_integer(),
                               cumulative=col_integer()))

### Verify there are no missing days; add a zero egg count on any missing days
# Drop the day, as this will be recalculated
df <- df %>% select(date, quantity, cumulative)
# Create a data frame with all possible days to check for all days
d <- as.Date(0:364, origin = "2021-01-01")
d <- data.frame(d)
# Add any missing dates and recalculate the day of the year and cumulative
df_dates <- left_join(d, df, by=c('d'='date'))
df_dates[is.na(df_dates)] <- 0
df_dates$day <- seq.int(nrow(df_dates))
df_dates$cumulative <- cumsum(df_dates$quantity)
df <- df_dates
###

# Create the first plot, eggs laid by day
p1 <- df %>% 
  ggplot(aes(x=as.numeric(day), y=quantity)) + 
  geom_line(data=df, aes(x=day, y=quantity), size=1, color='pink') + 
  geom_point(data=df, aes(x=day, y=quantity)
             ,fill='pink', shape=21, size=3, color='black') +
  theme_minimal() +
  theme(plot.title=element_textbox_simple(
    size=15, lineheight=1, padding=margin(5.5, 5.5, 5.5, 5.5)
    ,margin=margin(0, 0, 5.5, 0))
    ,panel.grid.major=element_blank()
    ,panel.grid.minor=element_blank()
    ,axis.text.x=element_text(size=12)
    ,axis.text.y=element_text(size=12)) +
  ggtitle("<b>Our Ducks Started Laying Eggs at 6 months of Age</b><br><span style = 'color:purple;'>75 days later,
              they laid an egg almost every day</span>
           <br><span style = 'color:blue;'>Even in January, February, and March!</span>") +
  ylab('\n\n# Eggs laid by 4 ducks (per day)\n\n') + 
  xlab('\n\nDays since ducks started laying eggs (Day 0 = November 5th)\n\n') +
  transition_reveal(day)

# Create the 2nd plot, Cumulative eggs laid by day
p2 <- df %>% 
  ggplot(aes(x=as.numeric(day), y=quantity)) + 
  geom_line(data=df, aes(x=day, y=cumulative), size=2, color='pink') + 
  geom_point(data=df, aes(x=day, y=cumulative),
             fill='pink', shape=21, size=3, color='black') +
  theme_minimal() +
  theme(plot.title=element_textbox(hjust=0.5
    ,size=15, padding=margin(5.5, 5.5, 5.5, 5.5))
    ,panel.grid.major=element_blank()
    ,panel.grid.minor=element_blank()
    ,axis.text.x=element_text(size=12)
    ,axis.text.y=element_text(size=12)) +
  ggtitle("\n<b>\nCumulative Eggs Laid</b></span>") +
  ylab('\n\n# Cumulative Eggs Laid by 4 ducks (per day)\n\n') + 
  xlab('\n\nDays since ducks started laying eggs (Day 0 = November 5th)\n\n')+
  transition_reveal(day)

# Create the two GIFs and combine 
a_gif <- animate(p1, width=500, height=500)
b_gif <- animate(p2, width=500, height=500)
a_mgif <- image_read(a_gif)
b_mgif <- image_read(b_gif)
new_gif <- image_append(c(a_mgif[1], b_mgif[1]))
for(i in 2:100){
  combined <- image_append(c(a_mgif[i], b_mgif[i]))
  new_gif <- c(new_gif, combined)
}
new_gif
anim_save(filename="GIF_of_Number_of_Duck_Eggs_Laid_by_Day.gif", nframes=150,
          animation=new_gif, end_pause=6, 
          height=1000, width=1000, res=120)

