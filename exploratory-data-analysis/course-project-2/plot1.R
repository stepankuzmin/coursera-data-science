# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")

df <- tbl_df(NEI) %>%
      group_by(year) %>%                        # group observations by year
      summarise_each(funs(sum), Emissions) %>%  # calculate sum of emissions by year
      mutate_each(funs(. / 1000), Emissions)    # convert tons of emissions to thousands of tons

png(file = "plot1.png")
with(df, {
  plot(Emissions ~ year,
    type = "n",
    xlab = "Year",
    ylab = expression("Total PM"[2.5] * " Emission (in thousands tons)"),
    main = expression("Total PM"[2.5] * " Emission (1999 — 2008)"))
  lines(Emissions ~ year, col = "blue", lwd = 1)
  points(Emissions ~ year, pch = 4, col = "red")
})
dev.off()