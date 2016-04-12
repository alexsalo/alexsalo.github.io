---
layout: post
tags: [design]
title: Everyday Design&#58; Microwave
---
When I earn enough money I plan to embark on the journey of designing better things. It is mysteriously surprising why everyday things around us are designed, often, so poorly. Stave Jobs was obsessed with usability, simplicity and cleanness of the design in his products. Google has been producing top notch design for its products recently. Why then manufacturers of the everyday things do not seem to care about that at all? As an example, let's consider the microwave from my apartment: 

[![Bad Design Microwave]({{ site.url }}/images/design/microwave-bad-design.jpg)]({{ site.url }}/images/design/microwave-bad-design.jpg)

Looks typical? Sadly, yes. Here is why this design is sad:

- Running line on the display is ridiculously annoying. In general, running lines should be avoided everywhere because they distract us, and it is hard to read the information anyways. You can always shorten the words or better not use them at all: make it self evident. In this case, microwave provides very valueable info: ***touch start to...*** In general, we always try to desing buttons in such a way that it would be obvious to anyone that they should be pressed or touched. In this case buttons look ok, so no need for redundant info, which by the way never goes away, it **keeps running until the next use**, which distracts me even from my bed in another room if the door is not completely shut. Thus this microwave shows redundant info 90% of the time, rather than showing oh, well, time? 
- According to my observations, 95% of the time people don't want from the microwave anything fancy. They just want to start it, say for 30 seconds. How to start? In my previous apartment that would happen when you press green colored "start" button. It took us almost a year to realize that this microwave has a ***jet start*** button which does exactly that. Why designating a separate button to something that could be done by another button?  
- Actually, this argument extends to **all the buttons**. Why we need so many of them? What are the core functionality of the device? It's ***to heat up***. By far, most of the times we simply need to start/stop the microwave, but we have this abundance of buttons of **equal size** which initate actions of different importance. 
- Nine buttons are used as a keypad for setting time of heating. How many of us need it very precies? Do we care if its 40 or 42 seconds? No. Thus keypad is a waste, simple control knob will do the job much better. 
- The last one is arguably the most annoying feature ever: once time is up, the microwave will start triple beep once in 30 seconds. It will continue to do it... forever, I kid you not! Nothing should go on forever, why not make a switch back to normal after several minutes? 

Based on all the observations above I made a sketch of my microwave prototype. I'd call it 'Simple' or 'Go':
[![Simple Design Microwave]({{ site.url }}/images/design/microwave_simple_go.png)]({{ site.url }}/images/design/microwave_simple_go.png)

Several important details which are not clear from the picture:

- Diplay always shows 4 digits in 'mm:ss' format. 
- Simple control knob is used to change the numbers; pressing it starts the device, if idle or stops, if active.
- Secondary switches are small and located separately. Simple button + indicator (on/off) could be used to emulate physical switch.
- Set time button temporarily (5 sec?) allows to use the control knob to adjust time. 
- Once inactive (1 min timout?) display starts displaying clock time instead of cooking time. 
- Cooking time is never reset, we just use control knob to add or substract time. 
- This control knob should be smart too: the faster and longer you spin - the more are the chunks of the time increase.  

Thus by determining and separating the core functionality of the microwave and by optimizing the control tools we created intuitive and easy-to-use device. 

