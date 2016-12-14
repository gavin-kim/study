#!/bin/tcsh

alias sql 'sqlplus -S s6_130/7484@aces'

while (1 == 1)
        clear
        cat menu.txt
        echo -n " Enter your option here: "
        set option = $<
        switch ( $option )
            case [aA]:
               sql @a.sql 
               breaksw
            case [bB]:
               sql @b.sql
               breaksw
            case [cC]:
               sql @c.sql 
               breaksw
            case [dD]:
               sql @d.sql
               breaksw
            case [eE]:
               sql @e.sql 
               breaksw
            case [fF]:
               sql @f.sql
               breaksw
            case [gG]
               sql @g.sql
               breaksw
            case [hH]
               sql @h.sql
               breaksw
            case [iI]:
               sql @i.sql 
               breaksw
            case [jJ]:
               sql @j.sql
               breaksw
            case [kK]:
               sql @k.sql 
               breaksw
            case [lL]:
               sql @l.sql
               breaksw
            case [qQxX]:
               echo
               exit
               breaksw
            case *:
               echo "Invalid Option, please try again"
               breaksw
        endsw
        echo
        echo "Press any key to continue .....\c"
        set dummy = $<
end

