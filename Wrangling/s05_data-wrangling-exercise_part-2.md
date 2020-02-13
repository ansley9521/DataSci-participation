---
title: 's05: Some More `dplyr` Exercise'
output: 
  html_document:
    keep_md: true
    theme: paper
---

<!---The following chunk allows errors when knitting--->



**When you make an Rmd file for participation or homework, be sure to do this**:

1. Change the file output to both html and md _documents_ (not notebook).
  - See the `keep_md: TRUE` argument above.

2. `knit` the document. 

3. Stage and commit the Rmd and knitted documents.


# Let's review some `dplyr` syntax

Load the `tidyverse` package.
    

```r
# load your packages here:
library(gapminder)
library(tidyverse)
```
    

## `select()`, `rename()`, `filter()`, `mutate()`, and a little plotting

Let's use the `mtcars` dataset. Complete the following tasks. Chain together
all of the commands in a task using the pipe `%>%`.

1. Show the miles per gallon and horsepower for cars with 6 cylinders. Also
   convert the data frame to a tibble (keep the rownames and store them in the
   tibble with a descriptive variable name). Store this result as a new object
   with a descriptive object name.


```r
mtcars6cyl <- mtcars %>% 
  rownames_to_column(var = "CarType") %>% 
  as_tibble() %>% 
  select(CarType, mpg, hp, cyl) %>% 
  filter(cyl == 6)
DT::datatable(mtcars6cyl)
```

<!--html_preserve--><div id="htmlwidget-9b7b9afc0e0a71c8ecad" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-9b7b9afc0e0a71c8ecad">{"x":{"filter":"none","data":[["1","2","3","4","5","6","7"],["Mazda RX4","Mazda RX4 Wag","Hornet 4 Drive","Valiant","Merc 280","Merc 280C","Ferrari Dino"],[21,21,21.4,18.1,19.2,17.8,19.7],[110,110,110,105,123,123,175],[6,6,6,6,6,6,6]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>CarType<\/th>\n      <th>mpg<\/th>\n      <th>hp<\/th>\n      <th>cyl<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[2,3,4]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

2. Print the results from Task 1 in an appealing way by using `knitr::kable()`.


```r
knitr::kable(mtcars6cyl)
```



CarType            mpg    hp   cyl
---------------  -----  ----  ----
Mazda RX4         21.0   110     6
Mazda RX4 Wag     21.0   110     6
Hornet 4 Drive    21.4   110     6
Valiant           18.1   105     6
Merc 280          19.2   123     6
Merc 280C         17.8   123     6
Ferrari Dino      19.7   175     6

Let's use the `iris` dataset. Complete the following tasks. Chain together
all of the commands in a task using the pipe `%>%`.

3. Rename the variables to be all lowercase and to separate words with "_"
   instead of ".". Put the species name variable first. Store this result as 
   a new object.


```r
names(iris) <- c("sepal_length", "sepal_width", "petal_length", "petal_width", "species")
iris_lower<-rename_all(iris, tolower) %>% 
  select(species, everything()) 

#Or can do

iris_lower1<-iris %>% 
  select(species = Species,
         sepal.length = Sepal_Length,
         sepal.width = Sepal_Width,
         petal.length = Petal_Length,
         petal.width = Petal_Width) %>% 
  select(Species, everything())
```

```
## Error in .f(.x[[i]], ...): object 'Species' not found
```

4. Using the data from Task 3, plot the sepal width for each species. Perhaps 
   use a boxplot or a jitter plot (or both overlaid!). Be sure to format the
   axis labels nicely.


```r
iris_lower %>% 
  ggplot(aes(species, sepal_width, col = species)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.3, color = "cyan4")+
  theme_bw()
```

