# Duck eggs laid in our garden 🦆🥚

To run R scripts, the best practice is to first install R and then install RStudio.
* To Run the script that creates the year-by-year duck eggs table, open `duck_eggs_table.R` in RStudio.
* To Run the script that creates GIF of eggs layed by day, open `duck_eggs_gif.R` in RStudio.

## Background

We brought home four few-day-old ducklings in 2020; two white crested ducks on April 10th and two khaki campbell ducks on May 14th.  They started laying eggs in November and I've been collecting data on the quantity of eggs ever since.  Here's a table about how many (female) ducks we've had laying eggs since, by month.

**Number of Laying Ducks by Month and Year**

| Duck Breeds            | Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec | 
|------------------------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
| 2020                   |
| White Crested Ducks    | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 2   | 2   |
| Khaki Campbell Ducks   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 2   | 2   | 
|-------------------     | Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec | 
| 2021  
| White Crested Ducks    | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   |
| Khaki Campbell Ducks   | 2   | 2   | 2   | 2   | 2   | 2   | 1   | 1   | 1   | 1   | 1   | 1   |
|-------------------     | Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec | 
| 2022  
| White Crested Ducks    | 2   | 2   | 2   | 2   | 2   | 1   | 1   | 1   | 1   | 1   | 1   | 1   |
| Khaki Campbell Ducks   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   |
|-------------------     | Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec | 
| 2023
| White Crested Ducks    | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   |
| Khaki Campbell Ducks   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   |
| Khaki / Buff Mix Ducks | 0   | 0   | 3   | 3   | 3   | 3   | 3   | 3   | 3   | 3   | 3   | 3   |
|-------------------	 | Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec | 
| 2024
| White Crested Ducks    | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   |
| Khaki Campbell Ducks   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   |
| Khaki/Buff/Crested Mix | 3   | 3   | 4   | 4   | 4   | 4   | 4   | 4   | 4   | 4   | 4   | 4   |


According to the American Poultry Association:
* White Cresteds lay 100-150 eggs per year
* Khaki Campbells lay 250-340 eggs per year
* Buff Orpingtons lay 150-220 eggs per year

But the actual data are so much more interesting!

## Number of eggs laid by day

1. The following data points can provide some inference regarding the number of eggs laid by khakis versus crested ducks.

| Year | Days where every duck laid an egg | Days with at least one egg laid | Eggs per laying duck |
|------|-----------------------------------|---------------------------------|----------------------|
| 2021 | 110                               | 254                             | 194                  |
| 2022 | 109                               | 226                             | 173                  |
| 2023 | 95								   | 316     						 | 247                  |
| 2024 | 52								   | 366							 | 284                  |

>* In the first two years, it is likely that our khakis laid near the lower end of the typical range (or even lower).
>* It is likely that our white crested ducks lay within the expected range.

2. The R script `duck_eggs_table.R` provides a monthly view of eggs laid.

![GIF Image](/images/eggs_per_duck.png)

>* These numbers account for the numbers of laying ducks we had each month.
>* Therefore, this is not a straight average of eggs / # of laying ducks for the entire year.

3. The R script `duck_eggs_gif.R` uses data from the file `data_eggs_laid.csv` to generate the following GIF with two plots.

*Note that this is not updated for 2023*

* `duck_eggs_gif.R` is compatible with R v3, but is not compatible with the newer R v4.

![GIF 2021-2022](/images/daily_duck_egg_count.gif)

>Five Eggs in One Day? From Four Ducks?
>
>I had read that ducks and chickens lay at most an egg per day.  But experience taught me otherwise.  Therefore, I embarked on further research and found that our ducks were not unique in this regard.  Breeds such as our khaki campbells are known to sometimes lay more than one egg per day, until the young layers have their hormones stabilize. 
