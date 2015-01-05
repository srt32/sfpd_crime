# pull in data
file = file.path("/Users/Simon/Projects/Personal/sfpd_crime/SFPD_2014.csv")
data = read.csv(file)

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

# histrogram by HOD
str(thefts.auto)
