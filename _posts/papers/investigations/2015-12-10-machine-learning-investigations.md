---
layout: post
title: Investigations on Machine Learning
---
During the Spring 2015 I've taken the Machine Learning class which was a blast: by applying rather simple math apparatus in a fancy fashion we can *learn* on the data we have. 

### What is Machine Learning anyways? 
There is a slim edge between stats, data mining and ML - they all interconnected, sure, but the key difference is the following:

- Stats: we try to describe the data and estimate significance based on the samples we have; most of the times we want sample to be drawn out of "normal" population (meaning, in stats, all the possible data points).

- Data Mining: we try to *mine* some associations and connections between the items in the dataset; no assumptions on the data.

- Machine Learning: given the dataset (sample mapping) of X->Y, we want to *learn to mimic" the algorithm that converts the X into Y, so we can use it later on new X'. In general, there are no assumptions on the distribution (although some methods do assume things), and what's cool, that we don't really care what the algorithm looks like, as long as we can successfully mimic it (what a bummer for all the stats people who are like "wat? I want to know the true process!" right now..)

Anyways, during the class we had several home assignments to investigate different aspects of various methods which I present below, along with the short summary of what is learned.   

### Investigations

#### Linear and Logistic regression: Gradient Descent and Newton's method
<a href="/papers/investigations/machine-learning/mle_wlr_gradient-descent_newthon.pdf">
<img border="0" alt="W3Schools" src="/papers/investigations/machine-learning/preview/mle_wlr_gradient-descent_newthon.png" width="260"  align="right">
</a>
The most basic ML's tool is the Linear Regression: we try to fit the line into the data points (i.e. price of the apartment based on size and distance to public transport; then we can predict how much would the new apt cost with given size and distance). 

Then we can do a "sliding window" for achieving locally-weighted linear regression - we can make the line flexible. Playing with the weights we trade off bias and variance. 

Instead of "float" regression, we can do "logistic" (dichotomy) regression, i.e. answering "yes" or "no" for a given data. 

To solve this we use the one of the following:

Linear Regression & Logistic Regression:

- Gradient Descent - fast and efficient, has closed form solution; could get stuck in local optima; could be randomized.
- Newthon's method - even faster - finishes in just a few iteration; could have issues on some data since needs Hessian matrix (second partial derivative). 



#### K-Means Clustering
<a href="/papers/investigations/machine-learning/kmeans_generalized-em.pdf">
<img border="0" alt="W3Schools" src="/papers/investigations/machine-learning/preview/kmeans_generalized-em.png" width="260" align="right">
</a>
K-means is a work horse in data analysis - it is so simple, fast and efficient, that most of the times we end up using it either directly, or within more complex procedure. 

The paper investigates how to choose optimal **k** (try several, check the error, take the **k** with min error) and the importance of the initialization - with bad luck K-means can get stuck in local optima; but we are computer scientists, we don't like to be dependent on luck - run K-means many many times and take the best results - the chances of getting stuck in local optima decrease polynomially. 

K-means is a particular case of Expectation-Minimization algorithms family. We could use median or whatever else to achieve the result - paper shows the generalized approach. 


#### GDA, Naive Bayes and Ridge Regression
<a href="/papers/investigations/machine-learning/gda_ridge-regression_oprimal-margin_naive-bayes_svm.pdf">
<img border="0" alt="W3Schools" src="/papers/investigations/machine-learning/preview/gda_ridge-regression_oprimal-margin_naive-bayes_svm.png" width="260" align="right">
</a>
In Gradient Descent we have some problems with the collinearity. Ridge regression technique allows to penalize high theta (hypothesis of algorithm that we are trying to learn) coefficients, that appeared due to the collinearity in the data, while with moderate values of parameter λ it would not significantly decrease predictive power (in other words would not increase cost function). By doing that we avoid blown-up theta values that potentially lead to calculus errors.

Paper also compares the Naive Bayes vs SVM performance on spam filter example, how to do La-Place smoothing to avoid missing data errors, and also shows how the two-class Gaussian Discriminant Analysis, with common covariance Σ, is exactly a logistic sigmoid function.


#### Mistake Bounds and Uniform Convergence
<a href="/papers/investigations/machine-learning/mistake-bounds_uniform-convergence_soft-margins-svm_vc-dimensions.pdf">
<img border="0" alt="W3Schools" src="/papers/investigations/machine-learning/preview/mistake-bounds_uniform-convergence_soft-margins-svm_vc-dimensions.png" width="260" align="right">
</a>
The cool thing is - we can put a bound on how big our mistakes could be. This paper goes rather deep in how by making more hypothesis we reduce the chance of the mistakes. Also discuses the usage of L-2 soft margins for SVM.