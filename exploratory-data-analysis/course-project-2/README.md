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

```r
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")

df <- tbl_df(NEI) %>%
      group_by(year) %>%                        # group observations by year
      summarise_each(funs(sum), Emissions) %>%  # calculate sum of emissions by year
      mutate_each(funs(. / 1000), Emissions)    # convert tons of emissions to thousands of tons

png(file = "plot1.png", width = 1280, height = 768)
with(df, {
  plot(Emissions ~ year,
    type = "n",
    xaxt = "n",
    xlab = "Year",
    ylab = expression("Total PM"[2.5] * " Emission (in thousands of tons)"),
    main = expression("Total PM"[2.5] * " Emission (1999 — 2008)"))
  axis(side = 1, at = c("1999", "2002", "2005", "2008"))
  abline(lm(Emissions ~ year), col = "blue", lwd = 3, lty = "dashed")
  points(Emissions ~ year, pch = 4, col = "red")
})
dev.off()
```

![thumb](/exploratory-data-analysis/course-project-2/plot1.png?raw=true)

2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?

```r
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")

df <- tbl_df(NEI) %>%
      subset(fips == "24510") %>%           # subset Baltimore City observations
      group_by(year) %>%                    # group observations by year
      summarise_each(funs(sum), Emissions)  # calculate sum of emissions by year

png(file = "plot2.png", width = 1280, height = 768)
with(df, {
  plot(Emissions ~ year,
    type = "n",
    xaxt = "n",
    xlab = "Year",
    ylab = expression("Total PM"[2.5] * " Emission (in tons)"),
    main = expression("Total PM"[2.5] * " Emission in Baltimore (1999 — 2008)"))
  axis(side = 1, at = c("1999", "2002", "2005", "2008"))
  abline(lm(Emissions ~ year), col = "blue", lwd = 3, lty = "dashed")
  points(Emissions ~ year, pch = 4, col = "red")
})
dev.off()
```

![thumb](/exploratory-data-analysis/course-project-2/plot2.png?raw=true)

3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?

```r
# Which of four sources have seen decreases in emissions from 1999–2008 for
# Baltimore City? Which have seen increases in emissions from 1999–2008?
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

df <- tbl_df(NEI) %>%
      subset(fips == "24510") %>%           # subset Baltimore City observations
      group_by(type, year) %>%              # group observations by type and year
      summarise_each(funs(sum), Emissions)  # calculate sum of emissions by year

png(file = "plot3.png", width = 1280, height = 768)

g <- ggplot(df, aes(x=factor(year), Emissions))
g + geom_smooth(aes(group=1), method="lm") +
    geom_point(aes(col=type)) +
    theme_bw() +
    theme(legend.position = "none") +
    facet_wrap(~type, nrow = 2) +
    labs(x = "Year") +
    labs(y = expression("Total PM"[2.5] * " Emission (in tons)")) +
    labs(title = expression("Total PM"[2.5] * " Emission in Baltimore by type (1999 — 2008)"))

dev.off()
```

![thumb](/exploratory-data-analysis/course-project-2/plot3.png?raw=true)

4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

```r
# Across the United States, how have emissions from coal
# combustion-related sources changed from 1999–2008?
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- tbl_df(NEI) %>%
      merge(tbl_df(SCC), by = "SCC") %>%                          # merge source classification codes
      filter(grepl("Comb.*Coal", EI.Sector, ignore.case = T)) %>% # filter coal combustion-related sources
      group_by(year) %>%                                          # group observations by year
      summarise_each(funs(sum), Emissions) %>%                    # calculate sum of emissions by year
      mutate_each(funs(. / 1000), Emissions)                      # convert tons of emissions to thousands of tons

png(file = "plot4.png", width = 1280, height = 768)

g <- ggplot(df, aes(x=factor(year), Emissions))
g + geom_bar(aes(fill=year), stat = "identity") +
    guides(fill=FALSE) +
    theme_bw() +
    labs(x = "Year") +
    labs(y = expression("Total PM"[2.5] * " Emission (in thousands of tons)")) +
    labs(title = expression("Coal combustion-related PM"[2.5] * " Emission (1999 — 2008)"))

dev.off()
```

![thumb](/exploratory-data-analysis/course-project-2/plot4.png?raw=true)

5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

```r
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- tbl_df(NEI) %>%
      subset(fips == "24510") %>%                                   # subset Baltimore City observations
      merge(tbl_df(SCC), by = "SCC") %>%                            # merge source classification codes
      filter(grepl("vehicle", SCC.Level.Two, ignore.case = T)) %>%  # filter motor vehicle sources
      group_by(year) %>%                                            # group observations by year
      summarise_each(funs(sum), Emissions)                          # calculate sum of emissions by year

png(file = "plot5.png", width = 1280, height = 768)

g <- ggplot(df, aes(x=factor(year), Emissions))
g + geom_bar(aes(fill=year), stat = "identity") +
    guides(fill=FALSE) +
    theme_bw() +
    labs(x = "Year") +
    labs(y = expression("Total PM"[2.5] * " Emission (in tons)")) +
    labs(title = expression("Motor vehicle PM"[2.5] * " Emission in Baltimore (1999 — 2008)"))

dev.off()
```

![thumb](/exploratory-data-analysis/course-project-2/plot5.png?raw=true)

6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California. Which city has seen greater changes over time in motor vehicle emissions?

```r
# Compare emissions from motor vehicle sources in Baltimore City
# with emissions from motor vehicle sources in Los Angeles County, California.
# Which city has seen greater changes over time in motor vehicle emissions?
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- tbl_df(NEI) %>%
      subset(fips %in% c("24510", "06037")) %>%                     # subset Baltimore and LA observations
      mutate(city = factor(fips,                                    # create column with city name
        levels=c("24510", "06037"),
        labels=c("Baltimore City", "Los Angeles County"))) %>%
      merge(tbl_df(SCC), by = "SCC") %>%                            # merge source classification codes
      filter(grepl("vehicle", SCC.Level.Two, ignore.case = T)) %>%  # filter motor vehicle sources
      group_by(city, year) %>%                                      # group observations by city and year
      summarise_each(funs(sum), Emissions)                          # calculate sum of emissions by year

png(file = "plot6.png", width = 1280, height = 768)

g <- ggplot(df, aes(x = factor(year), Emissions))
g + geom_bar(aes(fill = city), stat = "identity") +
    geom_smooth(aes(group = 1), linetype = 0, method = "lm") +
    guides(fill = FALSE) +
    theme_bw() +
    facet_wrap(~city) +
    labs(x = "Year") +
    labs(y = expression("Total PM"[2.5] * " Emission (in tons)")) +
    labs(title = expression("Total PM"[2.5] * " Emission (1999 — 2008)"))

dev.off()
```

![thumb](/exploratory-data-analysis/course-project-2/plot6.png?raw=true)