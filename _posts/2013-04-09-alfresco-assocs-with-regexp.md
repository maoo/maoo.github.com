---
title: Fetching Alfresco Associations using regular expressions
layout: post
primary_img: /img/post/link-building.jpg
categories: [alfresco]
meta-description: Fetching Alfresco Associations using regular expressions
---


Long time no see ha?

I'd like to share with you (and keep track of) a simple code optimisation that allowed me write a better, cleaner and more performing Alfresco backend logic.
I've searched around some examples on how to do it, but there's not much, so here we are!

In the first code block I am <b><i>fetching all target associations from a node</i></b> and - in a second stage - extract only those that I really need.

The second code block does exactly the same, but avoiding a post-processing iteration and delivering a nice and clean 1-liner solution.

The last block defines another Regular Expression that matches all QNames of a given namespace. You can notice that the match is done upon the fully qualified QName, using the namespace URL, not its prefix.

<script src="https://gist.github.com/maoo/5345612.js"></script>