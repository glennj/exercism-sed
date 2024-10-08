v 4.9

:jl;$!{N;bjl}

/\s*\}$/ ! Q 1
s///

/^\{\s*"property"\s*:\s*"equal"\s*,\s*/ {
    s///
    s/\s*\}\s*,?\s*/\n/g
    s/"clock[1-2]":\s*\{\s*/{"property":"equal",/g
    s/\n$//
    h
    s/.*\n//
    x
    s/\n.*//
}

/"subtract"/s/:([0-9]+)$/:-\1/

:proc

/^\{\s*"property"\s*:\s*"(create|add|subtract|equal)"\s*,\s*/ ! Q 1
s//\n/

/\n"hour"\s*:\s*(-?[0-9]+)\s*,\s*"minute"\s*:\s*(-?[0-9]+)\s*/ ! Q 1
s//\n\cH\1\n\cM\2/
s/\cH0\n/\cH\n/

s/,\s*"value"\s*:\s*(-?[0-9]+)$/\n\cV\1/

:n2h
s/[0-9]/@&/g
s/0//g
s/1/#/g
s/2/##/g
s/3/###/g
s/4/####/g
s/5/#####/g
s/6/######/g
s/7/#######/g
s/8/########/g
s/9/#########/g
:tens; s/#@/@##########/g; t tens
s/@//g

s/\n\cV//

:subm0; s/#-#/-/; t subm0

:modh0; s/(\cH-?)#{24}/\1/; t modh0
/\cH-/ {
    s//\cH########################-/
    :subh0; s/#-#/-/; t subh0
    s/-//
}

s/\cH#+/&*####################/
s/\*(#{20})/*\1\1\1/
s/\cH-?/&@/

:mulh
s/@(#+)\*(#+)#\n/\1@\1*\2\n/; t mulh
s/\*#//
s/@//

s/\cH(-?#*)\n\cM(-?#*)$/\cH\n\cM\1\2/
/\cM#+-/ {
    :subm1; s/#-#/-/; t subm1
    s/-$//
}
s/#-/#/

s/\cH\n\cM(-)?(#{60,})$/\cH\1@\2\n\cM\2/
s/\cH\n\cM(-)?(#{1,59})$/\cH\1@\2\n\cM\1\2/
:divm; s/@#{60}/#@/; t divm
s/\cH-@/\cH-/
s/(\cH-#+)@#+\n\cM/\1#\n\cM-/
s/@#*//

:modh; s/(\cH-?)#{24}/\1/; t modh
/\cH-/ {
    s//\cH########################-/
    :subh; s/#-#/-/; t subh
    s/-//
}

:modm; s/(\cM-?)#{60}/\1/; t modm
/\cM-/ {
    s//\cM####################/
    s/\cM(#{20})/\cM\1\1\1-/
    :subm2; s/#-#/-/; t subm2
    s/-//
}

:h2n
s/##########/@/g
s/@([0-9]*)([^0-9#@]|$)/@0\1\2/g
s/#########/9/g
s/########/8/g
s/#######/7/g
s/######/6/g
s/#####/5/g
s/####/4/g
s/###/3/g
s/##/2/g
s/#/1/g
s/@/#/g
t h2n

s/^\n\cH//
s/\n\cM/:/
s/^\cH//g
s/^[0-9]:/0&/
s/:([0-9])$/:0\1/
s/:$/:00/
s/^:/00:/
s/^24/00/

x
/"property"\s*:\s*"equal"/ b proc
/^[0-9]{2}:[0-9]{2}$/ {
    G
    /^(.*)\n\1$/ c true
    c false
}
x
