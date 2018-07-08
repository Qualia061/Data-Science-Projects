<<<<<<< HEAD:Classification of handwritten digits/README.md
# Classfying Handwritten Digits
## Description

The U.S. Postal Service processes an average of 21.1 million pieces of mail per hour. Outbound mail must be sorted according to the zip code of its destination. In the past, postal workers sorted mail by hand, which was tedious and expensive. Over the last 40 years, USPS has switched to automated mail sorting. The sorting machines use statistical classifiers to identify the individual digits in the zip code on each piece of mail.

The k-nearest neighbors algorithm classifies an observation based on the class labels of the k nearest observations in the training set (the ”neighbors”). The effectiveness of k-nn depends on the choice of k and on how distance is measured between observations. Distance can be measured with real-world Euclidean distance or with more exotic metrics such as Manhattan distance and Minkowski distance1.

Almost all packages that can be found online are only capable of measuring the distance with Euclidean distance. Therefore, I would like to write my own k-nearest neighbors algorithm that can apply more exotic metrics such as Manhattan distance and Minkowski distance, and implement it for classifying handwritten digits in zip codes. Zip codes only contain the numbers 0 through 9. 

## Data

The data set is split into a training set and a test set. Both have the same format. In the files, each line is one observation (one digit). There are 257 entries on each line, separated by spaces. The first entry is the class label for the digit (0–9) and the remaining 256 entries are the pixel values in the 16x16 grayscale image of the digit. The pixel values are standardized to the interval [-1,1]. There are 7291 observations in the training file and 2007 observations in the test file.

## Analysis

Display graphically what each digit (0 through 9) looks like on average:

![main](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/main.png)

![var](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/var.png)

By calculating the variations for the 256 entries for all 0 to 9 digits, we find the largest variation
is at V231 which equals to 0.8198434, and the above result shows some pixels with lowest and
highest variations. In statistics, a high variation shows that the data is widely spread from means,
so it biased from the average and cannot represent the classification correctly, so they are less
useful for classification. Therefore, pixel v231, v122, v214, v220 and v205 are the less useful
ones for classification since it has the largest variation. And v2, v242, v257, v17 and v18. The
results are very reasonable because v2, v17 and v18 are on the margins of the 256 entries, so the
pixels are clear at these entries since people will hardly to touch this position while writing the
digits. On the other hand, for v121, v122 and v205, these kinds of entries are in the middle or
middle-bottom position of the 256 entries, so it seems that most of the digits will go over those
positions while writing, so they will definitely have higher variation. Since the high validation
brings a bias from average, they are less representative and less useful for classification.

By editing the code and counting time for each different runthrough, we find that the following strategies can speedup code efficiency:

(a) Before taking data into loop for calculation, we can speedup the performance of R by
initializing the data structures and output variable to match the data type and size.

(b) Moving statements that checks the data conditions outside the loop, like the if statements
significantly improve the code efficiency.

(c) Try to use if - else() whenever possible, since we find that the if - else() performs much faster
than other loops and the speed increase phenomenally.

(d) Using apply() function to compute the same logic is faster than using the vectorised for-loop.
The results is faster in order of magnitudes but slower than if-else() and the version where
condition checking was done outside the loop. (for>apply()>ifelse()outside the loop)

(e) Removing variables and useless memory as early as possible, especially before lengthy loops,
helps increase the efficiency.


![cv](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/cv.png)

![cvg](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/cvg.png)

By displaying the 10-folds cv errors rates, we find that k=1 has the smallest error rates which
equals to 0.02921472, and the top 3 smallest error rates are 1(0.02921472)<3(0.03085818)<4
(0.03360468). The smaller the error rate, the better combination of k and distance metrics. Cross
Validation is a way of measuring predictive performance of a statistical model. For this method,
since we don’t have a second dataset to compare, cross validation only mimics the process using
the data we have (here we have the train dataset). Thus, small error rate for combination of k
and distance metrics gives us a better result of prediction . With fold = 10, we do not need an
additional value of k, since from k=1 to 15, we already got the relatively small error rate. Also,
while looking at the plot, the error rates show an increasing trend , which means that an
additional value of k may lead to a higher error rate. Thus, it is not necessary to consider the
additional value of k for this time. The euclidean method returns for smaller error rate
values.

