---
layout: page
title: Contact
---
You'll notice there's a rather huge list where I am active - or rather have an account. Usually though, most of my love goes to github, on Google+ (HangOuts) I am very reachable, since I am an avid Android user. (In case you are wondering; my prefered device is a [OnePlus One](http://oneplus.net). Awesome device - hasn't failed me once.)


<ul class="navlist_social">
  {% if site.data.other.twitter_username %}
  <li>
    <a  class="twitter" href="https://www.twitter.com/{{ site.data.other.twitter_username }}">Twitter</a>
  </li>
  {% endif %}

  {% if site.data.other.tumblr_username %}
  <li>
    <a class="tumblr" href="http://tumblr.com/blog/{{ site.data.other.tumblr_username }}">Tumblr</a>
  </li>
  {% endif %}

  {% if site.data.other.linkedin %}
  <li>
    <a class="linkedin" href="https://www.linkedin.com/{{ site.data.other.linkedin_username }}">LinkedIn</a>
  </li>
  {% endif %}

  {% if site.data.other.skype_username %}
    <li>
        <a class="skype" href="skype:{{ site.data.other.skype_username }}?chat">Skype Me</a>
    </li>
  {% endif %}

  {% if site.data.other.github_username %}
    <li>
        <a class="github" href="http://github.com/{{ site.data.other.github_username }}">GitHub</a>
    </li>
  {% endif %}

  {% if site.data.other.google_username %}
    <li>
        <a class="google" href="https://www.google.com/+{{ site.data.other.google_username }}">Google +</a>
    </li>
  {% endif %}

  {% if site.data.other.facebook_username %}
    <li>
        <a class="facebook" href="http://facebook.com/{{ site.data.other.facebook_username }}">Facebook</a>
    </li>
  {% endif %}

  {% if site.data.other.coderwall_username %}
    <li>
        <a class="coderwall" href="http://coderwall.com/{{ site.data.other.coderwall_username }}">Coderwall</a>
    </li>
  {% endif %}
  <li>
    <a class="rss" href="{{ site.baseurl }}/feed.xml" type="application/rss+xml">RSS</a>
  </li>
</ul>

<!-- Adding skype script -->
<script type="text/javascript" src="http://www.skypeassets.com/i/scom/js/skype-uri.js"></script>