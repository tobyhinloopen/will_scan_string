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
- The gem does not support named capture groups whatsoever.