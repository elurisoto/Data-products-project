library(shiny)
library(rCharts)

shinyUI(pageWithSidebar(
	
	headerPanel("Investment on research as percentage of global budget"),
	sidebarPanel(
		sliderInput('selectedYears', 'Select the year range',value = c(1995,2013), 
								min = 1980, max = 2013, step = 1),
		uiOutput("selectCountries"),
		actionButton(inputId = "clearAll", label = "Clear selection", icon = icon("check-square")),
		actionButton(inputId = "selectAll", label = "Select all", icon = icon("check-square-o"))
	),
	
	mainPanel(
		h3('Investment over the years'),
		p('Hover the graph to see details.'),
		showOutput("myChart", lib = "morris")
	)
	
))