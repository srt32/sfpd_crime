package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"time"
)

type Incident struct {
	IncidntNum string
	Descript   string
	DayOfWeek  string
	Date       string
	Time       string
	District   string
	lat        string
	long       string
	Datetime   time.Time
}

func main() {
	rawData, err := loadData()

	if err != nil {
		fmt.Println("Loading data went wrong")
		os.Exit(1)
	}

	var allIncidents []Incident

	for _, record := range rawData {
		allIncidents = append(allIncidents, Incident{
			IncidntNum: record[0],
			Descript:   record[2],
			DayOfWeek:  record[3],
			Date:       record[4],
			Time:       record[5],
			District:   record[6],
			lat:        record[9],
			long:       record[10],
		})
	}

	autoTheftIncidents := filterIncidents(allIncidents)

	// TODO fetch weather data for district (to limit calls) and date (& time?) if not exists
	// https://github.com/mlbright/forecast
}

func filterIncidents(allIncidents []Incident) []Incident {
	var autoTheftIncidents []Incident

	for _, incident := range allIncidents {
		if incident.Descript == "GRAND THEFT FROM LOCKED AUTO" {
			rawDatetime := incident.Date + " " + incident.Time + ":00"

			// TODO: make into PST
			parsedDate, err := time.Parse("01/02/2006 15:04:05", rawDatetime)
			if err != nil {
				fmt.Printf("Attmped to parse: %v but got %v", rawDatetime, err)
			}
			incident.Datetime = parsedDate

			autoTheftIncidents = append(autoTheftIncidents, incident)
		}
	}
	return autoTheftIncidents
}

func loadData() (data [][]string, err error) {
	csvfile, err := os.Open("data/SFPD_2014.csv")

	if err != nil {
		fmt.Println(err)
		return nil, err
	}

	defer csvfile.Close()

	reader := csv.NewReader(csvfile)

	rawCSVData, err := reader.ReadAll()

	if err != nil {
		fmt.Println(err)
		return nil, err
	}

	return rawCSVData, nil
}
