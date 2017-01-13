# Set directory
setwd("/Users/yongching/Desktop")

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
df$V1 <- NULL
for(i in 1  :ncol(df)){
  df[,i] <- product_names[df[,i] + 1]
}
write.csv(df, "basket.csv")

# Read data for 1000 records
transaction = read.transactions(file="basket.csv", rm.duplicates=F, format = "basket", sep = ",", skip = 1, cols=1)
inspect(transaction)

# Start the clock!
ptm <- proc.time()
basket_rules <- apriori(transaction, parameter = list(sup = 0.005, conf = 0.8, target="rules"))
inspect(basket_rules)
# Stop the clock
proc.time() - ptm

# Round up to 3 digits
quality(basket_rules)<-round(quality(basket_rules),digits=3)
inspect(basket_rules)

# Sort by lift (to get the more interesting rules on top)
basket_rules.sorted <- sort(basket_rules, by="lift")
inspect(basket_rules.sorted)

# Step to remove redundant rules
subset.matrix <- is.subset(basket_rules.sorted, basket_rules.sorted)
View(subset.matrix)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- basket_rules.sorted[!redundant]
inspect(rules.pruned)

# Plot graph
library(arulesViz)
plot(basket_rules, method = "grouped", control = list(k = 10))
itemFrequencyPlot(transaction, topN = 20, type="absolute")
