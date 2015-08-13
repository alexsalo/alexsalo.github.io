---
layout: post
title: How to Check if the Number is Prime?
---
To check if the number N is a prime we can either generate with the Eratosthenes Sieve the bool array for all the numbers <= N and them sipmly check if true. However, that seems like overkill to me (especially for big N), so let's try something different while using all the knowledge about primes we already have:

{% highlight python linenos %}
def is_prime(n):
	# Let's check primitive cases
    if n <= 1:
        return False
    elif n <= 3:
        return True
    elif n % 2 == 0 or n % 3 == 0:
        return False

	# Now: any number can be represented as 6k + i, where i = 0..5 <-> i = -1..4
	# (6k + 0),(6k + 2) and (6k + 4) are divisible by 2 -> hence not primes
	# (6k + 3) is divisible by 3 -> hence not prime
	# Thus of all numbers, only those with format (6k - 1) or (6k + 1) left. Let's check them only:
    i = 5 #first 6k - 1
    while i * i <= n: #since primes are only before sqrt(n)
        if n % i == 0 or n % (i + 2) == 0: #i + 2 = 6k + 1
            return False
        i += 6
	return True
{% endhighlight %}

Thus in this primarily test we only check one third of all the numbers before N, and only if N is not multiple of 2 or 3. 

Just for fun, the same in Java:
{% highlight java linenos %}
boolean isPrime(int n){
	if (n < 2)
		return false;
	if (n < 4)
		return true;
	if (n % 2 == 0 || n % 3 == 0)
		return false;		
	int sqrt = (int) Math.sqrt(n);
	for (int i = 5; i < sqrt; i += 5)
		if (i == 0 || i + 2 == 0)
			return false;
	return true;
}
{% endhighlight %}
