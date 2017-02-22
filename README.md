# Part 2: ASSOCIATION RULE MINING

You can access the dataset at this [link](https://wiki.csc.calpoly.edu/datasets/wiki/ExtendedBakery).

## 1. Objectives

**What is the domain?**

The domain of this data sets is about the large set of transactional data from a bakery chain which has a menu of about 40 pastry items and 10 coffee drinks. This bakery chain has a several locations in West Coast of United State which includes California, Oregon, Arizona and Nevada.

**What are the potential benefits to be derived from association rule mining?**

There are many potential benefits can be derived from these association rules. This includes extracting the marketing information that can be used to improve business. For instance, the bakery shop could improve their product placement according to frequent items purchased by the customers. This creates convenience for customers as they can reach their preferred items once they entered the shop or just grab the item without having to look and search for it. Besides that, the frequent items that have higher confidence in the basket can be combined together with lower confidence as a bundle to push the sales of the items that are not popular.

Other than that, we can group items with high correlations for catalog creation. This can attract more customer at the first sight as they can likely find whatever relevant items they were to buy in a short amount of time. Different promotion or discount coupon can also be integrated as part of the catalog for bundle discounts.

Furthermore, recommendation will also be more effective when we have the patterns to do advertising on social platforms like Facebook or Twitter. For customers who have not tried certain items from the bakery shop would have attracted by seeing what other customers have bought together when they visit the shop. Reputation of different items would be improved as they are putting together.

In addition to that, we can determine what items would be affected if the shop discontinued a certain item. By having the patterns of different items as an antecedent and consequent we can know what is important in the store and make sure it is always served in the top quality so that it will not affect the sales. Therefore, the risk of losing customers will be reduced and the prevention will be improved.

## 2. Data Set Description 

**What is in the data?**

For this extended bakery dataset, the source website provides dataset with different number of records which are 1000, 5000, 20000 and 750000. Besides that, for each number of the datasets, the data was recorded in 2 different forms which are the sparse and the full binary form.
</br>
##### example of sparse dataset (1000-out1.csv):

| No. | Item  | Item  | Item  | Item  | Item  | Item  | Item  | Item  |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 1   | 7   | 15  | 44  | 49  |     |     |     |     |
| 2   | 1   | 19  |     |     |     |     |     |     |
| 3   | 1   | 19  |     |     |     |     |     |     |
| 4   | 3   | 4   | 15  | 18  | 35  | 44  |     |     |
<sub>No. column represents the receipt's number.</sub>  
<sub>Item columns represent the item number.</sub>
</br>
##### example of full binary dataset (1000-out2.csv):

```
8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
```
<sub>first digit represents the receipt's number.</sub>  
<sub>following digits represent all the items available in the bakery shop, with 1=purchased, 0=otherwise.</sub>  
</br>
**Pre-processing for the dataset?**

Before the actual data mining process begin, all the empty spaces that is found within the sparse form of the dataset is replaced with null value which is not available. Besides that, all the product number that is found within each record is then replaced with the item name so that the rules generated are easier to describe and understand.

**Decision to ignore?**

There was one of the dataset which the source website provided that contains the information of quantity of the product that customer purchased. That information was not used in the data mining process due to the reason that we are not interested in the quantity of the item they bought and it is not needed to found out the combination of product that customer will buy in. 

## 3. Rule Mining Process

**Parameter settings, algorithm used?**

Apriori alogrithm for association mining is used to find out the relationship and the distinct combination of product that the customer bought during their visit to the bakery store. Furthermore, the confidence and support are set to 0.005 and 0.8.

**Time required?**

Below are the codes to calculate the time required for data set 1000-out1, 5000-out1, 20000-out1, and 75000-out1.
```R
# Start the clock
ptm <- proc.time()
basket_rules <- apriori(transaction, parameter = list(sup = 0.005, conf = 0.8, target="rules"))
inspect(basket_rules)
# Stop the clock
proc.time() - ptm
```

1000-out1.csv:  
```R
user   system   elapsed  
 0.050   0.006   0.055
```

5000-out1.csv:  
```R
user   system   elapsed 
 0.059   0.003   0.104 
```

20000-out1.csv:  
```R
user   system   elapsed 
 0.080   0.007   0.089 
```

75000-out1.csv:  
```R
user   system   elapsed 
 0.205   0.013   0.218 
```

## 4. Resulting Rules

Summary:  
```R
> summary(rules.pruned)

set of 31 rules

rule length distribution (lhs + rhs):sizes
 3  4  5 
23  7  1 

   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   3.00    3.00    3.00    3.29    3.50    5.00 

summary of quality measures:
    support         confidence          lift      
 Min.   :0.0210   Min.   :0.8900   Min.   :10.26  
 1st Qu.:0.0210   1st Qu.:0.9095   1st Qu.:12.45  
 Median :0.0260   Median :0.9230   Median :13.43  
 Mean   :0.0251   Mean   :0.9371   Mean   :13.21  
 3rd Qu.:0.0275   3rd Qu.:0.9740   3rd Qu.:13.68  
 Max.   :0.0410   Max.   :1.0000   Max.   :14.78  

mining info:
        data ntransactions support confidence
 transaction         75000   0.005        0.8

```

Rules:  
```R
>inspect(rules.pruned)

     lhs                                                           rhs                  support confidence lift  
[1]  {Green_Tea,Lemon_Cookie,Lemon_Lemonade,Raspberry_Lemonade} => {Raspberry_Cookie}   0.021   1.000      14.784
[2]  {Apple_Danish,Apple_Tart,Cherry_Soda}                      => {Apple_Croissant}    0.021   0.993      14.755
[3]  {Green_Tea,Lemon_Lemonade,Raspberry_Lemonade}              => {Raspberry_Cookie}   0.021   0.997      14.746
[4]  {Lemon_Cookie,Lemon_Lemonade,Raspberry_Lemonade}           => {Raspberry_Cookie}   0.026   0.997      14.746
[5]  {Green_Tea,Lemon_Cookie,Raspberry_Cookie}                  => {Raspberry_Lemonade} 0.021   0.998      14.732
[6]  {Green_Tea,Lemon_Cookie,Lemon_Lemonade}                    => {Raspberry_Cookie}   0.021   0.994      14.699
[7]  {Green_Tea,Lemon_Cookie,Lemon_Lemonade}                    => {Raspberry_Lemonade} 0.021   0.994      14.676
[8]  {Lemon_Cookie,Lemon_Lemonade}                              => {Raspberry_Cookie}   0.026   0.926      13.693
[9]  {Lemon_Lemonade,Raspberry_Lemonade}                        => {Raspberry_Cookie}   0.026   0.925      13.673
[10] {Lemon_Cookie,Raspberry_Lemonade}                          => {Raspberry_Cookie}   0.026   0.923      13.644
[11] {Apple_Danish,Apple_Tart}                                  => {Apple_Croissant}    0.026   0.916      13.608
[12] {Lemon_Cookie,Lemon_Lemonade}                              => {Raspberry_Lemonade} 0.026   0.921      13.600
[13] {Apple_Tart,Cherry_Soda}                                   => {Apple_Croissant}    0.021   0.912      13.547
[14] {Green_Tea,Raspberry_Lemonade}                             => {Raspberry_Cookie}   0.021   0.910      13.451
[15] {Apple_Tart,Cherry_Soda}                                   => {Apple_Danish}       0.021   0.910      13.441
[16] {Green_Tea,Raspberry_Lemonade}                             => {Lemon_Cookie}       0.021   0.913      13.429
[17] {Apple_Croissant,Cherry_Soda}                              => {Apple_Danish}       0.021   0.909      13.422
[18] {Green_Tea,Lemon_Lemonade}                                 => {Raspberry_Cookie}   0.021   0.906      13.397
[19] {Green_Tea,Lemon_Lemonade}                                 => {Raspberry_Lemonade} 0.021   0.903      13.334
[20] {Green_Tea,Lemon_Lemonade}                                 => {Lemon_Cookie}       0.021   0.906      13.315
[21] {Green_Tea,Lemon_Cookie}                                   => {Raspberry_Cookie}   0.021   0.900      13.307
[22] {Almond_Twist,Coffee_Eclair,Hot_Coffee}                    => {Apple_Pie}          0.028   0.993      12.875
[23] {Vanilla_Frappuccino,Walnut_Cookie}                        => {Chocolate_Tart}     0.027   0.940      12.746
[24] {Coffee_Eclair,Single_Espresso}                            => {Blackberry_Tart}    0.027   0.922      12.156
[25] {Almond_Twist,Coffee_Eclair}                               => {Apple_Pie}          0.034   0.925      11.989
[26] {Almond_Twist,Hot_Coffee}                                  => {Apple_Pie}          0.028   0.907      11.765
[27] {Coffee_Eclair,Hot_Coffee}                                 => {Apple_Pie}          0.028   0.890      11.542
[28] {Coffee_Eclair,Hot_Coffee}                                 => {Almond_Twist}       0.028   0.891      11.541
[29] {Casino_Cake,Chocolate_Coffee}                             => {Chocolate_Cake}     0.033   0.947      11.342
[30] {Apricot_Croissant,Hot_Coffee}                             => {Blueberry_Tart}     0.033   0.928      11.188
[31] {Apricot_Danish,Opera_Cake}                                => {Cherry_Tart}        0.041   0.955      10.255
```

In data mining, association rules mining is one of the popular process which is used to discover interesting relationship and pattern in given dataset. By using the Apriori algorithm, we are able to find out the three factors which is support, confidence, and lift from the given dataset. The support defined as the proportion of transactions in the data set which contain the item set. The confidence of a rule is defined as an estimate of the probability of finding the RHS of the rule in the transactions under the condition that these transactions also contain the LHS. The lift of rule is defined as the deviation of the support of the whole rule from the support expected under independence given the supports of the LHS and the RHS. The result of the mining algorithm is a set of 31 rules, we would like to round up the decimal place to 3 digits since it is able to save some time on showing the result. Furthermore, we are sorting the rules by lift as we know that the greater the lift values the stronger the association. The rule that have greater support, confidence and lift values show the strongest association. The final step is to remove the redundant rules so as to reduce the size of rule set to improve the quality and usefulness without any loss. From the rules we see that persons who are buying green tea, lemon cookie, lemon lemonade, and raspberry will tend to purchase raspberry cookie while person who are buying apricot danish and opera cake will have the less probability to purchase cherry tart. 

I would suggest the large dataset to the client as large dataset will show the more accurate result. The client able to find the trend from the result and apply to the business marketing. An example of pattern discovery is the analysis of retail sales data to identify seemingly unrelated products that are often purchased together. 

## 5. Recommendations

Based on the association rules that generated by using apriori algorithm, we can discovered certain patterns and insights from the dataset, and used that information to get some business strategy, in order to increases the sales performance of the bakery chain store. From the rules that had discovered, we can givens three suggestion for the bakery chain store.

The first suggestion is they can based on the association rules to improve the placement for difference foods and beverages. For example, from the association rules that generated, we can see that LHS of the rule that contains green tea item, the RHS sure will be lemon product such as lemon cookie, lemon lemonade and raspberry lemonade. Mean that, customer who buy green tea, will be has higher confidence also buying lemon product. For this reason, staff can replace the lemon product as near as possible to green tea item. This will make the customer more convenience when they are trying to buying these two items.

For the second suggestion, they can also make some promotion or discount based on certain items that customer buy. For example, the association rules shows that customer who buy almond twist, hot coffee and coffee éclair which also has higher confidence buying apple pie together. Therefore, we can based on this information to offer some interesting promotion or discount such as each of these items can bundle with apple pie sells at a special promotions price or buying any two of these items will receive a free apple pie. By doing this way, it can improve the sales of these items and will return a good profit.

The last suggestion is sales man can based on the association rules to recommend items to customers before they are trying to made payment. When a customer is trying to purchase an item, before making the payment, sales man can recommend others items that is higher correlation to the items that customer purchase. Given an example, a customer is purchase chocolate tart, from the association rules shows that customer who bought chocolate tart which had high interest purchase with vanilla Frappuccino and walnut cookie together. Therefore, sales man can recommend these 2 items to customer before making their payment. This will increase customer interest to buy these recommend items.
