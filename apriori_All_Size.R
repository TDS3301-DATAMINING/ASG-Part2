# Install package and run apriori algorithm
install.packages("arules")
library(arules)

# Convert item codes to item names
product_names <- c("Chocolate_Cake", "Lemon_Cake",
                   "Casino_Cake", "Opera_Cake", "Strawberry_Cake", "Truffle_Cake", "Chocolate_Eclair",
                   "Coffee_Eclair", "Vanilla_Eclair", "Napoleon_Cake", "Almond_Tart", "Apple_Pie",
                   "Apple_Tart", "Apricot_Tart", "Berry_Tart", "Blackberry_Tart", "Blueberry_Tart",
                   "Chocolate_Tart", "Cherry_Tart", "Lemon_Tart", "Pecan_Tart", "Ganache_Cookie",
                   "Gongolais_Cookie","Raspberry_Cookie","Lemon_Cookie","Chocolate_Meringue",
                   "Vanilla_Meringue", "Marzipan_Cookie", "Tuile_Cookie", "Walnut_Cookie", "Almond_Croissant",
                   "Apple_Croissant", "Apricot_Croissant", "Cheese_Croissant", "Chocolate_Croissant", "Apricot_Danish",
                   "Apple_Danish", "Almond_Twist", "Almond_Bear Claw", "Blueberry_Danish", "Lemon_Lemonade",
                   "Raspberry_Lemonade", "Orange_Juice", "Green_Tea", "Bottled_Water", "Hot_Coffee",
                   "Chocolate_Coffee", "Vanilla_Frappuccino", "Cherry_Soda", "Single_Espresso")

product_names <- as.character(product_names)

df = read.csv(file="1000-out1.csv", header = FALSE, col.names = c("V1","V2","V3","V4","V5","V6","V7","V8","V9"))
df2 = read.csv(file="5000-out1.csv", header = FALSE, col.names = c("V1","V2","V3","V4","V5","V6","V7","V8","V9"))
df3 = read.csv(file="20000-out1.csv", header = FALSE, col.names = c("V1","V2","V3","V4","V5","V6","V7","V8","V9"))
df4 = read.csv(file="75000-out1.csv", header = FALSE, col.names = c("V1","V2","V3","V4","V5","V6","V7","V8","V9"))

#Replace product values with product names
df$V1 <- NULL
for(i in 1:ncol(df)){
  df[,i] <- product_names[df[,i] + 1]
}

df2$V1 <- NULL
for(i in 1:ncol(df2)){
  df2[,i] <- product_names[df2[,i] + 1]
}

df3$V1 <- NULL
for(i in 1:ncol(df3)){
  df3[,i] <- product_names[df3[,i] + 1]
}

df4$V1 <- NULL
for(i in 1:ncol(df4)){
  df4[,i] <- product_names[df4[,i] + 1]
}



write.csv(df, "basket1000.csv")
write.csv(df2, "basket5000.csv")
write.csv(df3,"basket20000.csv")
write.csv(df4,"basket75000.csv")

# Read data for 1000,5000,20000,75000 records
transaction = read.transactions(file="basket1000.csv", rm.duplicates=F, format = "basket", sep = ",", skip = 1,cols = 1)
transaction2 = read.transactions(file="basket5000.csv", rm.duplicates=F, format = "basket", sep = ",", skip = 1,cols = 1)
transaction3= read.transactions(file="basket20000.csv", rm.duplicates=F, format = "basket", sep = ",", skip = 1,cols = 1)
transaction4 = read.transactions(file="basket75000.csv", rm.duplicates=F, format = "basket", sep = ",", skip = 1,cols = 1)

inspect(transaction)

#generating rules for 1000,5000,20000,75000

# Start the clock!
ptm <- proc.time()

basket_rules <- apriori(transaction, parameter = list(sup = 0.006, conf = 0.8, target="rules"))

basket_rules2 <- apriori(transaction2, parameter = list(sup = 0.006, conf = 0.8, target="rules"))

basket_rules3 <- apriori(transaction3, parameter = list(sup = 0.006, conf = 0.8, target="rules"))

basket_rules4 <- apriori(transaction4, parameter = list(sup = 0.006, conf = 0.8, target="rules"))

inspect(basket_rules)

# Stop the clock
proc.time() - ptm


# Round up to 3 digits
quality(basket_rules)<-round(quality(basket_rules),digits=3)
quality(basket_rules2)<-round(quality(basket_rules2),digits=3)
quality(basket_rules3)<-round(quality(basket_rules3),digits=3)
quality(basket_rules4)<-round(quality(basket_rules4),digits=3)

inspect(basket_rules)

# Sort by lift (to get the more interesting rules on top)
basket_rules.sorted <- sort(basket_rules, by="lift")
basket_rules2.sorted <- sort(basket_rules2, by="lift")
basket_rules3.sorted <- sort(basket_rules3, by="lift")
basket_rules4.sorted <- sort(basket_rules4, by="lift")
inspect(basket_rules.sorted)

# Step to remove redundant rules
subset.matrix <- is.subset(basket_rules.sorted, basket_rules.sorted)
subset2.matrix <- is.subset(basket_rules2.sorted, basket_rules2.sorted)
subset3.matrix <- is.subset(basket_rules3.sorted, basket_rules3.sorted)
subset4.matrix <- is.subset(basket_rules4.sorted, basket_rules4.sorted)

View(subset.matrix)

subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- basket_rules.sorted[!redundant]

subset2.matrix[lower.tri(subset2.matrix, diag=T)] <- NA
redundant2 <- colSums(subset2.matrix, na.rm=T) >= 1
which(redundant2)
rules2.pruned <- basket_rules2.sorted[!redundant2]

subset3.matrix[lower.tri(subset3.matrix, diag=T)] <- NA
redundant3 <- colSums(subset3.matrix, na.rm=T) >= 1
which(redundant3)
rules3.pruned <- basket_rules3.sorted[!redundant3]

subset4.matrix[lower.tri(subset4.matrix, diag=T)] <- NA
redundant4 <- colSums(subset4.matrix, na.rm=T) >= 1
which(redundant4)
rules4.pruned <- basket_rules4.sorted[!redundant4]


inspect(rules4.pruned)

# Plot graph for 1000,5000,20000,75000
library(arulesViz)
plot(basket_rules, method = "grouped", control = list(k = 10))
itemFrequencyPlot(transaction, topN = 20, type="absolute")

plot(basket_rules2, method = "grouped", control = list(k = 10))
itemFrequencyPlot(transaction2, topN = 20, type="absolute")

plot(basket_rules3, method = "grouped", control = list(k = 10))
itemFrequencyPlot(transaction3, topN = 20, type="absolute")

plot(basket_rules4, method = "grouped", control = list(k = 10))
itemFrequencyPlot(transaction4, topN = 20, type="absolute")

