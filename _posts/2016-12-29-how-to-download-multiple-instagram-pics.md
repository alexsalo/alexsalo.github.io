---
layout: post
tags: [web, hack, bash]
title: How to Download Multiple Instagram Photos at Once?
---
You want to print your Insta photos or just keep them save and archived? Out of luck - there is no obvious way to download them, unless you manually click save on every one of them. Yes, there are a few services that claim they can download it for you, but none of them worked sufficiently well in my case. And so I set about writing a bash script. Here is how to use it:

1. Go to [https://www.instagram.com/username/](https://www.instagram.com/username/), hit "load more" and scroll down until you are satisfied.
2. Right click -> inspect element -> click once at the top "html" parent node and hit ctrl+c to copy the **generated** html into the clipboard. Instagram is foxy and with its implementation on React it does not leak you with all the urls easily. That's why we could not just wget the page to begin with.
3. In any text editor, paste the html with ctrl-v and save the file into ***username.txt***.
4. Paste the script into ***getit.sh***, make it executable by ***chmod +x getit.sh*** and finally run it with ***./getit.sh***.

{% highlight sh %}
# split into new line with every new src tag
cat $username.txt | sed -e 's/src=\"/\'$'\n/g' > lines.txt

# collect the urls using regex
cat lines.txt | grep '^https.*n\.jpg' -o > urls.txt

# replace the default resolution to the max resolution
cat urls.txt | sed 's/s640x640/sMax/g' > urls_max.txt

# loop over the urls and curl them down using the digit-name from the url
while read p; do
  name=$(echo $p | egrep '[0-9]{8}_[0-9]+_[0-9]+' -o)
  echo downloading $name ...
  curl $p > $name.jpg
done < 'urls_max.txt'
{% endhighlight %}

Profit!
![Yosemite](/images/yosemite.jpg)
