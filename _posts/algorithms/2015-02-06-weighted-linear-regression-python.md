---
layout: post
tags: [algorithms, python]
title: Weighted Linear Regression in Python
---

While linear regression allows to draw a line to fit into the data in such a way to minimize Squared Error, 
weighted regression takes into account the significance of training examples: it makes sense that those data points
that are closer to x, that we are trying to predict on, have more influence on it. 

The analogy is - sliding window. When we predict on x - we look in the window: what's around x? Further away it is - 
less influence it has on our beliefs about x. 

Here is python code to do that. To demonstrate - we plot a resulting line:

{% highlight python linenos %}
#weighted linear regression
def wls(x, y, tau=0.3):
    """
    :param x: feature matrix
    :param y: target vector
    :param tau: smoothing factor - Gaussian bump's width
    :return: plot of matplotlib
    """
    x = np.mat(x).T
    y = np.mat(y).T
    m = x.shape[0] #number of examples

    dummy = np.mat(np.ones((m,), dtype=np.int))
    X = np.hstack((dummy.T, x)) #design matrix

    #try predicting on new possible examples
    xpred = np.linspace(x.min(), x.max(), 200)
    ypred = np.zeros(200)

    for i in xrange(len(xpred)):
        xval = xpred[i]

        W = np.eye(m) #weights for current ith example
        theta = np.zeros(m) #thetas for that

        #fill weights via Gaussian sigmoid
        for j in xrange(m):
            W[j][j] = np.exp(-np.linalg.norm(x[j] - xval)**2 / 2*tau**2)

        #calc theta
        theta = np.linalg.inv(X.T * W * X) * (X.T * (W*y))

        #make prediction
        ypred[i] = np.mat([1, xval]) * theta

    plt.plot(x, y, 'ro', xpred, ypred, 'b-')
    pylab.show()
    return plt
{% endhighlight %}
