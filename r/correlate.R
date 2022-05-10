args <- commandArgs(trailingOnly=TRUE)
x <- read.csv(args[1])[, c("ZCTA5CE20", "Value")]
print(x)
y <- read.csv(args[2])[, c("ZCTA5CE20", "Value")]
print(y)
data <- merge(x, y, by = "ZCTA5CE20")
print(data)
c <- cor(data$Value.x, data$Value.y)
print(c)
write(paste("Corrleation coefficient = ", c), file="pearson.txt")