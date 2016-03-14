---
layout: post
tags: [algorithms, java]
title: How to Implement Arithmetic Operators in Java?
---
Famously, addition and negation is sufficient to perform all the other operations like subtraction, multiplication and division. If we are allowed to use loops and arbitrary integers on the way, it is relatively straightforward ho to implement negation using addition:

{% highlight java linenos %}
int negate(int x){
	int d = x < 0 ? 1 : -1; // determine sign of the increment
	int neg = 0;
	while (x != 0){ // add increment into neg until x is zero
		x += d;
		neg += d;
	}
	return neg;
}
{% endhighlight %} 

How to make addition? Since nothing available - turn to bit manipulations. Since we work with base 2, when adding two ints we compare them bit by bit. If relative bits are equal (0, 0 or 1, 1) then 0 goes to the sum; if they are different - 1. That is essentially a XOR operation. Yet we need to care about carrying overflow (when adding 1 and 1). Only 1, 1 is found by AND. Since it goes to the more significant bit, we also need to shift << one bit to the left. Once we have sum and carry, we need to add them up - using the same procedure, recursively. Base case to stop - if carry is 0. Here is the code:

{% highlight java linenos %}
int addWithoutAriphmetic(int a, int b){
	if (b == 0){
		return a;
	}
	int sum = a ^ b;
	int carry = (a & b) << 1;
	return addWithoutAriphmetic(sum, carry);
}
{% endhighlight %} 

That was mind boggling, now easy stuff: carefully implement remaining operators:
{% highlight java linenos %}
int substract(int a, int b){
	return a + negate(b);
}

int multiply(int a, int b){
	if (a < b){ //to make if faster
		int tmp = a;
		a = b;
		b = tmp;
	}
	int res = 0;
	boolean bneg = b < 0;
	if (bneg){
		b = negate(b);
	}
	for (int i = 0; i < b; i++){
		res += a;
	}
	if (bneg){
		res = negate(res);
	}
	return res;
}

int divide(int a, int b){
	if (b == 0){
		throw new java.lang.ArithmeticException("divide by zero");
	}	
	boolean aneg = a < 0;
	boolean bneg = b < 0;
	
	if (aneg){
		a = negate(a);
	}
	if (bneg){
		b = negate(b);
	}
	
	if (a < b){
		return 0;
	}
	
	int res = 0;
	int sum = b;
	while (sum <= a){
		sum += b;
		res ++;
	}
	
	if ((aneg && !bneg) || (!aneg && bneg)){
		res = negate(res);
	}
	return res;
}
{% endhighlight %} 