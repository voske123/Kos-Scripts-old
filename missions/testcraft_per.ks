// script for adjusting periapsis

function adjust_per {
  
  parameter desired_per is ship:periapsis.

  set periapsis_check to false.
  set check_1 to false.
  set check_2 to false.
  lock current_per to ship:periapsis.
  
  lock prog to ship:prograde.
  lock retro to ship:retrograde.

  print "desired_per:    " + desired_per + "     ".
  print "current_per:    " + current_per + "     ".
  print "periapsis_check: " + periapsis_check + "     ".

  wait 1.

  if periapsis_check = false {
    
    if current_per < desired_per {
      set check_1 to true.
      print "1 " + check_1.
      }
    if current_per > desired_per {
      set check_2 to true.
      print "2 " + check_2.
      }
    

    if check_2 = true {
      lock steering to retro.
      until time:seconds > time:seconds + (eta:apoapsis -30){
        set kuniverse:timewarp:warp to 100.
      }
      kuniverse:timewarp:cancelwarp().
      
      wait until vang(ship:facing:vector, retro:vector) < 1.
      print "ship ready for burn to retrograde.".

    } else if check_1 = true {
      lock steering to prog.
      until time:seconds > time:seconds + (eta:apoapsis -30){
        set kuniverse:timewarp:warp to 100.
      }
      kuniverse:timewarp:cancelwarp(). 
      wait until vang(ship:facing:vector, prog:vector) < 1.
      print "ship ready for burn to prograde.".

    }

    until periapsis_check = true {
      lock throttle to 1.
      print "current apo: " + ship:periapsis at (0,10).
      if current_per - 100 < desired_per and current_per + 100 > desired_per {
        set periapsis_check to true.
      }
      wait 0.

    }

    lock throttle to 0. 
  }

  print "periapsis reached!".
}

adjust_per(100000).