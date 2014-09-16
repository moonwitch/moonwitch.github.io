---
layout: page
title: Contact
---
You'll notice there's a rather huge list where I am active - or rather have an account. Usually though, most of my love goes to github, on Google+ (HangOuts) I am very reachable, since I am an avid Android user. (In case you are wondering; my prefered device is a [OnePlus One](http://oneplus.net). Awesome device - hasn't failed me once.)

Fastest way to reach me; would be by email of course.


<ul class="navlist_social">
  <li>
    <a href="mailto:kelly.crabbe@gmail.com" class="email"><i class="fa fa-envelope fa-lg fa-border"></i></a>
  </li>
  <li>
    <a href="" class="messenger"><i class="fa fa-weixin fa-lg fa-border"></i></a>
  </li>
  {% if site.data.other.twitter_username %}
  <li>
    <a  class="twitter" href="https://www.twitter.com/{{ site.data.other.twitter_username }}"><i class="fa fa-twitter fa-lg fa-border"></i></a>
  </li>
  {% endif %}

  {% if site.data.other.linkedin_username %}
  <li>
    <a class="linkedin" href="https://www.linkedin.com/{{ site.data.other.linkedin_username }}"><i class="fa fa-linkedin fa-lg fa-border"></i></a>
  </li>
  {% endif %}

  {% if site.data.other.skype_username %}
    <li>
        <a class="skype" href="skype:{{ site.data.other.skype_username }}?chat"><i class="fa fa-skype fa-lg fa-border"></i></a>
    </li>
  {% endif %}

  {% if site.data.other.github_username %}
    <li>
        <a class="github" href="http://github.com/{{ site.data.other.github_username }}"><i class="fa fa-github fa-lg fa-border"></i></a>
    </li>
  {% endif %}

  {% if site.data.other.google_username %}
    <li>
        <a class="google" href="https://www.google.com/+{{ site.data.other.google_username }}"><i class="fa fa-google-plus fa-lg fa-border"></i></a>
    </li>
  {% endif %}

  {% if site.data.other.facebook_username %}
    <li>
        <a class="facebook" href="http://facebook.com/{{ site.data.other.facebook_username }}"><i class="fa fa-facebook fa-lg fa-border"></i></a>
    </li>
  {% endif %}
  <li>
    <a class="rss" href="{{ site.baseurl }}/feed.xml" type="application/rss+xml"><i class="fa fa-rss fa-lg fa-border"></i></a>
  </li>
</ul>

<!-- Adding skype script -->
<script type="text/javascript" src="http://www.skypeassets.com/i/scom/js/skype-uri.js"></script>