![mis](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/mis.png)

From the above results, we find that digits 2, 4, 5 and 8 have the highest misclassifications
during cross validation. Digit 2 is easily to be mixed with 7 and 0; digit 4 often mixes with 9 and
1; digit 5 mixes with 0, 3 and 6; while digit 8 is usually mixed with 3 and 5. This result matches
with the grayscale images, because from the images we also find that digits like 2, 4 and 5 are
obscure while comparing to digits 0, 1 and 7 that have less misclassifications. The result makes
sense in reality. When people writing digits 2, 4, 5 and 8, they usually have different preference
of writing them, for example: they may write digits with most misclassifications as follow:

![num](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/num.png)

That leads the digits become various and causes misclassifications during the cross-validation.

![se](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/se.png)

![see](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/see.png)

From the above graph, there’s an increase trend of error rates accompany with small fluctuation
along curves in the graph using both Euclidean and Manhattan methods in our metric spaces. By
comparing the error rates calculated with same methods for the 10-fold CV error rates, 1,3 and 4
has relatively lower error rates in both calculation. Surprisingly, we also find that the test error
rate is larger than the cross-validation error rates. This result actually makes sense. We apply test
error estimation on the test data and cross-validation estimation on the actual dataset (train).
Since the train test is the actual dataset and the test dataset is used to estimate the error rate of the
trained classifier, the test error rate might be close to the actual data error estimation. Moreover ,
cross-validation estimate error inside train dataset itself but the test error estimation use the train
dataset to predict the test dataset. The error rate might be larger for two dataset comparison than
error compared inside one dataset. By looking up the reason for this online, we learned that
d oing k-fold cross validation efficiently in R requires a vague understanding of data structures,
but data structures are generally much more complex and requires deeper understandings. It's 
like people using the Internet for the first time. It's really not hard, it just takes an extra half hour
to figure out. The “brand new” makes it confusing.
 
=======
# Classification of Handwritten Digits
## Description

The U.S. Postal Service processes an average of 21.1 million pieces of mail per hour. Outbound mail must be sorted according to the zip code of its destination. In the past, postal workers sorted mail by hand, which was tedious and expensive. Over the last 40 years, USPS has switched to automated mail sorting. The sorting machines use statistical classifiers to identify the individual digits in the zip code on each piece of mail.

The k-nearest neighbors algorithm classifies an observation based on the class labels of the k nearest observations in the training set (the ”neighbors”). The effectiveness of k-nn depends on the choice of k and on how distance is measured between observations. Distance can be measured with real-world Euclidean distance or with more exotic metrics such as Manhattan distance and Minkowski distance1.

Almost all packages that can be found online are only capable of measuring the distance with Euclidean distance. Therefore, I would like to write my own k-nearest neighbors algorithm that can apply more exotic metrics such as Manhattan distance and Minkowski distance, and implement it for classifying handwritten digits in zip codes. Zip codes only contain the numbers 0 through 9. 

## Data

The data set is split into a training set and a test set. Both have the same format. In the files, each line is one observation (one digit). There are 257 entries on each line, separated by spaces. The first entry is the class label for the digit (0–9) and the remaining 256 entries are the pixel values in the 16x16 grayscale image of the digit. The pixel values are standardized to the interval [-1,1]. There are 7291 observations in the training file and 2007 observations in the test file.

## Analysis

Display graphically what each digit (0 through 9) looks like on average:

![main](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/main.png)

![var](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/var.png)

By calculating the variations for the 256 entries for all 0 to 9 digits, we find the largest variation
is at V231 which equals to 0.8198434, and the above result shows some pixels with lowest and
highest variations. In statistics, a high variation shows that the data is widely spread from means,
so it biased from the average and cannot represent the classification correctly, so they are less
useful for classification. Therefore, pixel v231, v122, v214, v220 and v205 are the less useful
ones for classification since it has the largest variation. And v2, v242, v257, v17 and v18. The
results are very reasonable because v2, v17 and v18 are on the margins of the 256 entries, so the
pixels are clear at these entries since people will hardly to touch this position while writing the
digits. On the other hand, for v121, v122 and v205, these kinds of entries are in the middle or
middle-bottom position of the 256 entries, so it seems that most of the digits will go over those
positions while writing, so they will definitely have higher variation. Since the high validation
brings a bias from average, they are less representative and less useful for classification.

