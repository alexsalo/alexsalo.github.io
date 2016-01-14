---
layout: post
title: Static Methods in Django Models and Neat Model's Content Printout
---
Recently I figured a neat way to print the content of the model for your own testing of for data shipment. Most of the times you want to use Pandas DataFrame, but you need to pass along the fields that you want to select from the DB. More often than not though the fields that you want to display stay same for the model. That's why I started to add one extra field to the model - columns for display. For example, in MonkeyEphys:

{% highlight python linenos %}
class MonkeyEphys(models.Model):   
  # bunch of fields: some useful, some technical
  ...
  monkey = models.ForeignKey(Monkey, related_name='mep_records')
  mep_frequency = models.FloatField("Frequency (hz)")
  mep_tissue_type = models.ForeignKey(TissueType, related_name='ephys_records')
  ...  

  # Tuple: (list of db attributes, list of column names to display)
  columns = (['monkey__mky_id', 'mep_tissue_type__tst_tissue_name',
              'mep_ephys_type', 'mep_frequency'],
             ['mky_id', 'tissue_name', 'ephys_type', 'frequency'])
{% endhighlight %}

Now you can use this tuple in Pandas:
{% highlight python linenos %} 
  df = pd.DataFrame(list(MonkeyEphys.objects.all().\
         values_list(*MonkeyEphys.columns[0])),  # *kwargs - fields to be selected
         columns=MonkeyEphys.columns[1])         # displayable column names
  print df
{% endhighlight %}

Now, it gets better than this. Have you ever dreamed of static methods for the model? Well, your dreams are true - you can delegate repeatable some code specifically to the model, yey! Let's continue with the Ephys example, say we don't want to type the selection code every time - well, just append a static method for it:

{% highlight python linenos %} 
@staticmethod
def content_print():
  print pd.DataFrame(list(MonkeyEphys.objects.all() ...)

# Now this does the job:
MonkeyEphys.content_print()
{% endhighlight %}

Pretty neat, hah? Too bad I was completely ignorant of that before.