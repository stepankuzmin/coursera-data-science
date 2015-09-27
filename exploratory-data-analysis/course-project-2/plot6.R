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

png(file = "plot6.png", width = 1024, height = 768)

g <- ggplot(df, aes(x = factor(year), Emissions))
g + geom_bar(aes(fill = city), stat = "identity") +
    geom_smooth(aes(group = 1), linetype = 0, method = "lm") +
    guides(fill = FALSE) +
    theme_bw() +
    facet_wrap(~city) +
    labs(x = "Year") +
    labs(y = expression("Total PM"[2.5] * " Emission (in tons)")) +
    labs(title = expression("Total PM"[2.5] * " Emission in Baltimore City and Los Angeles County from 1999 to 2008"))

dev.off()