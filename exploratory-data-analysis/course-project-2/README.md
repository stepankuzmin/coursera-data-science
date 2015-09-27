# [Exploratory Data Analysis](https://class.coursera.org/exdata-032/)

## Course Project 2

## Dependencies

`dplyr` and `ggplot2` libraries needs to be installed into R:

```r
install.packages("dplyr")
install.packages("ggplot2")
```

## tl;dr;

```shell
for script in *.R; do Rscript $script; done
```

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

![thumb](/exploratory-data-analysis/course-project-2/plot1.png?raw=true)

```shell
Rscript plot1.R
```

2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?

![thumb](/exploratory-data-analysis/course-project-2/plot2.png?raw=true)

```shell
Rscript plot2.R
```

3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?

![thumb](/exploratory-data-analysis/course-project-2/plot3.png?raw=true)

```shell
Rscript plot3.R
```

4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

![thumb](/exploratory-data-analysis/course-project-2/plot4.png?raw=true)

```shell
Rscript plot4.R
```

5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

![thumb](/exploratory-data-analysis/course-project-2/plot5.png?raw=true)

```shell
Rscript plot5.R
```

6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California. Which city has seen greater changes over time in motor vehicle emissions?

![thumb](/exploratory-data-analysis/course-project-2/plot6.png?raw=true)

```shell
Rscript plot6.R
```
