v 4.9

1{h;d}
:n;$!{N;bn}
s/^/\n/

b main

:decr
s/([0-9]*)$/\1@/
:d;{s/0@/@9/;/0@/bd}
s/1@/_0/
s/2@/_1/
s/3@/_2/
s/4@/_3/
s/5@/_4/
s/6@/_5/
s/7@/_6/
s/8@/_7/
s/9@/_8/
s/ _0*/ /
s/_//
x

:main

x

/^row:0*[2-9]/ { x; s/\n[^\n]+\n/\n/; x; b decr }
/^row:0*1$/    { x; s/^\n//; s/\n.*// }

/^column:0*[2-9]/ { x; s/\n[0-9]+ */\n/g; x; b decr }
/^column:0*1$/ {
    x
    :col; s/\n([0-9]+)[^\n@]*(.*)/\2@\1/; t col
    s/^@//
    s/@/\n/g
}
