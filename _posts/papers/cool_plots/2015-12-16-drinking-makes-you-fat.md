---
layout: post
title: Drinking Makes You Fat!
---
I've been working on [matrr.com](http://matrr.com/) project for the last year. Different labs across the country offer monkeys an alcoholic beverages (4% EtOH mixed with sugar in water) and investigate the consequesnces. We collect the data for the reuse by others, while also aggregating and doing various analysis. 
In particular, while making the weight change plots, I figured that **drinking make you fat!**

Well, there is no surprise - I've noticed that drinkers often fat (if they are not poor) a long time ago among humans. But let's see that effect precisly on Rhesus Macaques:

[![Animal Weight Change][2]][1]

  [1]: {{ site.url }}/images/matrr/10215_weight_change.png
  [2]: {{ site.url }}/images/matrr/10215_weight_change.png (animal weight change)

Notice how weight increases steadily over the alcohol exposure periods (Induction and Open Access). Then something interesting happens: after withdrawal (they take them away from alcohol), animal loses 20% of its body weight during one month! Then, alcohol restored, it gains weight again; cycle repeats with the new withdrawals. 

Lesson to be learned? **Don't drink heavily, but if you do, don't eat too much, at least :)**

*On the separate note, check out how easy it is to work with python\django\matplotlib\pandas - you type and it does it. Here is how to create this plot:*

{% highlight python linenos %}
def monkey_weight_plot(monkey):
    """
    Create mky weight plot
    """
    def weight_plot_makeup(ax):
        """
         Adjusting plot appearance
        """
        # set font size
        matplotlib.rcParams.update({'font.size': 14})

        # get legend: handles (lines) and labels (captions)
        handles, labels = ax.get_legend_handles_labels()

        # add animal's info
        if monkey.mky_drinking_category is None:
            labels = [str(monkey.mky_id) + ' Control']
        else:
            labels = [str(monkey.mky_id) + ' ' + monkey.mky_drinking_category]

        # plug labels back
        ax.legend(handles, labels, loc='upper left')  # reverse to keep order consistent

        # set labels and titles
        ax.set_ylabel('Monkey Weight')
        ax.set_title('Animal Weight Change')

        # make tight layout to avoid space waste
        pyplot.tight_layout()

    def make_event_annotations(ax):
        """
        Annotate the axis with cohort's events
        """
        # retrieve events for cohort from DB
        cevs = CohortEvent.objects.filter(cohort=monkey.cohort)

        # put into data frame
        evts = pd.DataFrame(list(cevs.values_list('event__evt_name', 'cev_date')),
                            columns=['event', 'date'])      # get values
        # filter by regex and negate
        evts_begin = evts[~evts.event.str.contains('.*(Before|Necropsy|Pre|Endocrine|(H2O)|(Ethanol.*End.*))')]

        # plot ablines
        [ax.axvline(x, color='r', linestyle='--') for x in evts_begin.date]

        # get ylim of axis
        ymin, ymax = ax.get_ylim()

        # plot event at date while iteration tuples
        [ax.text(x[1].date, ymin + 0.05, x[1].event,
                 verticalalignment='bottom', horizontalalignment='right',
                 rotation='vertical') for x in evts_begin.iterrows()]

        # adjust left xlim to fit text annotaiton
        xmin, xmax = ax.get_xlim()
        ax.set_xlim(xmin - 20, xmax)

    # retrieve data from DB into ORM's (Django) class objects
    mtds = MonkeyToDrinkingExperiment.objects.filter(monkey=monkey)\
        .filter(mtd_weight__isnull=False).order_by('drinking_experiment__dex_date')

    # if have data (no need to write count() > 0)
    if mtds.count():
        # create pandas dataframe
        df = pd.DataFrame(list(mtds.values_list('drinking_experiment__dex_date', 'mtd_weight')),
                          columns=['Date', 'weight'])

        # get new figure with desired size and DPI
        fig = pyplot.figure(figsize=DEFAULT_FIG_SIZE_ALEX, dpi=DEFAULT_DPI)

        # add subplot to a figure
        ax = fig.add_subplot(111)

        # line plot the weight change via pandas df's method
        df.plot(x='Date', y='weight', ax=ax, color=DRINKING_CATEGORIES_COLORS[monkey.mky_drinking_category])

        # adjust appearance
        weight_plot_makeup(ax)

        # make event annotations
        make_event_annotations(ax)

        return fig, True
    else:
        return False, False
{% endhighlight %}

