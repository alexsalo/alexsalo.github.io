---
layout: post
tags: [algorithms, python]
title: Hanoi Tower problem in Python
---

We have tree pegs with the discs on top of one another with decreasing size. Task is to move all disks from one peg to another while moving only one disk pertime and keeping smaller disks on biggers. 

Recursive alg with the following idea: if we want to move 8 disks from peg1 to peg2, then we need to move 7 upper disks to the work peg first, then mode last to peg2 and then put 7 disks on top. Fist and last step is just an instance of Hanoi Tower problem once again, so we recursively call the function. Stopping condintion is if we want to move one disk only - then we just move. 

Python impl:

{% highlight python linenos %}
N_disks = 8
basicOperationCounter = 0

tower1 = [N_disks - i for i in xrange(N_disks)]
tower2 = []
tower3 = []

def printTowers():
    print tower1
    print tower2
    print tower3
    print '-------------------'

def moveDisk(out, to):
    disk = out[-1] # top element
    out.remove(disk)
    to.append(disk)

    global basicOperationCounter
    basicOperationCounter += 1
    printTowers()

def move(n, out, to, work):
    if n > 1:
        move(n - 1, out, work, to)
    moveDisk(out, to)
    if n > 1:
        move(n - 1, work, to, out)


printTowers()
move(N_disks, tower1, tower2, tower3)
print 'Move completed in %s steps. Theoretical bound is 2^n-1 = % s' % (basicOperationCounter, 2 ** N_disks - 1)
{% endhighlight %}
