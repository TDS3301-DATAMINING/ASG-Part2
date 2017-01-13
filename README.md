# Part 2: ASSOCIATION RULE MINING

You can access the dataset at this [link](https://wiki.csc.calpoly.edu/datasets/wiki/ExtendedBakery).

## 1. Objectives

The domain of this data sets is about the large set of transactional data from a bakery chain which has a menu of about 40 pastry items and 10 coffee drinks. This bakery chain has a several locations in West Coast of United State which includes California, Oregon, Arizona and Nevada. In the dataset, there is a list of shopping baskets which contain what have been purchased by the customers. Hence, we can make use of this information to find the patterns that occur frequently by applying association rule mining using Apriori algorithm. 

There are many potential benefits can be derived from these association rules. This includes extracting the marketing information that can be used to improve business. For instance, the bakery shop would improve their product placement according to frequent items purchased by the customers. This creates convenience for customers as they can reach their preferred items once they entered the shop or just grab the item without having to look and search for it. Besides that, the frequent items that have higher confidence in the basket can be combined together with lower confidence as a bundle to push the sales of the items that are not popular. 

Other than that, we can group items with high correlations for catalog creation. This can attract more customer at the first sight as they can likely find whatever relevant items they were to buy in a short amount of time. Different promotion or discount coupon can also be integrated as part of the catalog for bundle discounts.  

Furthermore, recommendation will also be more effective when we have the patterns to do advertising on social platforms like Facebook or Twitter. For customers who have not tried certain items from the bakery shop could be attracted by seeing what other customers have bought together when they visit the shop. Reputation of different items would be improved as they are putting together. 

In addition to that, we can determine what items would be affected if the shop discontinued a certain item. By having the patterns of different items as an antecedent and consequent we can know what is important in the store and make sure it is always served in the top quality so that it will not affect the sales. Therefore, the risk of losing customers will be reduced and the prevention will be improved. 

## 2. Data Set Description 
For this extended bakery dataset, the source website provides dataset with different number of records which are 1000, 5000, 20000 and 750000. 

Besides that, for each number of the dataset, the data was recorded in 2 different forms which are the sparse and the full binary form. 

Example of sparse dataset (1000-out1.csv):
```
7, 4, 12, 31, 36, 44, 48
```

First digit is the row number then followed by the product number.


Example of full binary dataset (1000-out2.csv):
```
8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
```

For the binary form, the number of column represent each product, while 0 and 1 gives you an idea of what product is in the certain record.
 
 
* **Preprocessing for the dataset**

Before the actual data mining process begin, all the empty spaces that is found within the sparse form of the dataset is replaced with null value which is not available. Besides that, all the product number that is found within each record is then replaced with the item name so that the rules generated are easier to describe and understand.


* **Decision to ignore**

There was one of the dataset which the source website provided that contains the information of quantity of the product that customer purchased. That information was not used in the data mining process due to the reason that we are not interested in the quantity of the item they bought and it is not needed to found out the combination of product that customer will buy in. 

## 3. Parameter Settings

* **Algorithm used**

Apriori alogrithm for association mining is used to find out the relationship and the distinct combination of product that the customer bought during their visit to the bakery store. Furthermore, the confidence and support are set to 0.005 and 0.8.

## 4. Resulting Rules

In data mining, association rules mining is one of the popular process which is used to discover interesting relationship and pattern in given dataset. By using the Apriori algorithm, we are able to find out the three factors which is support, confidence, and lift from the given dataset. The support defined as the proportion of transactions in the data set which contain the item set. The confidence of a rule is defined as an estimate of the probability of finding the RHS of the rule in the transactions under the condition that these transactions also contain the LHS. The lift of rule is defined as the deviation of the support of the whole rule from the support expected under independence given the supports of the LHS and the RHS. The result of the mining algorithm is a set of 31 rules, we would like to round up the decimal place to 3 digits since it is able to save some time on showing the result. Furthermore, we are sorting the rules by lift as we know that the greater the lift values the stronger the association. The rule that have greater support, confidence and lift values show the strongest association. The final step is to remove the redundant rules so as to reduce the size of rule set to improve the quality and usefulness without any loss. From the rules we see that persons who are buying green tea, lemon cookie, lemon lemonade, and raspberry will tend to purchase raspberry cookie while person who are buying apricot danish and opera cake will have the less probability to purchase cherry tart. 

I would suggest the large dataset to the client as large dataset will show the more accurate result. The client able to find the trend from the result and apply to the business marketing. An example of pattern discovery is the analysis of retail sales data to identify seemingly unrelated products that are often purchased together. 


## 5. Recommendations

Based on the association rules that generated by using apriori algorithm, we can discovered certain patterns and insights from the dataset, and used that information to get some business strategy, in order to increases the sales performance of the bakery chain store. From the rules that had discovered, we can givens three suggestion for the bakery chain store.

The first suggestion is they can based on the association rules to improve the placement for difference foods and beverages. For example, from the association rules that generated, we can see that LHS of the rule that contains green tea item, the RHS sure will be lemon product such as lemon cookie, lemon lemonade and raspberry lemonade. Mean that, customer who buy green tea, will be has higher confidence also buying lemon product. For this reason, staff can replace the lemon product as near as possible to green tea item. This will make the customer more convenience when they are trying to buying these two items.

For the second suggestion, they can also make some promotion or discount based on certain items that customer buy. For example, the association rules shows that customer who buy almond twist, hot coffee and coffee éclair which also has higher confidence buying apple pie together. Therefore, we can based on this information to offer some interesting promotion or discount such as each of these items can bundle with apple pie sells at a special promotions price or buying any two of these items will receive a free apple pie. By doing this way, it can improve the sales of these items and will return a good profit.

The last suggestion is sales man can based on the association rules to recommend items to customers before they are trying to made payment. When a customer is trying to purchase an item, before making the payment, sales man can recommend others items that is higher correlation to the items that customer purchase. Given an example, a customer is purchase chocolate tart, from the association rules shows that customer who bought chocolate tart which had high interest purchase with vanilla Frappuccino and walnut cookie together. Therefore, sales man can recommend these 2 items to customer before making their payment. This will increase customer interest to buy these recommend items.
