# Of the four types of sources indicated by the type, which of these four
# sources have seen decreases in emissions from 1999–2008 for Baltimore City?
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

df <- tbl_df(NEI) %>%
      subset(fips == "24510") %>%           # subset Baltimore City observations
      group_by(type, year) %>%              # group observations by type and year
      summarise_each(funs(sum), Emissions)  # calculate sum of emissions by year

png(file = "plot3.png")

g <- ggplot(df, aes(year, Emissions))
g + geom_line(col = "blue", lwd = 1) +
    geom_point(pch = 4, col = "red", size = 4) +
    # geom_smooth(method = "lm") +
    facet_wrap(~type, nrow = 2) +
    labs(x = "Year") +
    labs(y = expression("Total PM"[2.5] * " Emission (in tons)")) +
    labs(title = expression("Total PM"[2.5] * " Emission in Baltimore (1999 — 2008)"))

dev.off()