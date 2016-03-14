---
layout: post
tags: [algorithms, python]
title: Quicksort in Python
---

Time complexity: O(n*log(n)) for average case. Worst case O(n^2). Usually better than other n*log(n). 

The idea is really simpe and adheres 'divide and conquer' paradigm:

1. choose 1st element as a pivot 
2. put elems that bigger to 'high' group and qsort it //recursion
3. put elems that smaller in 'low' group and qsort it //recursion
4. base case: return if only 1 elem 

Writing it in python takes only few lines:

{% highlight python linenos %}
def qsort(arr):
    print arr
    if len(arr) < 2:
        return arr
    pivots = [x for x in arr if x == arr[0]]
    lo = qsort([x for x in arr if x < arr[0]])
    hi = qsort([x for x in arr if x > arr[0]])

    return lo + pivots + hi

array = [11, 50, 2, 43, 6, 100, 8, 20, 3, 15]
print qsort(array)
{% endhighlight %}
