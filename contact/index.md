---
layout: page
title: Contact
---
<ul class="navlist_social">
  {% if site.data.other.twitter_username %}
  <li class="twitter">
    <a href="http://twitter.com/{{ site.data.other.twitter_username }}">Twitter</a>
  </li>
  {% endif %}

  {% if site.data.other.tumblr_username %}
  <li class="tumblr">
    <a href="http://tumblr.com/blog/{{ site.data.other.tumblr_username }}">Tumblr</a>
  </li>
  {% endif %}

  {% if site.data.other.linkedin_username %}
  <li class="linkedin">
    <a href="http://linkedin.com/{{ site.data.other.linkedin_username }}">LinkedIn</a>
  </li>
  {% endif %}

  {% if site.data.other.skype_username %}
    <li class="skype">
        <a href="skype:{{ site.data.other.skype_username }}?chat">Skype Me</a>
    </li>
  {% endif %}

  {% if site.data.other.github_username %}
    <li class="github">
        <a href="http://github.com/{{ site.data.other.github_username }}">GitHub</a>
    </li>
  {% endif %}

  {% if site.data.other.google_username %}
    <li class="google">
        <a href="http://googleplus.com/{{ site.data.other.google_username }}">Google+</a>
    </li>
  {% endif %}

  {% if site.data.other.facebook_username %}
    <li class="facebook">
        <a href="http://facebook.com/{{ site.data.other.facebook_username }}">Facebook</a>
    </li>
  {% endif %}

  {% if site.data.other.coderwall_username %}
    <li class="coderwall">
        <a href="http://coderwall.com/{{ site.data.other.coderwall_username }}">CoderWall</a>
    </li>
  {% endif %}
</ul>

<!-- Adding skype script -->
<script type="text/javascript" src="http://www.skypeassets.com/i/scom/js/skype-uri.js"></script>
<script type="text/javascript" src="https://apis.google.com/js/platform.js"></script>
<div class="g-hangout" data-render="createhangout"></div>