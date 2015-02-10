---
layout: post
title: Gaussian Discriminant Analysis
---
GDA is an example of generative learining. It works very simple:
* We make assumption about the type of distributions of our data - in given example: Normal Distribution
* For each class we learn (on training data) the parametrs of distribution: mu, sd
* We model each class' distribution via Likelihood
* For new data example we calculate the likelihood of belonging to each of the classes
* Finally, we choose the maximimum likelihood to predict the class.

Here is the simplyfied code for Matlab:


{% highlight matlab linenos %}
function gda()
    train_data = load('vowel.train');

    % extract the target and the predictor variables for all the data
    x = train_data(:,2:11);
    y = train_data(:,1);

    [m,n] = size(x);

    % find out the number of classes
    unique_classes = unique(y);
    k = length(unique_classes);

    % estimate the prior probability of each class
    phi = zeros(num_classes, 1);
    for i = 1:k
        class = unique_classes(i);
        phi(i) = length(y(y==class)) / m;
    end

    % estimate the mean for each class
    mu = zeros(k, n);
    for i = 1:k
        class = unique_classes(i);
        x_in_class = x(y == class,:);
        mu(i, :) = mean(x_in_class);
    end

    % estimate the common covariance matrix for the data centered on its
    % respective means
    sigma = eye(n, n);
    for i = 1:k
        class = unique_classes(i);
        x_in_class = x(y == class,:);
        diff = x_in_class - repmat(mu(i, :), length(x_in_class(:,1)), 1);
        sigma = sigma + diff'*diff;
    end
    % Normalize sigma
    sigma = sigma / m;
    
    % precompute the inverse of sigma for later use
    sigma_inv = inv(sigma);

    % make predictions on the train data
    % intialize conf -- the k*k confusion matrix, where entry conf(i,j) is the
    % number of times the true class i was predicted as class j
    conf = zeros(k, k);

    coef = 1/((2*pi)^(n/2) * sqrt(det(sigma)));
    for i = 1:m
        p = zeros(k, 1);
        for class = 1:k
            diff = x(i, :) - mu(class, :);
            pxy = coef * exp( -1/2 * diff * sigma_inv * diff');
            py = phi(class);
            p(class) = pxy * py;         
        end
        p = p / sum(p);

        % find the most probable class
        [max_prob, predicted_class] = max(p);

        % update the confusion matrix for this example's prediction
        conf(y(i), predicted_class) = conf(y(i), predicted_class) + 1;
    end
    
    % compute the accuracy of all predictions
    accuracy = sum(diag(conf)) / sum(sum(conf))

    % compute the precision per class
    per_class_precision = diag(conf) ./ sum(conf, 2)

    % compute the base rate accuracy
    base_rate = max(sum(conf, 2)) ./ sum(sum(conf))
{% endhighlight %}
