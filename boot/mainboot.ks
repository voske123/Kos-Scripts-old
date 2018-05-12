// open terminal
core:doevent ("open terminal").

// wait til loaded
wait until ship:unpacked and ship:loaded.

//set ship pilotcontrol throttle to 0 to avoid troubles
set ship:control:pilotmainthrottle to 0.

//check if boot has been copied over.
copypath ("0:/library/boot.ks", "1:/boot.ks" ). 

//running bootscript
run boot.ks.

print "boot completed.".
