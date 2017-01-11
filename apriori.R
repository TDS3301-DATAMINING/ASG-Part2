# Set directory
setwd("/Users/yongching/Desktop")

# Read data for 1000 records
bakery <- read.csv(file ='1000-out2.csv', header = FALSE, col.names = c("Receipt_No",
                                                                        "Chocolate_Cake",
                                                                        "Lemon_Cake",
                                                                        "Casino_Cake",
                                                                        "Opera_Cake",
                                                                        "Strawberry_Cake",
                                                                        "Truffle_Cake",
                                                                        "Chocolate_Eclair",
                                                                        "Coffee_Eclair",
                                                                        "Vanilla_Eclair",
                                                                        "Napoleon_Cake",
                                                                        "Almond_Tart",
                                                                        "Apple_Pie",
                                                                        "Apple_Tart",
                                                                        "Apricot_Tart",
                                                                        "Berry_Tart",
                                                                        "Blackberry_Tart",
                                                                        "Blueberry_Tart",
                                                                        "Chocolate_Tart",
                                                                        "Cherry_Tart",
                                                                        "Lemon_Tart",
                                                                        "Pecan_Tart",
                                                                        "Ganache_Cookie",
                                                                        "Gongolais_Cookie",
                                                                        "Raspberry_Cookie",
                                                                        "Lemon_Cookie",
                                                                        "Chocolate_Meringue",
                                                                        "Vanilla_Meringue",
                                                                        "Marzipan_Cookie",
                                                                        "Tuile_Cookie",
                                                                        "Walnut_Cookie",
                                                                        "Almond_Croissant",
                                                                        "Apple_Croissant",
                                                                        "Apricot_Croissant",
                                                                        "Cheese_Croissant",
                                                                        "Chocolate_Croissant",
                                                                        "Apricot_Danish",
                                                                        "Apple_Danish",
                                                                        "Almond_Twist",
                                                                        "Almond_Bear Claw",
                                                                        "Blueberry_Danish",
                                                                        "Lemon_Lemonade",
                                                                        "Raspberry_Lemonade",
                                                                        "Orange_Juice",
                                                                        "Green_Tea",
                                                                        "Bottled_Water",
                                                                        "Hot_Coffee",
                                                                        "Chocolate_Coffee",
                                                                        "Vanilla_Frappuccino",
                                                                        "Cherry_Soda",
                                                                        "Single_Espresso"))
str(bakery)

# Check for missing value
sum(is.na(bakery)) # 0

# Replace 0 and 1 with Yes and No
bakery$Receipt_No <- NULL
bakery[, 1:50][bakery[, 1:50] == 0] <- "No"
bakery[, 1:50][bakery[, 1:50] == 1] <- "Yes"

# Turn all columns into factor columns
bakery <- as.data.frame(unclass(bakery))
str(bakery)

# Install package and run apriori algorithm
install.packages("arules")
library(arules)

rules<-apriori(bakery, control=list(verbose=F),                
               parameter=list(minlen=2,supp=0.6,conf=0.8))
inspect(rules)


