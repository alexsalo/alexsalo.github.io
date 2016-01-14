---
layout: post
title: ANCOVA, Comparing Regression Slopes
---
Imagine you have a dataset, in which you want to investigate the dependence of one variable of another, in our case - how BEC (Blood Ethanol Concentration) depends on EtOH. Additionally, we have the categorical variable - condition, in our case condition is either 'Within' or 'Over'.  

First step in the analysis is to scatterplot the data and calculate the correlation, for each condition: 

[![Regression (BD)]({{ site.url }}/images/matrr/bec_etoh_corr_regression_BD.png)]({{ site.url }}/images/matrr/bec_etoh_corr_regression_BD.png)

[![Regression (HD)]({{ site.url }}/images/matrr/bec_etoh_corr_regression_HD.png)]({{ site.url }}/images/matrr/bec_etoh_corr_regression_HD.png)

{% highlight python linenos %}
def monkey_weight_plot(monkey):

{% endhighlight %}

