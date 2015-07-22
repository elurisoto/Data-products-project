library(rCharts)


countries = c("Austria", "Belgium", "Bulgaria", "Switzerland", "Cyprus", 
							"Czech Republic", "Germany", "Denmark", "Estonia", "Greece", "Spain", 
							"Original EU Members Average (EU15)", "EU Members Average (EU28)", 
							"Finland", "France", "Croatia", "Hungary", "Ireland", "Iceland", 
							"Italy", "Japan", "Republic of Korea", "Lithuania", "Luxembourg", 
							"Latvia", "Malta", "Netherlands", "Norway", "Poland", "Portugal", 
							"Romania", "Russian Federation", "Sweden", "Slovenia", "Slovakia", 
							"United Kingdom", "United States")

# Convert data to numeric and remove characters
getNumber <- function(x){
	suppressWarnings(as.numeric(substr(x, 1, 4)))
}
transform <- function(x){
	chars <- sapply(x, as.character)
	numbers <- sapply(chars, getNumber)
	names(numbers) <- NULL
	numbers
}


loadData <- function(){
	file = "data/gba_nabste.tsv"
	data <- read.delim(file)
	data <- as.data.frame(data, stringsAsFactors=FALSE)
	data[,1] <- NULL
	# Order year columns
	data <- data[,length(data):1]
	colnames(data) <- 1980:2013
	
	
	data <- sapply(data, transform)
	rownames(data) <- countries
	data <- as.data.frame(t(data))
	data$Average <- apply(data,1,function(x) mean(x,na.rm=TRUE))
	data$year <- 1980:2013

	data
}



