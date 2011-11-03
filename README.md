Will scan string
================
Multi-pass string replacement has always been fun. I don't know any good way to
perform multiple replacements on strings, so I made this minor gem.

Notes
-----
This gem is buggy and nowhere friendly to use. It's designed for personal use
and is very experimental. It uses various hacks to combine multiple regular
expressions to a single big-ass regular expression and it therefore is quite
common for 2 regular expressions conflicting each other.

Known regexp conflicts and issues
---------------------------------
- Mixing regular expressions with named and unnamed capture groups causes the
  gem to fail miserably. This is because the ruby regexp engine doesn't support
  mixing named and unnamed capture groups and my gem doesn't check if other
  regular expressions use named or unnamed capture groups.
