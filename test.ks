// script to adjust the inclination of my orbit.




function adjust_inclination {
  
  parameter desired_inclination is 190.
  
  global lock current_inclination to ship:orbit:inclination.
  global target_inclination_check to false.

  lock normal to -vcrs(ship:velocity:orbit, body:position).
  lock antinormal to vcrs(ship:velocity:orbit, body:position).

  function print_parameters{
    print "current inclination: " + round(current_inclination) at (0,10).
    print "desired inclination: " + round(desired_inclination) at (0,11).
    print "inclination check  : " + target_inclination_check   at (0,12).
  }
  
  if desired_inclination < 180 {
    lock steering to normal.
    print_parameters().
    wait until vang(normal, ship:facing:vector).

  } else if desired_inclination > 180 {
    lock steering to antinormal.
    print_parameters().
    wait until vang(antinormal, ship:facing:vector).
  }


  
  if target_inclination_check = false {
    print_parameters().
  }


wait 100.
  

}

adjust_inclination(140).

