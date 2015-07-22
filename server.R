library(shiny)
library(rCharts)
source("load.R", local = TRUE)

data <- loadData()

countries = c("Austria", "Belgium", "Bulgaria", "Switzerland", "Cyprus", 
							"Czech Republic", "Germany", "Denmark", "Estonia", "Greece", "Spain", 
							"Original EU Members Average (EU15)", "EU Members Average (EU28)", 
							"Finland", "France", "Croatia", "Hungary", "Ireland", "Iceland", 
							"Italy", "Japan", "Republic of Korea", "Lithuania", "Luxembourg", 
							"Latvia", "Malta", "Netherlands", "Norway", "Poland", "Portugal", 
							"Romania", "Russian Federation", "Sweden", "Slovenia", "Slovakia", 
							"United Kingdom", "United States")


shinyServer(function(input, output, session) {
	values <- reactiveValues()
	output$selectCountries <- renderUI({
		checkboxGroupInput('selectedCountries', 'Select countries', countries,
											 selected = c("Spain", "Austria"))
	})
	
	
	observe({
		if(input$clearAll > 0 && !is.null(input$clearAll)){
			updateCheckboxGroupInput(session, 'selectedCountries', 
															 choices = countries, 
															 selected=c())	
		}
	})
	
	observe({
		if(input$selectAll > 0 && !is.null(input$selectAll)){
			updateCheckboxGroupInput(session, 'selectedCountries', 
															 choices = countries, 
															 selected=countries)
		}
	})
	
	output$myChart <- renderChart({

		validate(need(input$selectedYears, ''),
						 need(input$selectedCountries, ''))
		
		years <- input$selectedYears - 1979
		plt <- mPlot(
			x = "year", y = as.character(input$selectedCountries), 
			data = data[years[1]:years[2],], 
			type = "Line", smooth = FALSE, hideHover = 'auto', parseTime=FALSE,
			ymin = min(data[,as.character(input$selectedCountries)] - 0.05, na.rm=TRUE),
			ymax = max(data[,as.character(input$selectedCountries)] + 0.05, na.rm=TRUE),
			labels = as.character(input$selectedCountries), resize=TRUE, width=600
		)
		plt$set(dom = "myChart")
		return(plt)
		
		
	})
	
})