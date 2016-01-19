---
layout: post
title: Time Series Investigations
---
I've taken Time Series analysys class to figure out if analyzing financial data and predicting stock markets (my first association with time series) were something I would be interested in doing. Additionally, there are many practical scientific and business applications - starting with electrocardiology analysis and ending with airline tickets sales. 

What I've learned, shortly: 

- Don't play on the stock markets - the best guess is (almost) always the current value (in other words, the chance of being any good in prediction is basically zero).
- Use TS to gain insights about your business data.
- Scientific use is very complicated most of the times nonetheless interesting.

### What is Time Series Analysys anyways? 
In regular stats we have a population (set of all data points), from which we have a random (i.e. representative - hopefully) sample (of size N) of available observations. We calculate **sample** statistics and *infer it to be true* about the **general** population as well. The bigger the sample size N the more we are statistically sure.

Now, Time Series Analysys want to perform similar trick (analysing sample and infering about general) but for the ***process*** rather than for the population. Usually, then, we have only **one** observation/realization (Apple stock price history) of the process , but this process could have generated a different realization - in fact infinitely many of them! That is the key difference of the TS: we trying to describe the process that generated different realizations using avavailble observations (ususully one) and then predict what would happen to our realization in the future. I hope by now you get the idea of how sketchy and speculative all that sound - in case of the stock markets, especially, it's pretty much a gamble. 

To describe the observation (time serie) people came up with a model ARIMA, which stands for auto regressive integrated moving average. Sounds scary, but in reality it's extremely simple:

- AR part is just a linear combination (summation with coefficients) of previous TS values equal white noise.
- MA part is again just a linear combination, this time of random noise values equals to the current TS value.
- Integrated simply means that de-trend the time series by linearly substracting previous value from the current.

Given the realization, we try to fit the coefficients for those linear combinations and then predict the future values.

That is, shortly, what is Time Series about. Again, importantly, the length of the TS doesn't give us the statistical power, as in regular statistics - we only gain power if we have **more realizations**, when, for instance, we track the heart beat process for the 24 hours straights, which yields a lot of observations of that cyclic process.

### Investigations

#### Estimating ARMA Coefficients and Predicting Future
<a href="/papers/investigations/time-series/estimating-coefficients-and-predicting-ARMA-process.pdf">
<img border="0" alt="W3Schools" src="/papers/investigations/time-series/preview/estimating-coefficients-and-predicting-ARMA-process.png" width="260"  align="right">
</a>
In this take home final exam for TS class we created a definitive ARMA process (by specifying the true coefficients) to generate 500 realizations. Then using them (all or partially) tried to fit the coefficients using the standard tool set, while judging which metrics work better for our case. Finally, there is example of predicting TS - even for the simple case it works remarkably bad, in my opinion.


#### (Non) Consistent Estimators and the Effect of Differencing
<a href="/papers/investigations/time-series/realizations-and-estimators-consistency.pdf">
<img border="0" alt="W3Schools" src="/papers/investigations/time-series/preview/realizations-and-estimators-consistency.png" width="260"  align="right">
</a>
Consistent estimator is an estimator which only gets closer to the true parameter given more realizations. In this paper we learn that while sample autocorrelation is consitent estimator, periodogram is not.

(First order) differencing is just: for each x_(i) in TS do: x_(i) = x_(i) - x_(i-1). By doing so we can remove linear trend. Paper discusses how to do that in R and how it affects sample correlogram and spectrum.


#### Harmonic Process and How to Convert ARMA into MA
<a href="/papers/investigations/time-series/harmonic-and-AR-MA-identifyability.pdf">
<img border="0" alt="W3Schools" src="/papers/investigations/time-series/preview/harmonic-and-AR-MA-identifyability.png" width="260"  align="right">
</a>
Harmonic process is simply sum of sinusoids, we show it to be second-order stationary. Also it doesn't have a good spectrum function because it's not absolutely continuous; the cumulative spectrum is alright though. 

Then paper shows how to convert ARMA into MA(inf) representation by long division - which only works if the AR roots are outside of unit circle. 

Paper also shows the effect of taking the 12th differencing on spectrum and shows how to check wether or not the AR coefficients are valid (possible). 


#### Mistake Bounds and Uniform Convergence
<a href="/papers/investigations/time-series/time-series-models-summary.pdf">
<img border="0" alt="W3Schools" src="/papers/investigations/time-series/preview/time-series-models-summary.png" width="260"  align="right">
</a>
The cool thing is - we can put a bound on how big our mistakes could be. This paper goes rather deep in how by making more hypothesis we reduce the chance of the mistakes. Also discuses the usage of L-2 soft margins for SVM.