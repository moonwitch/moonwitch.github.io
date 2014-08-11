---
layout: page
title: Contact
---
<ul class="navlist_social">
  {% if site.data.other.twitter_username %}
  <li>
    <a href="https://www.twitter.com/{{ site.data.other.twitter_username }}"><img class="twitter"/></a>
  </li>
  {% endif %}

  {% if site.data.other.tumblr_username %}
  <li>
    <a href="http://tumblr.com/blog/{{ site.data.other.tumblr_username }}"><img class="tumblr"/></a>
  </li>
  {% endif %}

  {% if site.data.other.linkedin %}
  <li>
    <a href="https://www.linkedin.com/{{ site.data.other.linkedin_username }}"><img class="linkedin"/></a>
  </li>
  {% endif %}

  {% if site.data.other.skype_username %}
    <li>
        <a href="skype:{{ site.data.other.skype_username }}?chat"><img class="skype"/></a>
    </li>
  {% endif %}

  {% if site.data.other.github_username %}
    <li>
        <a href="http://github.com/{{ site.data.other.github_username }}"><img class="github"/></a>
    </li>
  {% endif %}

  {% if site.data.other.google_username %}
    <li>
        <a href="https://www.google.com/+{{ site.data.other.google_username }}"><img class="google"/></a>
    </li>
  {% endif %}

  {% if site.data.other.facebook_username %}
    <li>
        <a href="http://facebook.com/{{ site.data.other.facebook_username }}"><img class="facebook"/></a>
    </li>
  {% endif %}

  {% if site.data.other.coderwall_username %}
    <li>
        <a href="http://coderwall.com/{{ site.data.other.coderwall_username }}"><img class="coderwall"/></a>
    </li>
  {% endif %}
</ul>

<!-- Adding skype script -->
<script type="text/javascript" src="http://www.skypeassets.com/i/scom/js/skype-uri.js"></script>