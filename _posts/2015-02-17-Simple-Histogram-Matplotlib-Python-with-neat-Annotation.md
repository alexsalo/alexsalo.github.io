---
layout: post
title: Simple Histogram in Python Matplotlib with neat Annotation
---
So matplotlib is really neat and powerful yet elegant and easy to use. 
Here we have this simple hist with all you need:

{% highlight python linenos %}
import matplotlib
import matplotlib.pyplot as plt
matplotlib.use('TkAgg')
import numpy as np
import pylab

# read file
with open('.../nums.txt', 'r') as f:
    data = f.readlines()
    nums = []
    for line in data:
        nums.append(int(line))

#find central tendency measures
mu = np.mean(nums)
median = np.median(nums)
sigma = np.std(nums)

#plot
fig, ax = plt.subplots(1)
ax.hist(nums, bins = 30, color = 'c')
ax.axvline(np.mean(nums), color='b', linestyle='dashed', linewidth=2)
props = dict(boxstyle='round', facecolor='wheat', alpha=0.5)
textstr = '$\mu=%.2f$\n$\mathrm{median}=%.2f$\n$\sigma=%.2f$'%(mu, median, sigma)
ax.text(0.65, 0.95, textstr, transform=ax.transAxes, fontsize=14,
        verticalalignment='top', bbox=props)
pylab.show()
{% endhighlight %}

