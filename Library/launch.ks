// launch script
function launch {
  parameter target_altitude is 100000.
  parameter target_heading is 90.
  sas off.
  wait 1.
  print "sas off".
  set step to 0.

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

    } else if ship:altitude > 70000 {
      set step to 5.
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
    
    }
print "launch finished".
}