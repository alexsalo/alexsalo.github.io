---
layout: post
title: Visualizations in Python via Pandas and Matplotlib
---
I've grown to be quite a fan of Python tools for plotting - namely, Matplolib library, and other packages that uses it, i.e. Pandas. Community is also great, all the questions has long been answered on StackOverflow. 

In this post I just want to share and preserve those useful methods and approaches that I came up with while working on my bio data analysis. Below is the result plot, which contains ALOT of raw and aggregated information, and how it is done with extensive comments:

[![Regression (BD)]({{ site.url }}/images/matrr/22hr_bec_more2stdev_12combinedpanels.png)]({{ site.url }}/images/matrr/22hr_bec_more2stdev_12combinedpanels.png)

{% highlight python linenos %}
def plot_panels(df_all, df_group_1, df_group_2,
                label1, label2, font_sz=12):
    # Create figure and axes
    fig, axs = plt.subplots(nrows=4, ncols=3, figsize=(20, 10),
                            facecolor='w', edgecolor='k')
    # Makes axes a flat list
    axs = axs.ravel()

    # We would need a secondary Y-axis
    axs_hist = [ax.twiny() for ax in axs]

    # Const some plot props
    xlim = (0, 8)
    ylim = (-10, 400)
    alpha = 0.3

    # Iterate through drinking categories (DC) - rows in the plot
    # Enumerate allows to have index i
    for i, dc in enumerate(['LD', 'BD', 'HD', 'VHD']):
        # Filter data frames by DC
        df_dc_1 = df_group_1[df_group_1.dc == dc]
        df_dc_2 = df_group_2[df_group_2.dc == dc]
        df_dc_all = df_all[df_all.dc == dc]

        # Plot each group
        for x, ax_offset in zip(
                ['etoh_previos_day', 'etoh_at_bec_sample_time',
                 'etoh_next_day'],
                [0, 1, 2]):
            # Condition A
            df_dc_1.plot(kind='scatter', x=x, y='bec', c='g',
                         xlim=xlim, ylim=ylim, ax=axs[i*3 + ax_offset])

            # Condition B
            df_dc_2.plot(kind='scatter', x=x, y='bec', c='orange',
                         xlim=xlim, ylim=ylim, ax=axs[i*3 + ax_offset])

            # Add histogram for all data points
            df_dc_all.bec.hist(color='b', orientation='horizontal',
                               ax=axs_hist[i*3 + ax_offset],
                               alpha=alpha,   # transparency
                               bins=20,       # number of bins to distribute
                               normed=True)   # normalize to be comparable across 
                                              # different sample sizes

            # Add regressions
            _regression_and_corr(df=df_dc_1, x=x, ax=axs[i*3 + ax_offset])
            _regression_and_corr(df=df_dc_2, x=x, ax=axs[i*3 + ax_offset])

            # Calculate ANCOVA p-value (H0: slopes are equal)
            _plot_ancova_regression_pvalue(df=df, ax=axs[i*3 + ax_offset])

    # Fine tune plot look'n'feel
    plt.tight_layout()

    # Hide spaces between subplots
    fig.subplots_adjust(hspace=0)
    fig.subplots_adjust(wspace=0)

    # Hide all ticks
    plt.setp([a.get_xticklabels() for a in fig.axes], visible=False)
    plt.setp([a.get_yticklabels() for a in fig.axes], visible=False)

    # Show first columns and last row ticks since they are shared
    plt.setp([axs[i].get_xticklabels() for i in [9, 10, 11]], visible=True)
    plt.setp([axs[i].get_yticklabels() for i in [0, 3, 6, 9]], visible=True)

    # Label rows Y-label
    [ax.set_ylabel('') for ax in axs]
    axs[0].set_ylabel('LD', fontsize=font_sz)
    axs[3].set_ylabel('BD', fontsize=font_sz)
    axs[6].set_ylabel('HD', fontsize=font_sz)
    axs[9].set_ylabel('VHD', fontsize=font_sz)

    # Dummy scatter for legend
    dot_1 = plt.scatter([1], [1], color='g', marker='o', label=label1, s=80)
    dot_2 = plt.scatter([1], [1], color='orange', marker='o', label=label2, s=80)
    axs[0].legend(handles=[dot_1, dot_2],
                  bbox_to_anchor=[0, 1],
                  loc='lower left',
                  scatterpoints=1)

    # Set figure's title
    title = 'BEC correlation: EtOH the day before, day of and day after'
    fig.text(0.5, 0.94, title, ha='center', fontsize=font_sz + 4)
    fig.text(0.005, 0.5, 'BEC', va='center', rotation='vertical')
    fig.subplots_adjust(top=0.90)

    # Label groups
    fig.text(0.19, 0.01, 'EtOH Day Before', ha='center', fontsize=font_sz)
    fig.text(0.5, 0.01, 'EtOH Day of BEC Sample', ha='center', fontsize=font_sz)
    fig.text(0.83, 0.01, 'EtOH Day After', ha='center', fontsize=font_sz)
    fig.subplots_adjust(bottom=0.05)

    return fig
{% endhighlight %}

Where regression lines are made with Numpy's polyfit:

{% highlight python linenos %}
def _regression_and_corr(df, x, ax):
    # Get x and y
    x = df[x]
    y = df['bec']
    
    # Fit straight line (polynomial of the first degree)
    fit = np.polyfit(x, y, deg=1)
    ax.plot(x, fit[0] * x + fit[1], color=linecol)

    # Annotate
    props = dict(boxstyle='round', facecolor='wheat', alpha=0.5)
    text = group_label + ' Corr: %s' % np.round(x.corr(y), 4)
    ax.text(0.05, 0.95 + text_y_adj, text,
            transform=ax.transAxes, fontsize=14,
            verticalalignment='top', bbox=props)
{% endhighlight %}


The reason why histogram appeared on the plot is because we spotted some unexpected behavior - histogram clarified that it was just a perception problem - too many data points. As an alternative, we can do hexbin plot with a slight twitch of code:

{% highlight python linenos %}
# Using 24 subplots instead
# And Pandas's hexbin method:
axs[i*6 + offset].hexbin(x=df_dc_1.etoh_previos_day, y=df_dc_group_1.bec, 
			   cmap=plt.cm.Greens,  # Color scheme
			   gridsize=10)         # Fairly important parameter
{% endhighlight %}

[![Regression (BD)]({{ site.url }}/images/matrr/22hr_bec_more2stdev_hexbins.png)]({{ site.url }}/images/matrr/22hr_bec_more2stdev_hexbins.png)

Hexbin plot allows us to see another dimension for the case of too many data points by histograming those points into hexagonal bins. 