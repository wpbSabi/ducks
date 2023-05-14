# Duck eggs laid in our garden 🦆🥚

## Background

We brought home four few-day-old ducklings in 2020; two white crested ducks on April 10th and two khaki campbell ducks on May 14th.  They started laying eggs in November and I've been collecting data on the quantity of eggs ever since.  Here's a table about how many (female) ducks we've had laying eggs since, by month.

(NEW TABLE DRAFT) Number of Ducks by Month and Year

| Duck Breeds            | Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec | 
|------------------------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
| 2020                   |
| White Crested Ducks    | 2
| Khaki Campbell Ducks   | 2
|------------------------|-----------------|---------------------------------|
| 2021  
| White Crested Ducks    | 2
| Khaki Campbell Ducks   | 2
|------------------------|-----------------|---------------------------------|
| 2022  
| White Crested Ducks    | 2
| Khaki Campbell Ducks   | 2
| Khaki / Buff Mix Ducks | 2
|------------------------|-----------------|---------------------------------|
| 2023
| White Crested Ducks    | 2
| Khaki Campbell Ducks   | 2
| Khaki / Buff Mix Ducks | 2
|------------------------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|


According to the American Poultry Association:
* White Crested ducks lay 100-150 eggs per year
* Khaki Campbell ducks lay 250-340 eggs per year

But the actual data are so much more interesting!

## Number of eggs laid by day (2021 and 2022)

1. The R script `duck_eggs_gif.R` uses data from the file `data_eggs_laid.csv` to generate the following GIF with two plots.
* `duck_eggs_gif.R` is compatible with R v3, but is not compatible with the newer R v4	

![GIF 2021-2022](/images/daily_duck_egg_count.gif)

>Five Eggs in One Day? From Four Ducks?
>
>I had read that ducks and chickens lay at most an egg per day.  But experience taught me otherwise.  Therefore, I embarked on further research and found that our ducks were not unique in this regard.  Breeds such as our khaki campbells are known to sometimes lay more than one egg per day, until the young layers have their hormones stabilize. 

2. The R script `duck_eggs_table.R` provides a different view; the average number of eggs laid per duck by month.

![GIF Image](/images/eggs_per_duck.png)

>* These numbers are averaged over all of the ducks.  Although on many days we can tell which whether an egg came from a khaki or crested duck, it is not always obvious. 
>* These numbers account for the numbers of ducks we had each month, as two of our ducks passed away before 2023 (both suddently- one due to yolk coelimitis and the other to an unknown cause such eating something poisonous to ducks or flu).


3. The following data points can provide some inference regarding the number of eggs laid by khakis versus crested ducks

| Year | Days where every duck laid an egg | Days with at least one egg laid |
|------|-----------------------------------|---------------------------------|
| 2021 | 110                               | 254                             |
| 2022 | 109                               | 226                             |
| 2023 | 50 (through May 14, 2023)		   | 85 (through May 14, 2023)       |

>* It is likely that our khakis laid less than the typically range, implying that they are not pure breeds
>* It is likely that our cresteds laid within the expected range



