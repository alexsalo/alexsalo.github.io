---
layout: post
tags: [python, plotting]
title: Pretty Boxplots in Matplotlib, Pandas and Seaborn
---
Python's Matplotlib offers great flexibility of plotting. Pandas adds convenience of working with data and plotting it. There is also a [Seaborn](https://stanford.edu/~mwaskom/software/seaborn/) that makes the output plots look pretty. Let's see an example.

#### Basic Pandas Boxplot

I have a Pandas dataframe containing rows of data points describing monkey's drinking. Each row has a few quantitative attributes of interest and experiment-specific attributes (factors), such as 'Sex' (Gender) and 'Period' (arbitrary stage of the experiment). Our goal is to see, whether the quantitative attributes are dependent on those factors.

In particular, it is of interest, for each quantitative attribute, to see the boxplot for each combination (Sex, Period). To do just that is very simple with pandas:

{% highlight python %}
df.boxplot(column=attribute, by=['Sex', 'Period'])
{% endhighlight %}

[![]({{ site.url }}/images/matrr/bad_boxplot_double_groupby_sex_period.png)]({{ site.url }}/images/matrr/bad_boxplot_double_groupby_sex_period.png)

And if, instead, we want to see M and F close together, by Period, then the change is tiny:
{% highlight python%}
df.boxplot(column=attribute, by=['Period', 'Sex'])
{% endhighlight %}

[![]({{ site.url }}/images/matrr/bad_boxplot_double_groupby_period_sex.png)]({{ site.url }}/images/matrr/bad_boxplot_double_groupby_period_sex.png)

#### Dealing With Two Factors
OK, well - that's quite ugly: though works, it's very hard to read the plot - viewer have to pay a close attention to the labels. How can we do better? First thing - is split factors somehow. Luckily, Pandas offers an easy way to do just that - we first groupby by one factor, and the boxplot with 'by' by another factor:
{% highlight python%}
df.groupby('Sex').boxplot(column=attribute, by='Period')
{% endhighlight %}
[![]({{ site.url }}/images/matrr/boxplot_combined_drink_to_bout_ratio_LD_BD.png)]({{ site.url }}/images/matrr/boxplot_combined_drink_to_bout_ratio_LD_BD.png)

That's something - definitely looks better. The problem arises for the other grouping, however:
{% highlight python%}
df.groupby('Period').boxplot(column=attribute, by='Sex')
{% endhighlight %}
[![]({{ site.url }}/images/matrr/bad_boxplot_groupby.png)]({{ site.url }}/images/matrr/bad_boxplot_groupby.png)
#### Factorplot in Seaborn
Luckily, we can both make the plots look better and cope with bad subplots arrangement by using the Seaborn library. It doesn't allow for multiple groupby in it's boxplot implementation, however it offers a special ***factorplot*** which does exactly what we want:

{% highlight python%}
import seaborn as sns
sns.factorplot(kind='box',        # Boxplot
               y=attribute,       # Y-axis - values for boxplot
               x='Period',        # X-axis - first factor
               hue='Sex',         # Second factor denoted by color
               data=df_dc,        # Dataframe 
               size=8,            # Figure size (x100px)      
               aspect=1.5,        # Width = size * aspect 
               legend_out=False)  # Make legend inside the plot
{% endhighlight %}

[![]({{ site.url }}/images/matrr/acomb_sex_factor_drink_to_bout_ratio_LD_BD.png)]({{ site.url }}/images/matrr/acomb_sex_factor_drink_to_bout_ratio_LD_BD.png)

And surely that works for the alternative arrangement of the factors:
{% highlight python %}
sns.factorplot(kind='box', y=attribute, x='Sex', hue='Period',
               data=df_dc, size=8, aspect=1.5, legend_out=False) 
{% endhighlight %}

[![]({{ site.url }}/images/matrr/acomb_period_factor_drink_to_bout_ratio_LD_BD.png)]({{ site.url }}/images/matrr/acomb_period_factor_drink_to_bout_ratio_LD_BD.png)

With that, I hope all people, who produce plots, would care about their viewers and make a nice readable plots and will never ever ever create a piechart...