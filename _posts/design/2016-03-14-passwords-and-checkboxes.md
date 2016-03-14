---
layout: post
tags: [design, security]
title: Weak Pass And Poor Checkbox Use
---
Making the first impression is very important for your service, and login/register form is typically the first thing user will see, which renders it important to invest and design it right.

There are abundance of utterly horrible designs out there, but today,  I want to criticize a relatively good one:

[![Change Password Form Design]({{ site.url }}/images/design/elo-bad-design.png)]({{ site.url }}/images/design/elo-bad-design.png)

First thing first: 10 chars is **not enough** for the password if you **really care**, and if you don't - why bother with special chars? Oops, I misread the info: the length is actually 8 chars, and must contain at least one letter and one number. Here is the clue: it should be nearly impossible to misread your design - be clear and precise, test it on people! Now, 8 chars is not very secure at all - breakable by brute force. Yet they ask for at least one number (normally other services in USA ask for other garbage as well). As every school kid knows: adding a several char options into domain space do **not increase the secureness** of the password - machine really doesn't care which chars you use.

So far we have a weak password with the number which makes it harder to remember (than secure long paraphrase).

Do three checkbox requirements look like you could/should click on them? To me - absolutely. But they are not. Why would you do that to your valuable user?

Now why you want me to confirm my new password? Since long we agreed that the chance of such event (you mistype your password) are relatively low, hence you should be trusted with one attempt only, and in case of unlikely event - you just rest the pass again - sure you can since you got here in the first place.

Again, this design is very nice compare to what is typically out there, yet it could be improved. Please design nice things!
