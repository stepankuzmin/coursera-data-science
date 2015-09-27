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

png(file = "plot4.png", width = 1024, height = 768)

g <- ggplot(df, aes(x=factor(year), Emissions))
g + geom_bar(aes(fill=year), stat = "identity") +
    guides(fill=FALSE) +
    theme_bw() +
    labs(x = "Year") +
    labs(y = expression("Total PM"[2.5] * " Emission (in thousands of tons)")) +
    labs(title = expression("Coal combustion-related PM"[2.5] * " Emission in the United States from 1999 to 2008"))

dev.off()