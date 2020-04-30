---
title: "s07 Exercises: Tibble Joins"
author: "Ansley"
output: 
  html_document:
    keep_md: true
    theme: paper
---

## Requirements

You will need data from Joey Bernhardt's `singer` R package for this exercise. 

You can download the singer data from the `USF-Psych-DataSci/Classroom` repo:

<!-- The following chunk allows errors when knitting -->





```r
songs <- read_csv("https://github.com/USF-Psych-DataSci/Classroom/raw/master/data/singer/songs.csv")
```

```
## Error in read_csv("https://github.com/USF-Psych-DataSci/Classroom/raw/master/data/singer/songs.csv"): could not find function "read_csv"
```

```r
locations <- read_csv("https://github.com/USF-Psych-DataSci/Classroom/raw/master/data/singer/loc.csv")
```

```
## Error in read_csv("https://github.com/USF-Psych-DataSci/Classroom/raw/master/data/singer/loc.csv"): could not find function "read_csv"
```


```r
library(kableExtra)
library(MBESS)
library(papaja)
library(psych)
```

```
## 
## Attaching package: 'psych'
```

```
## The following object is masked from 'package:MBESS':
## 
##     cor2cov
```

```r
library(tidyverse)
```

```
## ── Attaching packages ────────────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.0.9000     ✓ purrr   0.3.3     
## ✓ tibble  3.0.0          ✓ dplyr   0.8.5     
## ✓ tidyr   1.0.2          ✓ stringr 1.4.0     
## ✓ readr   1.3.1          ✓ forcats 0.4.0
```

```
## ── Conflicts ───────────────────────────────────────────────── tidyverse_conflicts() ──
## x ggplot2::%+%()      masks psych::%+%()
## x ggplot2::alpha()    masks psych::alpha()
## x dplyr::filter()     masks stats::filter()
## x dplyr::group_rows() masks kableExtra::group_rows()
## x dplyr::lag()        masks stats::lag()
```

```r
library(here)
```

```
## here() starts at /Users/ansleybender/Documents/DSV_Spring2020/GitHub/DataSci-participation/DataSci-participation
```

```r
library(scales)
```

```
## 
## Attaching package: 'scales'
```

```
## The following object is masked from 'package:purrr':
## 
##     discard
```

```
## The following object is masked from 'package:readr':
## 
##     col_factor
```

```
## The following objects are masked from 'package:psych':
## 
##     alpha, rescale
```

```r
library(tsibble)
```

```
## 
## Attaching package: 'tsibble'
```

```
## The following object is masked from 'package:dplyr':
## 
##     id
```

```r
library(ggplot2)
library(svglite)
library(dplyr)
library(ggthemes)
library(broom)
library(DescTools)
```

```
## 
## Attaching package: 'DescTools'
```

```
## The following objects are masked from 'package:psych':
## 
##     AUC, ICC, SD
```

```r
library(aod)
library(redoc)
library(apaTables)
library(plyr)
```

```
## ------------------------------------------------------------------------------
```

```
## You have loaded plyr after dplyr - this is likely to cause problems.
## If you need functions from both plyr and dplyr, please load plyr first, then dplyr:
## library(plyr); library(dplyr)
```

```
## ------------------------------------------------------------------------------
```

```
## 
## Attaching package: 'plyr'
```

```
## The following object is masked from 'package:tsibble':
## 
##     id
```

```
## The following object is masked from 'package:here':
## 
##     here
```

```
## The following objects are masked from 'package:dplyr':
## 
##     arrange, count, desc, failwith, id, mutate, rename, summarise,
##     summarize
```

```
## The following object is masked from 'package:purrr':
## 
##     compact
```


If you want, you could instead install the `singer` package itself. To do that,
you'll need to install `devtools`. Running this code in your console should do 
the trick:

```
install.packages("devtools")
devtools::install_github("JoeyBernhardt/singer")
```


```r
#install.packages("devtools")
#devtools::install_github("JoeyBernhardt/singer")
```


Load required packages:



## Exercise 1: `singer`

The package `singer` comes with two smallish data frames about songs. 
Let's take a look at them (after minor modifications by renaming and shuffling):


```r
(time <- as_tibble(songs) %>% 
   rename(song = title))
```

```
## Error in rename(., song = title): unused argument (song = title)
```


```r
(album <- as_tibble(locations) %>% 
   select(title, everything()) %>% 
   rename(album = release,
          song  = title))
```

```
## Error in rename(., album = release, song = title): unused arguments (album = release, song = title)
```


1. We really care about the songs in `time`. But, for which of those songs do we 
   know its corresponding album?


```r
time %>% 
  inner_join(album, by = "song") %>% 
  select(song, album, everything())
```

```
## Error in UseMethod("inner_join"): no applicable method for 'inner_join' applied to an object of class "function"
```

2. Go ahead and add the corresponding albums to the `time` tibble, being sure to 
   preserve rows even if album info is not readily available.


```r
time %>% 
  left_join(album, by = "song") %>% #If we had used full join, it would have also preserved songs that have album but not year (the different variables in x (time))
  select(song, album, everything()) 
```

```
## Error in UseMethod("left_join"): no applicable method for 'left_join' applied to an object of class "function"
```

3. Which songs do we have "year", but not album info?


```r
time %>% 
  anti_join(album, by = "song") %>% 
  select(song, year, everything())
```

```
## Error in UseMethod("anti_join"): no applicable method for 'anti_join' applied to an object of class "function"
```

