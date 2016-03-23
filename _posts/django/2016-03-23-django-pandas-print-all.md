---
layout: post
tags: [django, python]
title: How To Print Everything From Django Query via Pandas?
---
Most often use case when working with the data via Django ORM is simly run some query and print out everything from the output. Doing so directly renders unreadable one-liner:

{% highlight python %}
print MonkeyBEC.objects.filter(monkey_id=15).values_list()
# [(25256, 10138, None, 62691, datetime.datetime(2011, 3, 29, 0, 0), 
# None, None, None, datetime.time(5, 36), None, None, 51.3, 0.28, 
# 0.3, 74.0, None, 0.933333333333333, False), 
# (25259, 10139, None, 62694, datetime.datetime(2011, 3, 29, 0, 0), 
# None, None, None, datetime.time(5, 51), None, None, 22.8, 0.14, 
# 0.2, 0.0, None, 0.7, False), '...(remaining elements truncated)...']
{% endhighlight %}

To make this readable, we can simply pass it to the Pandas engine, wrapping query output into list:

{% highlight python %} 
print pd.DataFrame(list(MonkeyBEC.objects.filter(monkey_id=15).values_list()))
#         0      1     2      3          4     5     6     7         8     9   \
# 0    25256  10138  None  62691 2011-03-29  None  None  None  05:36:00  None   
# 1    25259  10139  None  62694 2011-03-29  None  None  None  05:51:00  None   
# 2    25265  10136  None  62749 2011-04-06  None  None  None  05:47:00  None   
# 3    25271  10135  None  62783 2011-04-11  None  None  None  05:28:00  None   
# 4    25273  10139  None  62785 2011-04-11  None  None  None  05:36:00  None   
# 5    25277  10138  None  62810 2011-04-15  None  None  None  05:47:00  None   
# 6    25283  10141  None  62816 2011-04-15  None  None  None  05:54:00  None  
{% endhighlight %}

Cool! But what about the column names? 1,2,3... is not very informative. But hey, this is python, so we can fix it easily:
{% highlight python %} 
print pd.DataFrame(list(MonkeyBEC.objects.filter(monkey_id=15).values_list()),
	columns=[str(x).split('.')[2] for x in MonkeyBEC._meta.fields])
#      bec_id  monkey   dto    mtd bec_collect_date bec_run_date bec_exper  \
# 0     25256   10138  None  62691       2011-03-29         None      None   
# 1     25259   10139  None  62694       2011-03-29         None      None   
# 2     25265   10136  None  62749       2011-04-06         None      None   
# 3     25271   10135  None  62783       2011-04-11         None      None   
# 4     25273   10139  None  62785       2011-04-11         None      None   
# 5     25277   10138  None  62810       2011-04-15         None      None   
# 6     25283   10141  None  62816       2011-04-15         None      None   
{% endhighlight %}
Much better! Each model has modelName._meta.fields which returns list of fields in the same order as values_list(). Those fields however are in app.model.field format, hence splitting by dot and getting the last item. 

And you can also just put a static method that prints the entire content without filtering:
{% highlight python %} 
@staticmethod
def content_print():
  print pd.DataFrame(list(MonkeyBEC.objects.all().values_list()),
	columns=[str(x).split('.')[2] for x in MonkeyBEC._meta.fields])

# Now this does the job:
MonkeyBEC.content_print()
{% endhighlight %}
