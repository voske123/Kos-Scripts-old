core:doevent ("open terminal").
Clearscreen.
print "boot completed.".
wait until SHIP:UNPACKED and SHIP:LOADED.
clearscreen.

copypath ("0:/library/orbit_change.ks", "1:/orbit_change.ks" ).
copypath ("0:/missions/test.ks", "1:/test.ks").

list.
wait 1.
clearscreen.

//run test.