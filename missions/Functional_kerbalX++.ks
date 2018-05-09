  parameter target_heading is 90.
  parameter target_altitude is 100000.

function main {
  startup().
  countdown().
  ignition().
  liftoff().
  gravity_turn().
  maintain_apo().
  circularize().
  finish().
}

function utilities {
  if ship:altitude > 70000 {
    ag1 on.

  } else if ship:altitude < 70000 {
    ag1 off.

  }
}

function startup {
  clearscreen.
  print "test script running.".
  set ship:control:pilotmainthrottle to 0.
}

function countdown {
  clearscreen.
  wait 0.1.
  FROM {local x is 5.} UNTIL x = 0 STEP {set x to x-1.} DO {
  print "T -" + x.
  wait 1.
  }
}

function do_stage {
  if stage:ready{
    stage.
  }
}

function data_print {
  print "Pitch:         "  + round(90-vang(ship:up:vector, ship:facing:vector), 1)     + " "  at      (1,1).
  print "Target_pitch:  "  + round(target_pitch, 1)                                    + " "  at      (1,2). 
  print "Altitude:      "  + round(ship:altitude)                                      + " "  at      (1,3).
  print "Apoapsis:      "  + round(apoapsis)                                           + " "  at      (1,4).
  print "Periapsis:     "  + round(periapsis)                                          + " "  at      (1,5).
  print "Eta:apoapsis:  "  + round(eta:apoapsis)                                       + " "  at      (1,6).
}

function list_engines {
  
  LIST ENGINES IN ENGlist.
    
  FOR eng IN ENGlist {
      
    if eng:flameout {
      do_stage().
      print "stage." at (1,1).
    }
  }
}

function ignition {
  if ship:altitude < 500 and ship:velocity:surface:mag < 0.1 {
    lock throttle to 1. 
    do_stage(). 
    print "Ignition!".  
    wait 1.
  }
}

function liftoff {
  if ship:altitude < 500 and ship:velocity:surface:mag < 0.1 {
    lock throttle to 1.
    do_stage().
    print "Liftoff!".
    wait 1.
    clearscreen.
  }
}.

function gravity_turn {
  until ship:apoapsis > target_altitude {
    list_engines(). 
    lock throttle to 1.
    lock target_pitch to 90-90*(ship:altitude/40000)^0.5.
    lock steering to heading(target_heading, target_pitch).
    if ship:altitude > 60000 {
      do_stage().
    }
    data_print().  
  }   
  
  lock throttle to 0.
  wait 1.

}.

function maintain_apo {
  until ship:altitude > 71000 {
    
    list_engines(). 

      until apoapsis > target_altitude {
      lock target_pitch to 0.
      lock steering to heading(target_heading,target_pitch).
      lock throttle to 1.
      utilities().
      data_print().

    }
    
    lock throttle to 0.
    wait 1.

  } 
}

function circularize {
 
  wait until eta:apoapsis < 5.
  
  until periapsis > target_altitude {

    lock target_pitch to 0.
    lock steering to heading(target_heading,target_pitch).
    lock throttle to 1.
    data_print().
    }  
  
  lock throttle to 0.

}

function finish {
  clearscreen.
  lock throttle to 0.
  wait 1.
  print "Orbit reached" at (1,1).
  print "Apoapsis :      "  + round(apoapsis)   + " "  at      (1,2).
  print "Periapsis:      "  + round(periapsis)  + " "  at      (1,3).
}

main().