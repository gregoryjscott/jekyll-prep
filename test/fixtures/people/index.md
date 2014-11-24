---
front matter: this is front matter
---

{% for person in page.items %}
[{{ person.title }}]({{ person.url }})
{% endfor %}
