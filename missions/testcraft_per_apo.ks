// script for adjusting periapsis and apoapsis

function adjust_per {
  
  parameter desired_per is ship:periapsis.

  set periapsis_check to false.
  set check_prog to false.
  set check_retro to false.
  set steering_vector to ship:facing:topvector.
  set throt to 0.

  lock steering to lookdirup(steering_vector, ship:facing:topvector).
  lock current_per to ship:periapsis.
  lock throttle to throt.

  print "desired_per:    " + desired_per + "     ".
  print "current_per:    " + current_per + "     ".
  print "periapsis_check: " + periapsis_check + "     ".

  wait 1.
  if (current_per < (desired_per + 500)) and (current_per > (desired_per - 500)) {
    set periapsis_check to true.
  }

  if not(periapsis_check) {
 
    if current_per < desired_per {
      set check_prog to true.
      print "check_prog " + check_prog.
    }
    
    if current_per > desired_per {
      set check_retro to true.
      print "check_retro " + check_retro.
    }
    

    if check_retro {
      warpto(time:seconds + eta:apoapsis - 30).
      wait until ship:unpacked.
      
      until vang(ship:retrograde:vector, ship:facing:forevector) < 2 {
        set steering_vector to ship:retrograde:vector.
      }
      print "ship ready for burn to retrograde.".
      
      wait until eta:apoapsis < 5.

      

      until periapsis_check {
        print "commencing per burn" at (0,20).

        set throt to 1.

        print "throt to 1." at (0,21).

        set steering_vector to ship:retrograde:vector.

        print "current per: " + ship:periapsis at (0,10).

        if current_per < desired_per {
          set periapsis_check to true.
          set throt to 0.
        }

        wait 0.
      }  

    } else if check_prog {
      warpto(time:seconds + eta:apoapsis - 30).
      wait until ship:unpacked.
      
      until vang(ship:prograde:vector, ship:facing:forevector) < 2 {
        set steering_vector to ship:prograde:vector.
      }
      print "ship ready for burn to prograde.".
      
      wait until eta:apoapsis < 5.
      

      until periapsis_check {
        print "commencing per burn" at (0,20).

        set throt to 1.

        print "throt to 1." at (0,21).
    
        set steering_vector to ship:prograde:vector.
        
        print "current per: " + ship:periapsis at (0,10).

        if current_per > desired_per {
        set periapsis_check to true.
        set throt to 0.
      }
      wait 0.
      }
    }

    set throt to 0. 
  }

  if periapsis_check {
    print "periapsis reached!".
  }
}

function adjust_apo {
  
  parameter desired_apo is ship:apoapsis.

  set apoapsis_check to false.
  set check_prog to false.
  set check_retro to false.
  set steering_vector to ship:facing:topvector.
  set throt to 0.

  lock steering to lookdirup(steering_vector, ship:facing:topvector).
  lock current_apo to ship:apoapsis.
  lock throttle to throt.
  

  print "desired_apo:    " + desired_apo + "     ".
  print "current_apo:    " + current_apo + "     ".
  print "apoapsis_check: " + apoapsis_check + "     ".

  wait 1.
  if (current_apo < (desired_apo + 500)) and (current_apo > (desired_apo - 500)) {
    set apoapsis_check to true.
  }

  if not(apoapsis_check) {
   
    if current_apo < desired_apo {
      set check_prog to true.
      print "check_prog " + check_prog.
    }
    if current_apo > desired_apo {
      set check_retro to true.
      print "check_retro " + check_retro.
    }
    

    if check_retro {
      warpto(time:seconds + eta:periapsis - 30).
      wait until ship:unpacked.

      until vang(ship:retrograde:vector, ship:facing:forevector) < 2 {
        set steering_vector to ship:retrograde:vector.
      }
      print "ship ready for burn to retrograde.".
      
      wait until eta:periapsis < 5.

      
      
      until apoapsis_check {
        print "commencing per burn" at (0,20).

        set throt to 1.

        print "throt to 1." at (0,21).

        set steering_vector to ship:retrograde:vector.

        print "current apo: " + ship:apoapsis at (0,10).
        if current_apo < desired_apo {
          set apoapsis_check to true.
          set throt to 0.
        }
        wait 0.
      }  
    } else if check_prog {
      
      warpto(time:seconds + eta:periapsis - 30).
      wait until ship:unpacked.

      until vang(ship:prograde:vector, ship:facing:forevector) < 2 {
        set steering_vector to ship:prograde:vector.
      }
      print "ship ready for burn to prograde.".

      wait until eta:periapsis < 5. 

      print "test.".
      
      until apoapsis_check {
        print "commencing per burn" at (0,20).

        set throt to 1.

        print "throt to 1." at (0,21).

        set steering_vector to ship:prograde:vector.
        print "current apo: " + ship:apoapsis at (0,10).
        
        if current_apo > desired_apo {
          set apoapsis_check to true.
          lock throttle to 0.
        }
      wait 0.
      }
    }

    set throt to 0. 
  }
  if apoapsis_check {
    print "apoapsis reached!".
  }
}


function adjust_all {
  parameter desired_apo is ship:apoapsis.
  parameter desired_per is ship:periapsis.

  if desired_apo > desired_per {
    adjust_apo(desired_apo).
    print "apoapsis reached".
    adjust_per(desired_per).
    print "periapsis reached".
  } else {
    adjust_per(desired_per).
    print "periapsis reached".
    adjust_apo(desired_apo).
    print "apoapsis reached".
    
  }

  
}

adjust_all(250000,120000).