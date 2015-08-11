---
layout: post
title: How to Generate Prime Numbers? (Python)
---
Primary numbers are cool. You can factorize (decompose) any number into product of primes, amazingly, each number has a single unique decomposition. Primes are like simple building blocks for all the other numbers, which are called composites. Generating and checking if number is a prime is the basis for many crypto systems like RSA. So, it make sense to know what's up.

For generating a set of primes up to N we will use Eratosthenes Sieve method which was written down by this Greek guy. Idea is, as usual, very simple and elegant:

* Make a list of numbers 2..N.

* Starting with first element in the list, cross all its multiples in the list. 

* Repeat until no multiples less than N left.

In other words, we just start with the smallest prime (2) and remove all its multiples less than N; then take next prime (3) and do the same; then next prime would be (5) since (4) is already crossed. 

Here is Python snippet:

{% highlight python linenos %}
def eratosthenes_sieve(n):
    numbers = [i for i in range(2, n)]
    pi = 0 # index
    while pi < len(numbers): 
        p = numbers[pi] # current prime
        i = 2 # start with closet multiple
        while p * i <= n: # while multiple less than N -> remove it from the list (if it is still in)
            if numbers.__contains__(p * i):
                numbers.remove(p * i)
            i += 1
        pi += 1
    return numbers
{% endhighlight %}

That was easy. Okay, let's try to optimize. Let us observe what happens when we remove multiples:
* 2 -> remove: 4, 6, 8, 10, 12, 14, 16... 

* 3 -> remove: **6**, 9, 12, 15 ...

* 4 -> remove: **8**, **12**, **16** ...

* 5 -> remove: **10, 15, 20**, 25 ...

Interestingly, each time we try to find multiples for next prime, we see, that first multiples were already removed on the previous steps. By going further we can prove, that all the multiples less than current prime squared were already removed. That means we can trim this part of checks:
{% highlight python linenos %}
def eratosthenes_sieve_refine(n):
    numbers = [i for i in range(2, n)]
    pi = 0
    while True:
        p = numbers[pi]
        p_sq = p ** 2
        if p_sq > n:
            break
        while p_sq <= n:
            if numbers.__contains__(p_sq):
                numbers.remove(p_sq)
            p_sq += p
        pi += 1
    return numbers
{% endhighlight %}

Next optimization is about which structure we use. Instead of expensive checking __contains__, we can do array of bools:
{% highlight python linenos %}
import math
def eratosthenes_sieve_bool(n):
    prime_bool = (n + 1) * [True] # since indexing starts with 0
    for p in range(2, int(math.sqrt(n)) + 1): #int floors the float
        if prime_bool[p]:
            for i in range(p ** 2, n + 1, p): # p^2, p^2 + p, p^2 + 2p ...
                prime_bool[i] = False
    return [i for i, elem in enumerate(prime_bool) if elem][2:]
{% endhighlight %}

Finally, we can also observe, that all the **even** numbers are composites. So we can init our bool array with Falses at the beginning; then we can do 2p step instead if singe p, since 2p is always even number.

{% highlight python linenos %}
def eratosthenes_sieve_bool_odd(n):
    prime_bool = [True, True, True] + (n / 2 - 1)  * [True, False]
    for p in range(2, int(math.sqrt(n)) + 1): #int floors the float
        if prime_bool[p]:
            for i in range(p ** 2, n, 2 * p):
                prime_bool[i] = False
    return [i for i, elem in enumerate(prime_bool) if elem][2:]
{% endhighlight %}

Now let's check the real performance with N = 2000:
{% highlight python linenos %}
import time
start = time.time()
eratosthenes_sieve(2000)
end = time.time() - start

eratosthenes_sieve exec time: 0.018317937851
eratosthenes_sieve refine exec time: 0.0219550132751
eratosthenes_sieve bool exec time: 0.00025200843811
eratosthenes_sieve bool odd time: 0.000149965286255
{% endhighlight %}

Understandably, bool version with both improvements (init with odds and start with p^2) works the fastest. 


