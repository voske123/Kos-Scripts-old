clearscreen.

if HOMECONNECTION:ISCONNECTED {
  COPYPATH("0:/missions/"+SHIPNAME+".ks", "1:/mission.ks").
} else {
  wait 10.
  reboot.
}

run mission.ks.





