// script for adjusting apoapsis

function adjust_apo {
  
  parameter desired_apo is ship:apoapsis.

  set apoapsis_check to false.
  set prog_dir to false.
  set retro_dir to false.
  set check_1 to false.
  set check_2 to false.
  lock current_apo to ship:apoapsis.
  
  lock prog to ship:prograde.
  lock retro to ship:retrograde.

  print "desired_apo:    " + desired_apo + "     ".
  print "current_apo:    " + current_apo + "     ".
  print "apoapsis_check: " + apoapsis_check + "     ".

  wait 1.

  if apoapsis_check = false {
    
    if current_apo - 100 < desired_apo {
      set check_1 to true.
      print "1 " + check_1.
      }
    if current_apo + 100 > desired_apo {
      set check_2 to true.
      print "2 " + check_2.
      }
    

    if check_2 = true {
      lock steering to retro.
      set retro_dir to true.
      until time:seconds > time:seconds + (eta:periapsis -30){
        set kuniverse:timewarp:warp to 100.
      }
      kuniverse:timewarp:cancelwarp().
      
      wait until vang(ship:facing:vector, retro:vector) < 1.
      print "ship ready for burn to retrograde.".

    } else if check_1 = true {
      lock steering to prog.
      set prog_dir to true.
      until time:seconds > time:seconds + (eta:periapsis -30){
        set kuniverse:timewarp:warp to 100.
      }
      kuniverse:timewarp:cancelwarp(). 
      wait until vang(ship:facing:vector, prog:vector) < 1.
      print "ship ready for burn to prograde.".

    }

    until apoapsis_check = true {
      lock throttle to 1.
      print "current apo: " + ship:apoapsis at (0,10).
      if current_apo - 100 < desired_apo and current_apo + 100 > desired_apo {
        set apoapsis_check to true.
      }
      wait 0.

    }

    lock throttle to 0. 
  }

  print "apoapsis reached!".
}

adjust_apo(120000).