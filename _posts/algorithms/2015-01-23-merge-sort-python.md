---
layout: post
tags: [algorithms, python]
title: Merge Sort in Python
---

Time complexity: O(n*log(n)) for any case. 

The idea is really simpe and adheres 'divide and conquer' paradigm:

1. divide on halves until get list with length equal 1 //just a recursive calls
2. merge recursively // takes log(n) merges with n comparison in each

Writing it in python takes only few lines:

{% highlight python linenos %}
def merge(l, r):
    result = []
    i = j = 0
    while i < len(l) and j < len(r):
        if l[i] < r[j]:
            result.append(l[i])
            i += 1
        else:
            result.append(r[j])
            j += 1
    result += l[i:]
    result += r[j:]
    return result

def msort(a):
    if len(a) == 1:
        return a
    mid = len(a) / 2
    return merge(msort(a[:mid]), msort(a[mid:]))


array = [101, 50, 2, 43, 6, 100, 8, 20, 3, 15]
print array
print msort(array)
{% endhighlight %}