By editing the code and counting time for each different runthrough, we find that the following strategies can speedup code efficiency:

(a) Before taking data into loop for calculation, we can speedup the performance of R by
initializing the data structures and output variable to match the data type and size.

(b) Moving statements that checks the data conditions outside the loop, like the if statements
significantly improve the code efficiency.

(c) Try to use if - else() whenever possible, since we find that the if - else() performs much faster
than other loops and the speed increase phenomenally.

(d) Using apply() function to compute the same logic is faster than using the vectorised for-loop.
The results is faster in order of magnitudes but slower than if-else() and the version where
condition checking was done outside the loop. (for>apply()>ifelse()outside the loop)

(e) Removing variables and useless memory as early as possible, especially before lengthy loops,
helps increase the efficiency.


![cv](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/cv.png)

![cvg](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/cvg.png)

By displaying the 10-folds cv errors rates, we find that k=1 has the smallest error rates which
equals to 0.02921472, and the top 3 smallest error rates are 1(0.02921472)<3(0.03085818)<4
(0.03360468). The smaller the error rate, the better combination of k and distance metrics. Cross
Validation is a way of measuring predictive performance of a statistical model. For this method,
since we don’t have a second dataset to compare, cross validation only mimics the process using
the data we have (here we have the train dataset). Thus, small error rate for combination of k
and distance metrics gives us a better result of prediction . With fold = 10, we do not need an
additional value of k, since from k=1 to 15, we already got the relatively small error rate. Also,
while looking at the plot, the error rates show an increasing trend , which means that an
additional value of k may lead to a higher error rate. Thus, it is not necessary to consider the
additional value of k for this time. The euclidean method returns for smaller error rate
values.

![mis](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/mis.png)

From the above results, we find that digits 2, 4, 5 and 8 have the highest misclassifications
during cross validation. Digit 2 is easily to be mixed with 7 and 0; digit 4 often mixes with 9 and
1; digit 5 mixes with 0, 3 and 6; while digit 8 is usually mixed with 3 and 5. This result matches
with the grayscale images, because from the images we also find that digits like 2, 4 and 5 are
obscure while comparing to digits 0, 1 and 7 that have less misclassifications. The result makes
sense in reality. When people writing digits 2, 4, 5 and 8, they usually have different preference
of writing them, for example: they may write digits with most misclassifications as follow:

![num](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/num.png)

That leads the digits become various and causes misclassifications during the cross-validation.

![se](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/se.png)

![see](https://github.com/Qualia061/Data-Science-Projects/blob/master/Classifying%20handwritten%20digits/pics/see.png)

From the above graph, there’s an increase trend of error rates accompany with small fluctuation
along curves in the graph using both Euclidean and Manhattan methods in our metric spaces. By
comparing the error rates calculated with same methods for the 10-fold CV error rates, 1,3 and 4
has relatively lower error rates in both calculation. Surprisingly, we also find that the test error
rate is larger than the cross-validation error rates. This result actually makes sense. We apply test
error estimation on the test data and cross-validation estimation on the actual dataset (train).
Since the train test is the actual dataset and the test dataset is used to estimate the error rate of the
trained classifier, the test error rate might be close to the actual data error estimation. Moreover ,
cross-validation estimate error inside train dataset itself but the test error estimation use the train
dataset to predict the test dataset. The error rate might be larger for two dataset comparison than
error compared inside one dataset. By looking up the reason for this online, we learned that
d oing k-fold cross validation efficiently in R requires a vague understanding of data structures,
but data structures are generally much more complex and requires deeper understandings. It's 
like people using the Internet for the first time. It's really not hard, it just takes an extra half hour
to figure out. The “brand new” makes it confusing.
 
>>>>>>> ba5c531b79d6f3648367ad0b6922f754fbf8d54c:Classifying handwritten digits/README.md
