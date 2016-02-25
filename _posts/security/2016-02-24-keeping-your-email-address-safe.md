---
layout: post
title: Keeping Your Email Address Safe
---
How do spammers learn our email addresses? Well, it's possible to buy them (in huge bunches, of course) from various sellers. Seller could be not-so-honest-web-site, that just sells its customer base, or someone, who crawled a part of the web (in which you are present) and **parsed** your email address.

Anytime, we put our email address or cellphone number on the static web page - we just leave it out there to be parsed and sold to the spammers. Below are some more or less efficient ways to display yet not compromise your email address or cellphone number. Then, we'll try to outsmart that protection.

By the way, have you noticed that in AirBnB you can't send you cell number to the potential host? Otherwise, you could have skipped the middleman (airbnb) and arranged the bed with the owner directly. AirBnB doesn't want that and detects any of your attempts to send a number or email address via direct messaging (before you paid for the night). My 'nine-zero-eight-...' was not sophisticated enough to trick the system when were stuck in Paris...  

### Concealing Email Address from Parsing
Here are some common methods to conceal email address:

- Using uppercase: **name@mail.COM** - pretty inefficient and ugly looking
- Insert some repeated symbol: **a-l-e-x-@-m-a-i-l-.-c-o-m** - ugly
- Playing with '@' symbol:
  - substitute as at or (at): **name(at)mail.com** - kind of easy, though looks ok
  - use Unicode sequence **\|& #x40 ;** which renders @ - efficient and cool
- Playing with '.' symbol:
  - dot, dom, dt: **name@mail dt com** - pretty lame though efficient if used not trivially
  - using other special char: **name@ecs;stanford;com**
  - simply space: **name @ ecs mail com** - this is surprisingly tricky to parse, but easy to understand
- Use word construct: **teresa (followed by "@stanford.edu")** - hard to parse

These are the common tricks, out of which I'd recommend to go with simple spaces with changing @:
**alex at cs baylor edu**

<script type="text/javascript">
function obfuscate( domain, name ) { document.write('<a href="mai' +
'lto:' + name + '@' + domain + '">' + name + '@' + domain + '</' + 'a>'); }
</script>

Now, all of the above still sort of parsable. To make it **really** hard, we can write small js script to print the email address: obfuscate(name, domain) in html -> renders name@domain.com in the browser. Since parser works with html it would not have pieces together. Try wget this page and parse this address: <script> obfuscate('mail.edu','alex'); </script>

Here is the script, which was copied from Dan Jurafsky Stanford's web page:
{% highlight javascript linenos %}
<script type="text/javascript">
function obfuscate( domain, name ) { document.write('<a href="mai' +
'lto:' + name + '@' + domain + '">' + name + '@' + domain + '</' + 'a>'); }
</script>

<script> obfuscate('mail.edu','alex'); </script>
{% endhighlight %}

Alternatively, one can simply use a picture with the email address, which is impossible to parse automatically (well it's possible, but you don't know which picture, and if you checked manually - you would not have needed the parser anyways).

### Parsing Email Address
Now what if we interested to parse email addresses for some good reasons? There is surely endless room for improvement, but here is what I have (using python's re):

{% highlight python linenos %}
import re  # () capture group - will be returned in the tuple
           # (?:) non capture group

# login could be any chars, digit or dot; at least one symbol
login = '([a-z0-9_\.]+)'

# at could be written as a word 'at', symbol '@' or unicode symbol '&#x40;'
# and potentially surrounded by parethsesis or spaces
at = '(?:\s?\(?(?:@|\sat\s|&#x40;|where)\)?\s?)'

# dots in domain are usually masked
dots = ['dot', 'dom', 'dt', ';', '\.', '\s', ' ']

# and potentially surrounded by spaces
# use badass python way to concat list elems with custom sep: sep.join(list)
dot = '(?:\s?(?:' + '|'.join(dots) + ')\s?)'

# domain is (name + dot) one or more times
domain = '((?:[a-z0-9_]+' + dot + '){1,3})'

# zone
zone = '(edu|com)'

email_pattern = login + at + domain + zone

def print_email(email_line):
    # lowercase and remove obfuscating symbols
    email_line = email_line.lower().replace('-', '')

    # match regexp
    matches = re.findall(email_pattern, email_line, re.IGNORECASE)

    # python re returns list of tuples with the number of capture groups
    for login, domain, zone in matches:
        for dot in dots:  # convert each trick dot into real dot
            domain = domain.replace(dot, '.')

        # some spaces turned into extra dots, compress dots
        domain = domain.replace('..','.').replace('..', '.')

        # print email in proper way
        email = '%s@%s%s' % (login, domain, zone)
        print email
print_email('alex at ecs mail com')  # alex@ecs.mail.com
{% endhighlight %}

P.S. Inspired by NLP class [https://class.coursera.org/nlp/lecture/](https://class.coursera.org/nlp/lecture/])

Since class has ended, homeworks are no longer available. However, you can get them in here: [http://www.mohamedaly.info/teaching/cmp-462-spring-2013](http://www.mohamedaly.info/teaching/cmp-462-spring-2013#TOC-Assignments)
