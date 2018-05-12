// script to adjust the inclination of my orbit.

clearscreen.


function adjust_inclination {
  
  parameter desired_inclination is 190.
  
  lock current_inclination to ship:orbit:inclination.
  set target_inclination_check to false.
  set old_inc to current_inclination.

  lock normal to -vcrs(ship:velocity:orbit, body:position).
  lock antinormal to vcrs(ship:velocity:orbit, body:position).
  

  function print_parameters{
    print "current inclination: " + round(current_inclination) + "  " at (0,10).
    print "desired inclination: " + round(desired_inclination) + "  " at (0,11).
    print "inclination check  : " + target_inclination_check   + "  " at (0,12).
    print "old inclination    : " + old_inc                    + "  " at (0,13).
    
    
  }
  
  if target_inclination_check = false {
    
    
    if desired_inclination < 180 {
      lock steering to normal.
      print_parameters().
      wait until vang(normal, ship:facing:vector).
      


    } else if desired_inclination > 180 {
      lock steering to antinormal.
      print_parameters().
      wait until vang(antinormal, ship:facing:vector).
    }
    
    when old_inc > current_inclination and desired_inclination < 180 then {
      lock throttle to 0.
      wait 0.
      lock steering to antinormal.
      wait until vang(antinormal, ship:facing:vector).
      wait 1.
      lock throttle to 1.
    }
    
    when old_inc > current_inclination and desired_inclination > 180 then {
      lock throttle to 0.
      wait 0.
      lock steering to normal.
      wait until vang(normal, ship:facing:vector).
      wait 1.
      lock throttle to 1.
    }
    
    until current_inclination > desired_inclination {
      lock throttle to 1.
      print_parameters().
      set old_inc to current_inclination.
      wait 1.
    }

    lock throttle to 0.
    set target_inclination_check to true.
    print_parameters().
  }

clearscreen.
print "inclination burn finished with an inclination of " + current_inclination + ".".

wait 100.
  

}

adjust_inclination(10).

