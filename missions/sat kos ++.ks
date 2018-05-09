//pre launch
wait 1.
sas off.
print "sas off.".
wait 1.
parameter target_altitude is 100000.
parameter target_heading is 90.
set step to 0.


//copy librarys
copypath("0:/library/circularisation", "1:/circularisation").
copypath("0:/library/node_exec", "1:/node_exec").

//run librarys
run circularisation.
run node_exec.

function do_stage {
  LIST ENGINES IN ENGlist.
  FOR eng IN ENGlist {
  if eng:flameout and stage:ready {
    stage.
    print "stage:" + stage:number at (1,10).
    }
  }
}

when ship:altitude > 70000 then {
  ag1 on.
  wait 0.
  panels on.
  wait 0.
  ag2 on.
  wait 0.
  //rcs on.
}


if step = 0 {
  if ship:altitude < 500 and ship:groundspeed < 1 {
  clearscreen.
  set step to 1.
  set ship:control:pilotmainthrottle to 0.
  print "step: " + step at (0,1).
  } else if ship:altitude > 500 and ship:altitude < 70000 {
    set step to 4.
  } else if ship:altitude > 70000 and not(hasnode){
    set step to 6.
  } else if ship:altitude > 70000 and hasnode { 
    set step to 7.
  }
}
//countdown.

if step = 1 {
  
  wait 0.1.
  FROM {local x is 5.} UNTIL x = 0 STEP {set x to x-1.} DO {
  print "T -" + x at (0,0).
  wait 1.
  }
  set step to step + 1.
  print "step: " + step at (0,2).
}

//ignition

if step = 2 {
  
  wait until stage:ready. 
  stage.
  set step to step + 1.
  print "step: " + step at (0,3).
}

//liftoff

if step = 3 {
  
  lock throttle to 1.
  wait 0.
  wait until stage:ready. 
  stage.
  wait 0.
  set step to step + 1.
  print "step: " + step at (0,4).
}

//gravityturn

if step = 4 {
  until ship:apoapsis > target_altitude {
  lock target_pitch to 90-90*(ship:altitude/50000)^0.5.
  lock steering to heading(target_heading, target_pitch).
  do_stage().
  wait 0.
  }
  lock throttle to 0.
  set step to step + 1.
  print "step: " + step at (0,5).

}

//coasting+maintain

if step = 5 {
  until ship:altitude > 71000 {
    if apoapsis < target_altitude {
    lock target_pitch to 0.
    lock steering to heading(target_heading, target_pitch).
    lock throttle to 1.
    do_stage().
    wait 0.
    }
    lock throttle to 0.
  }
  set stored_apo to apoapsis.
  set step to step + 1.
  print "step: " + step at (0,6).
}

//circularization

if step = 6 {

  circularisation().
  wait 1.
  if hasnode {
    set step to step + 1.
    print "step: " + step at (0,7).
  }
}


//node_exec.

if step = 7 {
  
  node_exec().

  sas on.
  
  wait 1.
  set sasmode to "stabilityassist".

  clearscreen.
  print "Orbit reached, have a nice flight!".
  
}





