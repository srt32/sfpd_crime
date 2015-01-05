# pull in data
file = file.path("/Users/Simon/Projects/Personal/sfpd_crime/SFPD_2014.csv")
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
  #as.numeric(strsplit(string, ":")[[1]][1])
  (strsplit(string, ":")[[1]][1])
}

# histrogram by HOD
thefts.auto.tod <- thefts.auto[,c("IncidntNum", "Time")]
thefts.auto.tod.normalized <- cbind(
  thefts.auto.tod, TimeInt = mapply(HoursStringToInt, thefts.auto.tod$Time)
)
colnames(thefts.auto.tod.normalized) <- c("IncidntNum", "Time", "Hour")
head(thefts.auto.tod.normalized)

barplot(table(thefts.auto.tod.normalized$Hour))