![](s05_data-wrangling-exercise_part-2_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

5. `iris` expresses all of the measurements in centimeters. Convert them to 
   inches (1 in = 2.54 cm). Store this dataset as a new object.


```r
iris_in <- iris_lower %>% 
  mutate(sepal_length = round(sepal_length/2.54, 2),
         sepal_width = round(sepal_width/2.54, 2),
         petal_length = round(petal_length/2.54, 2),
         petal_width = round(petal_width/2.54, 2))
```

6. Using the data from Task 5, plot the relationship between sepal width and
   sepal length. Indicate species using color and point shape.


```r
iris_in %>% 
  ggplot(aes(sepal_width, sepal_length)) + #If color is in ggplot, if you have other plots the argument will apply to all plots. If you just want it for one plot, include it in geom_point
  geom_point(aes(color = factor(species), shape = factor(species)))+
  theme_bw()
```

![](s05_data-wrangling-exercise_part-2_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

7. Using the data from Task 5, plot the relationship between sepal width and
   sepal length. This time, separate each species into a different subplot 
   (facet).


```r
iris_in %>% 
  ggplot(aes(sepal_width, sepal_length)) +
  facet_wrap(~ species, nrow = 1, scale = "free") +
  geom_point(aes(color = factor(species)),alpha = 0.5) +
  theme_bw()
```

![](s05_data-wrangling-exercise_part-2_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

```r
#Can also do

iris_in %>% 
  ggplot(aes(sepal_width, sepal_length)) +
    geom_point(aes(color = factor(species), shape = factor(species)))+
    facet_grid(rows = vars(species))+
    theme_bw()
```

![](s05_data-wrangling-exercise_part-2_files/figure-html/unnamed-chunk-7-2.png)<!-- -->


# Back to Guide Again

Let's head back to the guide at the section on `summarize()`.


# Exercises for grouped data frames


```r
#Notes from second half of class

#Summarize breaks down a variable into one value (e.g. mean)
#Package, Table1 or Table One?

starwars %>%
  summarise_if(is.numeric, mean, na.rm = TRUE)
```

```
## # A tibble: 1 x 3
##   height  mass birth_year
##    <dbl> <dbl>      <dbl>
## 1   174.  97.3       87.6
```

```r
gapminder %>% 
  group_by(continent, year) #remember, group_by does not arrange them differently
```

```
## # A tibble: 1,704 x 6
## # Groups:   continent, year [60]
##    country     continent  year lifeExp      pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.
##  2 Afghanistan Asia       1957    30.3  9240934      821.
##  3 Afghanistan Asia       1962    32.0 10267083      853.
##  4 Afghanistan Asia       1967    34.0 11537966      836.
##  5 Afghanistan Asia       1972    36.1 13079460      740.
##  6 Afghanistan Asia       1977    38.4 14880372      786.
##  7 Afghanistan Asia       1982    39.9 12881816      978.
##  8 Afghanistan Asia       1987    40.8 13867957      852.
##  9 Afghanistan Asia       1992    41.7 16317921      649.
## 10 Afghanistan Asia       1997    41.8 22227415      635.
## # … with 1,694 more rows
```

```r
gapminder %>% 
  group_by(continent, year) %>% 
  summarize(mu = mean(lifeExp),
            sigma = sd(lifeExp))
```

```
## # A tibble: 60 x 4
## # Groups:   continent [5]
##    continent  year    mu sigma
##    <fct>     <int> <dbl> <dbl>
##  1 Africa     1952  39.1  5.15
##  2 Africa     1957  41.3  5.62
##  3 Africa     1962  43.3  5.88
##  4 Africa     1967  45.3  6.08
##  5 Africa     1972  47.5  6.42
##  6 Africa     1977  49.6  6.81
##  7 Africa     1982  51.6  7.38
##  8 Africa     1987  53.3  7.86
##  9 Africa     1992  53.6  9.46
## 10 Africa     1997  53.6  9.10
## # … with 50 more rows
```

```r
#You could use this to show mean (sd) for experimental and control group (e.g. group_by condition)

gapminder %>% 
  group_by(smallLifeExp = lifeExp < 60) #can create a new variable by which to group
```

```
## # A tibble: 1,704 x 7
## # Groups:   smallLifeExp [2]
##    country     continent  year lifeExp      pop gdpPercap smallLifeExp
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl> <lgl>       
##  1 Afghanistan Asia       1952    28.8  8425333      779. TRUE        
##  2 Afghanistan Asia       1957    30.3  9240934      821. TRUE        
##  3 Afghanistan Asia       1962    32.0 10267083      853. TRUE        
##  4 Afghanistan Asia       1967    34.0 11537966      836. TRUE        
##  5 Afghanistan Asia       1972    36.1 13079460      740. TRUE        
##  6 Afghanistan Asia       1977    38.4 14880372      786. TRUE        
##  7 Afghanistan Asia       1982    39.9 12881816      978. TRUE        
##  8 Afghanistan Asia       1987    40.8 13867957      852. TRUE        
##  9 Afghanistan Asia       1992    41.7 16317921      649. TRUE        
## 10 Afghanistan Asia       1997    41.8 22227415      635. TRUE        
## # … with 1,694 more rows
```

```r
gapminder %>% 
  group_by(country) %>% 
  summarize(n=n())
```

```
## # A tibble: 142 x 2
##    country         n
##    <fct>       <int>
##  1 Afghanistan    12
##  2 Albania        12
##  3 Algeria        12
##  4 Angola         12
##  5 Argentina      12
##  6 Australia      12
##  7 Austria        12
##  8 Bahrain        12
##  9 Bangladesh     12
## 10 Belgium        12
## # … with 132 more rows
```

```r
gapminder %>% 
  group_by(continent) %>% 
  summarize(n_countries = n_distinct(country)) #could also do = length(unique(country))
```

```
## # A tibble: 5 x 2
##   continent n_countries
##   <fct>           <int>
## 1 Africa             52
## 2 Americas           25
## 3 Asia               33
## 4 Europe             30
## 5 Oceania             2
```

```r
#This tells us number of countries within continents

gapminder %>% 
  group_by(continent) %>% 
  summarize(n_countries = n_distinct(country), mean_LifeExp = mean(lifeExp))
```

```
## # A tibble: 5 x 3
##   continent n_countries mean_LifeExp
##   <fct>           <int>        <dbl>
## 1 Africa             52         48.9
## 2 Americas           25         64.7
## 3 Asia               33         60.1
## 4 Europe             30         71.9
## 5 Oceania             2         74.3
```

```r
gap_inc <- gapminder %>% 
  arrange(year) %>% 
  group_by(country) %>% 
  mutate(gdpPercap_inc = round(gdpPercap - lag(gdpPercap), 2)) %>% 
  arrange(country)
#lag basically means the previous one. So gdpPercap minus the previous gdpPercap

gap_inc %>% 
  tidyr::drop_na()
```

```
## # A tibble: 1,562 x 7
## # Groups:   country [142]
##    country     continent  year lifeExp      pop gdpPercap gdpPercap_inc
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>         <dbl>
##  1 Afghanistan Asia       1957    30.3  9240934      821.          41.4
##  2 Afghanistan Asia       1962    32.0 10267083      853.          32.2
##  3 Afghanistan Asia       1967    34.0 11537966      836.         -16.9
##  4 Afghanistan Asia       1972    36.1 13079460      740.         -96.2
##  5 Afghanistan Asia       1977    38.4 14880372      786.          46.1
##  6 Afghanistan Asia       1982    39.9 12881816      978.         192. 
##  7 Afghanistan Asia       1987    40.8 13867957      852.        -126. 
##  8 Afghanistan Asia       1992    41.7 16317921      649.        -203. 
##  9 Afghanistan Asia       1997    41.8 22227415      635.         -14  
## 10 Afghanistan Asia       2002    42.1 25268405      727.          91.4
## # … with 1,552 more rows
```


Let's do some practice with grouping (and ungrouping) and summarizing data frames!

1. (a) What's the minimum life expectancy for each continent and each year? 
   (b) Add the corresponding country to the tibble, too. 
   (c) Arrange by min life expectancy.


```r
gapminder %>% 
  group_by(continent, year) %>% 
  summarize(min_life = min(lifeExp)) %>%  #not mutate() because it would be same length (not one value across each group of contintent/year). Not fully understanding this...
  select(continent, country, year, min_life) %>% 
  arrange(min_life)
```

```
## Error in .f(.x[[i]], ...): object 'country' not found
```


2. Let's compute the mean Agreeableness score across items for each participant 
in the `psych::bfi` dataset. Be sure to handle `NA`!


```r
psych::bfi %>%
  rownames_to_column(var = "ID") %>% 
  as_tibble() %>% 
  select(A1:A5) %>% 
  rowwise() %>% #each row is its own group (e.g. with participants)
  mutate(A_mean = mean(c(A1, A2, A3, A4, A5), na.rm = TRUE)) %>% #could use to produce mean score for each participant on items for a measure
  #the na.rm allows you to compute the mean even for individuals with missing data, etc.
  ungroup()
```

```
## # A tibble: 2,800 x 6
##       A1    A2    A3    A4    A5 A_mean
##    <int> <int> <int> <int> <int>  <dbl>
##  1     2     4     3     4     4    3.4
##  2     2     4     5     2     5    3.6
##  3     5     4     5     4     4    4.4
##  4     4     4     6     5     5    4.8
##  5     2     3     3     4     5    3.4
##  6     6     6     5     6     5    5.6
##  7     2     5     5     3     5    4  
##  8     4     3     1     5     1    2.8
##  9     4     3     6     3     3    3.8
## 10     2     5     6     6     5    4.8
## # … with 2,790 more rows
```

Now compute mean scores for Conscientiousness, as well as `sd` and `min` scores 
for reach person.


```r
psych::bfi %>%
  rownames_to_column(var = "ID") %>% 
  as_tibble() %>% 
  select(C1:C5) %>% 
  rowwise() %>% #each row is its own group (e.g. with participants)
  mutate(C_mean = mean(c(C1, C2, C3, C4, C5), na.rm = TRUE),
          C_sd = sd(c(C1, C2, C3, C4, C5), na.rm = TRUE),
          C_min = min(c(C1,C2, C3, C4, C5), na.rm = TRUE))
```

```
## Source: local data frame [2,800 x 8]
## Groups: <by row>
## 
## # A tibble: 2,800 x 8
##       C1    C2    C3    C4    C5 C_mean  C_sd C_min
##    <int> <int> <int> <int> <int>  <dbl> <dbl> <int>
##  1     2     3     3     4     4    3.2 0.837     2
##  2     5     4     4     3     4    4   0.707     3
##  3     4     5     4     2     5    4   1.22      2
##  4     4     4     3     5     5    4.2 0.837     3
##  5     4     4     5     3     2    3.6 1.14      2
##  6     6     6     6     1     3    4.4 2.30      1
##  7     5     4     4     2     3    3.6 1.14      2
##  8     3     2     4     2     4    3   1         2
##  9     6     6     3     4     5    4.8 1.30      3
## 10     6     5     6     2     1    4   2.35      1
## # … with 2,790 more rows
```

```r
  ungroup()
```

```
## Error in UseMethod("ungroup"): no applicable method for 'ungroup' applied to an object of class "NULL"
```

Some functions are **vectorized**, so you don't need `rowwise()`. 
For example, `pmin()` computes the "parallel min" across the vectors it receives:


```r
psych::bfi %>% 
  as_tibble() %>% 
  select(A1:A5) %>% 
  mutate(A_min = pmin(A1, A2, A3, A4, A5)) #pmin, not min
```

```
## # A tibble: 2,800 x 6
##       A1    A2    A3    A4    A5 A_min
##    <int> <int> <int> <int> <int> <int>
##  1     2     4     3     4     4     2
##  2     2     4     5     2     5     2
##  3     5     4     5     4     4     4
##  4     4     4     6     5     5     4
##  5     2     3     3     4     5     2
##  6     6     6     5     6     5     5
##  7     2     5     5     3     5     2
##  8     4     3     1     5     1     1
##  9     4     3     6     3     3     3
## 10     2     5     6     6     5     2
## # … with 2,790 more rows
```

**There are a few other ways to do this sort of computation.**

`rowMeans()` computes the mean of each row of a data frame. We can use it by
putting `select()` inside of `mutate()`:



```r
psych::bfi %>% 
  as_tibble() %>% 
  select(A1:A5) %>% 
  mutate(A_mn = rowMeans(select(., A1:A5)),
         A_mn2 = rowMeans(select(., starts_with("A", ignore.case = FALSE))))
```

```
## # A tibble: 2,800 x 7
##       A1    A2    A3    A4    A5  A_mn A_mn2
##    <int> <int> <int> <int> <int> <dbl> <dbl>
##  1     2     4     3     4     4   3.4   3.4
##  2     2     4     5     2     5   3.6   3.6
##  3     5     4     5     4     4   4.4   4.4
##  4     4     4     6     5     5   4.8   4.8
##  5     2     3     3     4     5   3.4   3.4
##  6     6     6     5     6     5   5.6   5.6
##  7     2     5     5     3     5   4     4  
##  8     4     3     1     5     1   2.8   2.8
##  9     4     3     6     3     3   3.8   3.8
## 10     2     5     6     6     5   4.8   4.8
## # … with 2,790 more rows
```

**In the development version of `dplyr`, there are some functions to make**
**this approach easier.**

```
remotes::install_github("tidyverse/dplyr")
```


```r
remotes::install_github("tidyverse/dplyr")
psych::bfi %>% 
  as_tibble() %>% 
  select(A1:A5) %>% 
  mutate(A_mn = rowMeans(across(A1:A5)),
         A_mn2 = rowMeans(across(starts_with("A", ignore.case = FALSE))))
```

3. Let's use `psych::bfi` and make a new data frame that has
   (1) each participant's educational level (convert it to a categorical variable
   using `factor()`) and the mean score for each of the Big Five scales for each 
   participant. Store this data frame as a new object.
   

```r
psychbfi_edu <-
  psych::bfi %>% 
  mutate(education = factor(education)) %>% 
  rowwise() %>% 
  mutate(A_mean = mean(c(A1, A2, A3, A4, A5), na.rm = TRUE),
        C_mean = mean(c(C1, C2, C3, C4, C5), na.rm = TRUE),
        N_mean = round(mean(c(N1, N2, N3, N4, N5), na.rm = TRUE), 2),
        O_mean = mean(c(O1, O2, O3, O4, O5), na.rm = TRUE),
        E_mean = mean(c(E1, E2, E3, E4, E5), na.rm = TRUE))
```

4. Use the data from Task 3 to summarize the distributions of Big Five scores 
   for each educational level (e.g., report the mean, sd, min, and max for
   each score in each group). Also report the sample size within each group.
   

```r
psychbfi_edu %>% 
  group_by(education) %>% 
  summarise(A_mean = mean(c(A1, A2, A3, A4, A5), na.rm = TRUE),
        C_mean = mean(c(C1, C2, C3, C4, C5), na.rm = TRUE),
        N_mean = round(mean(c(N1, N2, N3, N4, N5), na.rm = TRUE), 2),
        O_mean = mean(c(O1, O2, O3, O4, O5), na.rm = TRUE),
        E_mean = mean(c(E1, E2, E3, E4, E5), na.rm = TRUE),
        A_sd = sd(c(A1, A2, A3, A4, A5), na.rm = TRUE),
        C_sd = sd(c(C1, C2, C3, C4, C5), na.rm = TRUE),
        N_sd = round(sd(c(N1, N2, N3, N4, N5), na.rm = TRUE), 2),
        O_sd = sd(c(O1, O2, O3, O4, O5), na.rm = TRUE),
        E_sd = sd(c(E1, E2, E3, E4, E5), na.rm = TRUE),
        A_min = min(c(A1, A2, A3, A4, A5), na.rm = TRUE),
        C_min = min(c(C1, C2, C3, C4, C5), na.rm = TRUE),
        N_min = round(min(c(N1, N2, N3, N4, N5), na.rm = TRUE), 2),
        O_min = min(c(O1, O2, O3, O4, O5), na.rm = TRUE),
        E_min = min(c(E1, E2, E3, E4, E5), na.rm = TRUE),
        A_max = max(c(A1, A2, A3, A4, A5), na.rm = TRUE),
        C_max = max(c(C1, C2, C3, C4, C5), na.rm = TRUE),
        N_max = round(max(c(N1, N2, N3, N4, N5), na.rm = TRUE), 2),
        O_max = max(c(O1, O2, O3, O4, O5), na.rm = TRUE),
        E_max = max(c(E1, E2, E3, E4, E5), na.rm = TRUE),
            n = length(education))
```

```
## Warning: Grouping rowwise data frame strips rowwise nature
```

```
## Warning: Factor `education` contains implicit NA, consider using
## `forcats::fct_explicit_na`
```

```
## # A tibble: 6 x 22
##   education A_mean C_mean N_mean O_mean E_mean  A_sd  C_sd  N_sd  O_sd  E_sd
##   <fct>      <dbl>  <dbl>  <dbl>  <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 1           4.16   3.79   3.26   3.85   3.74  1.58  1.54  1.63  1.70  1.57
## 2 2           4.27   3.83   3.23   3.89   3.81  1.58  1.60  1.68  1.69  1.64
## 3 3           4.33   3.78   3.13   3.89   3.82  1.60  1.60  1.59  1.62  1.61
## 4 4           4.08   3.82   3.06   3.84   3.77  1.61  1.54  1.57  1.70  1.60
## 5 5           4.15   3.87   3.07   3.89   3.79  1.64  1.58  1.51  1.77  1.59
## 6 <NA>        3.91   3.80   3.5    3.75   3.71  1.57  1.45  1.6   1.66  1.62
## # … with 11 more variables: A_min <int>, C_min <int>, N_min <dbl>, O_min <int>,
## #   E_min <int>, A_max <int>, C_max <int>, N_max <dbl>, O_max <int>,
## #   E_max <int>, n <int>
```



# Bonus Exercises

1. In `gapminder`, take all countries in Europe that have a GDP per capita 
   greater than 10000, and select all variables except `gdpPercap`. 
   (Hint: use `-`).

2. Take the first three columns of `gapminder` and extract the names.

3. In `gapminder`, convert the population to a number in billions.

4. Take the `iris` data frame and extract all columns that start with 
   the word "Petal". 
    - Hint: take a look at the "Select helpers" documentation by running the 
      following code: `?tidyselect::select_helpers`.

5. Filter the rows of `iris` for Sepal.Length >= 4.6 and Petal.Width >= 0.5.

6. Calculate the growth in population since the first year on record 
_for each country_ by rearranging the following lines, and filling in the 
`FILL_THIS_IN`. Here's another convenience function for you: `dplyr::first()`. 

```
mutate(rel_growth = FILL_THIS_IN) %>% 
arrange(FILL_THIS_IN) %>% 
gapminder %>% 
knitr::kable()
group_by(country) %>% 
```




7. Determine the country, on each continent, that experienced the 
**sharpest 5-year drop in life expectancy**, sorted by the drop, by rearranging 
the following lines of code. Ensure there are no `NA`'s. A helpful function to 
compute changes in a variable across rows of data (e.g., for time-series data) 
is `tsibble::difference()`:

```
drop_na() %>% 
ungroup() %>% 
arrange(year) %>% 
filter(inc_life_exp == min(inc_life_exp)) %>% 
gapminder %>% 
mutate(inc_life_exp = FILL_THIS_IN) %>% # Compute the changes in life expectancy
arrange(inc_life_exp) %>% 
group_by(country) %>% 
group_by(continent) %>% 
knitr::kable()
```



Exercises 4. and 5. are from 
[r-exercises](https://www.r-exercises.com/2017/10/19/dplyr-basic-functions-exercises/).