4. Which artists are in `time`, but not in `album`?


```r
time %>% 
  anti_join(album, by = "artist_name")
```

```
## Error in UseMethod("anti_join"): no applicable method for 'anti_join' applied to an object of class "function"
```


5. You've come across these two tibbles, and just wish all the info was 
   available in one tibble. What would you do?


```r
time %>% 
  full_join(album, by = c("song", "artist_name")) %>% 
  select(song, everything())
```

```
## Error in UseMethod("full_join"): no applicable method for 'full_join' applied to an object of class "function"
```

```r
#OR

time %>% 
  full_join(select(album, -artist_name), by = "song") 
```

```
## Error in UseMethod("full_join"): no applicable method for 'full_join' applied to an object of class "function"
```

```r
#can combine dplyr functions into this joining
time %>% 
  inner_join(filter(album, city == "Seattle, WA"), by = "song")
```

```
## Error in UseMethod("inner_join"): no applicable method for 'inner_join' applied to an object of class "function"
```

From class

```r
time %>% 
  full_join(album, by = intersect(names(time), names(album)))
```

```
## Error in UseMethod("full_join"): no applicable method for 'full_join' applied to an object of class "function"
```



## Exercise 2: LOTR

Load in three tibbles of data on the Lord of the Rings:


```r
fell <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")
```

```
## Parsed with column specification:
## cols(
##   Film = col_character(),
##   Race = col_character(),
##   Female = col_double(),
##   Male = col_double()
## )
```

```r
ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")
```

```
## Parsed with column specification:
## cols(
##   Film = col_character(),
##   Race = col_character(),
##   Female = col_double(),
##   Male = col_double()
## )
```

```r
retk <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")
```

```
## Parsed with column specification:
## cols(
##   Film = col_character(),
##   Race = col_character(),
##   Female = col_double(),
##   Male = col_double()
## )
```

1. Combine these into a single tibble.


```r
bind_rows(fell, ttow, retk)
```

```
## # A tibble: 9 x 4
##   Film                       Race   Female  Male
##   <chr>                      <chr>   <dbl> <dbl>
## 1 The Fellowship Of The Ring Elf      1229   971
## 2 The Fellowship Of The Ring Hobbit     14  3644
## 3 The Fellowship Of The Ring Man         0  1995
## 4 The Two Towers             Elf       331   513
## 5 The Two Towers             Hobbit      0  2463
## 6 The Two Towers             Man       401  3589
## 7 The Return Of The King     Elf       183   510
## 8 The Return Of The King     Hobbit      2  2673
## 9 The Return Of The King     Man       268  2459
```

2. Which races are present in "The Fellowship of the Ring" (`fell`), but not in 
   any of the other ones?


```r
fell %>% 
  anti_join(ttow, by = "Race") %>% 
  anti_join(retk, by = "Race")
```

```
## # A tibble: 0 x 4
## # … with 4 variables: Film <chr>, Race <chr>, Female <dbl>, Male <dbl>
```

```r
unique(ttow$Race)
```

```
## [1] "Elf"    "Hobbit" "Man"
```

```r
unique(retk$Race)
```

```
## [1] "Elf"    "Hobbit" "Man"
```

```r
unique(fell$Race)
```

```
## [1] "Elf"    "Hobbit" "Man"
```


## Exercise 3: Set Operations

Let's use three set functions: `intersect`, `union` and `setdiff`. We'll work 
with two toy tibbles named `y` and `z`, similar to Data Wrangling Cheatsheet


```r
(y <-  tibble(x1 = LETTERS[1:3], x2 = 1:3))
```

```
## # A tibble: 3 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
## 2 B         2
## 3 C         3
```


```r
(z <- tibble(x1 = c("B", "C", "D"), x2 = 2:4))
```

```
## # A tibble: 3 x 2
##   x1       x2
##   <chr> <int>
## 1 B         2
## 2 C         3
## 3 D         4
```

1. Rows that appear in both `y` and `z`


```r
intersect(y, z)
```

```
## # A tibble: 2 x 2
##   x1       x2
##   <chr> <int>
## 1 B         2
## 2 C         3
```

2. You collected the data in `y` on Day 1, and `z` in Day 2. 
   Make a data set to reflect that.


```r
union(
  mutate(y, day = "Day 1"),
  mutate(z, day = "Day 2")
) %>% 
  pivot_wider(names_from = "day")
```

```
## # A tibble: 4 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
## 2 B         2
## 3 C         3
## 4 D         4
```

```r
#Could combine with pivot function to make wide format
```

3. The rows contained in `z` are bad! Remove those rows from `y`.


```r
setdiff(y, z)
```

```
## # A tibble: 1 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
```



```r
#install.packages("nycflights13")
library(nycflights13)

#renaming
airports.1 <- as_tibble(airports) %>% 
   rename(origin = faa)
```

```
## Error in rename(., origin = faa): unused argument (origin = faa)
```

```r
#grouping
a <- full_join(flights, weather, by = c("origin", "year", "month", "day", "hour"))
b <- full_join(a, airlines, by = "carrier")
c <- full_join(b, planes, by = c("tailnum", "year"))
d <- full_join(c, airports.1, by = "origin") %>% 
  select(carrier, flight, tailnum, origin, dest, everything()) %>% 
  arrange(carrier, origin)
```

```
## Error in tbl_vars_dispatch(x): object 'airports.1' not found
```

