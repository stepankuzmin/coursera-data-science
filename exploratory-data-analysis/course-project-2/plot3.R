# Which of four sources have seen decreases in emissions from 1999–2008 for
# Baltimore City? Which have seen increases in emissions from 1999–2008?
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

df <- tbl_df(NEI) %>%
      subset(fips == "24510") %>%           # subset Baltimore City observations
      group_by(type, year) %>%              # group observations by type and year
      summarise_each(funs(sum), Emissions)  # calculate sum of emissions by year

png(file = "plot3.png", width = 1024, height = 768)

g <- ggplot(df, aes(x=factor(year), Emissions))
g + geom_smooth(aes(group=1), method="lm") +
    geom_point(aes(col=type)) +
    theme_bw() +
    theme(legend.position = "none") +
    facet_wrap(~type, nrow = 2) +
    labs(x = "Year") +
    labs(y = expression("Total PM"[2.5] * " Emission (in tons)")) +
    labs(title = expression("Total PM"[2.5] * " Emission in the Baltimore City, Maryland from 1999 to 2008"))

dev.off()