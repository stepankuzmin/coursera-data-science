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

png(file = "plot5.png")

g <- ggplot(df, aes(x=factor(year), Emissions))
g + geom_bar(aes(fill=year), stat = "identity") +
    guides(fill=FALSE) +
    theme_bw() +
    labs(x = "Year") +
    labs(y = expression("Total PM"[2.5] * " Emission (in tons)")) +
    labs(title = expression("Motor vehicle PM"[2.5] * " Emission in Baltimore (1999 — 2008)"))

dev.off()