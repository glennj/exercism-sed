v 4.9

s/([^\n]+)(.)$/\2\n\1/
:redo
s/([^\n]+)(\n.*)(.)$/\1\3\2/
t redo
