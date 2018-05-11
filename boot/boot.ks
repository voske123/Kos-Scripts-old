core:doevent ("open terminal").
Clearscreen.
print "boot completed.".
wait until SHIP:UNPACKED and SHIP:LOADED.

if HOMECONNECTION:ISCONNECTED {
  COPYPATH("0:/missions/"+SHIPNAME+".ks", "1:/mission.ks").
}
run mission.ks.





