# pull in data
file = file.path("/Users/Simon/Projects/Personal/sfpd_crime/data/SFPD_2014.csv")
data = read.csv(file, stringsAsFactors=FALSE)

# filter by theft from auto
thefts.auto = data[data$Descript == "GRAND THEFT FROM LOCKED AUTO",]

# barplot by DOW
barplot(
  table(
    factor(
      thefts.auto$DayOfWeek, levels=c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
    )
  )
)

HoursStringToInt <- function(string) {
  (strsplit(string, ":")[[1]][1])
}

# barplot by HOD
thefts.auto.tod <- thefts.auto[,c("IncidntNum", "Time")]
thefts.auto.tod.normalized <- cbind(
  thefts.auto.tod, Hour = mapply(HoursStringToInt, thefts.auto.tod$Time)
)
head(thefts.auto.tod.normalized)

barplot(table(thefts.auto.tod.normalized$Hour))
