---
layout: post
tags: [python, plotting]
title: ANCOVA, Compare Regression Slopes in Python
---
How to compare two regressions in Python? I didn't find a good simple answer - hence this post. Seems like we need to compare regressions by slope, but how to test the significance? ANCOVA is the answer!

Imagine you have a dataset, in which you want to investigate the dependence of one variable of another, in our case - how BEC (Blood Ethanol Concentration) depends on EtOH. Additionally, we have the categorical variable - condition, in our case condition is either 'Within' or 'Over'.  

First step in the analysis is to scatterplot the data and calculate the correlation, for each condition: 

[![Regression (BD)]({{ site.url }}/images/matrr/bec_etoh_corr_regression_BD.png)]({{ site.url }}/images/matrr/bec_etoh_corr_regression_BD.png)

[![Regression (HD)]({{ site.url }}/images/matrr/bec_etoh_corr_regression_HD.png)]({{ site.url }}/images/matrr/bec_etoh_corr_regression_HD.png)

We can clearly see, that while for 'BD' two regression lines differ in slopes a lot, for 'HD' they **look** almost parallel. Now the question is how to make a statistically sound statement? 

Well, there is an ANCOVA (Analysis of Covariance) model. Why and how you can [read intro here.](https://www.csub.edu/~psmith3/Teaching/310-12.pdf)

Now, how to do that in Python? Apperantly, you can use a standard OLS model from statsmodel with just a tweak of a formula (that is there is no big difference in the tool set between ANOVA and ANCOVA). Assume the following Pandas Data Frame:

{% highlight python %}
DC  EtOH  BEC   Condition  
-------------------------
BD  2.60  59.0  True   
HD  2.20  77.0  True   
HD  2.22  60.0  False 
... ...   ...   ...
{% endhighlight %}

Then by doing:
{% highlight python linenos %}
from statsmodels.formula.api import ols
# formula = 'BEC ~ EtOH'               # Simple regression
formula = 'BEC ~ EtOH * C(Condition)'  # ANCOVA formula
lm = ols(formula, dataframe[dataframe.DC == 'HD'])
fit = lm.fit()
print fit().summary()
{% endhighlight %}

We get the p-value of how significant the effect of the Condition is on our regression slopes:

{% highlight python %}
                            OLS Regression Results                            
==============================================================================
Dep. Variable:                    bec   R-squared:                       0.172
Model:                            OLS   Adj. R-squared:                  0.170
Method:                 Least Squares   F-statistic:                     62.67
Date:                Thu, 14 Jan 2016   Prob (F-statistic):           8.32e-37
Time:                        16:31:31   Log-Likelihood:                -4877.4
No. Observations:                 906   AIC:                             9763.
Df Residuals:                     902   BIC:                             9782.
Df Model:                           3                                         
Covariance Type:            nonrobust                                         
==============================================================================
                                    coef    std err          t      P>|t|     
------------------------------------------------------------------------------
Intercept                        16.8906      6.233      2.710      0.007     
C(Condition)[T.True]             37.2833     26.816      1.390      0.165     
EtOH                             26.4234      2.160     12.233      0.000     
EtOH:C(Condition)[T.True]         2.2716      8.933      0.254      0.799     
==============================================================================
Omnibus:                       18.672   Durbin-Watson:                   1.143
Prob(Omnibus):                  0.000   Jarque-Bera (JB):               21.270
Skew:                           0.284   Prob(JB):                     2.41e-05
Kurtosis:                       3.490   Cond. No.                         49.0
==============================================================================  
{% endhighlight %}

We are interested in the line:
{% highlight python %}
                                    coef    std err          t      P>|t|     
------------------------------------------------------------------------------   
EtOH:C(Condition)[T.True]         2.2716      8.933      0.254      0.799 
{% endhighlight %}

Meaning p-value = 0.799, which suggests us not to reject the H0 (initial hypothesis) that two slopes are equal. That means that slopes in case of 'HD' are statistically same. 

No surprise - test for 'BD': 
{% highlight python %}
                                    coef    std err          t      P>|t|
-------------------------------------------------------------------------   
EtOH:C(Condition)[T.True]        42.6065     13.232      3.220      0.001
{% endhighlight %}  

P-value of 0.001 and we happily reject the equal slopes hypothesis. 
