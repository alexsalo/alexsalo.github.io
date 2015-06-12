---
layout: post
title: Binary Search in Java
---

Binary search is extremely easy to explain, but very tricky to write:
{% highlight java linenos %}
public int binary_search(List<Integer> list, int value) {
		int lo = 0;
		int hi = list.size() - 1;
		while (lo != hi){
			//because mid = (hi + lo)/2 might overflow memory
			int mid = lo + (hi - lo) / 2;
			if (value == list.get(mid)) 
				return mid;
			
			if (value > list.get(mid)) 
				lo = mid;
			else 
				hi = mid;
		}
		return -1;
	}
{% endhighlight %}
