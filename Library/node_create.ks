//script to create a transfer node that u can setup by just entering parameters. (apoapsis, periapsis, inclination)


function node_create {
  parameter target_apoapsis.
  parameter target_periapsis.
  parameter target_inclination.

  set target_apoapsis_control to false.
  set target_periapsis_control to false.
  set target_inclination_control to false.
  
  

  if target_apoapsis_control = false {
    set diff_apoapsis to (target_apoapsis - ship:apoapsis).
    //calculate deltav needed for apoapsis change.
  }
  if target_periapsis_control = false {
    set diff_periapsis to (target_periapsis - ship:apoapsis).
    //calculate deltav needed for periapsis change.
  }
  if target_inclination_control = false {
    set diff_inclination to (target_inclination - ship:orbit:inclination).
    //calculate deltav needed for inclination change.

  }

  if diff_apoapsis < 100 {
    set target_apoapsis_control to true.
  }
  if diff_periapsis < 100 {
    set target_periapsis_control to true.
  }
  if diff_inclination < 0.5 {
    set target_inclination_control to true.
  }




  print " target apo: " + target_apoapsis.
  print " cur apo:    " + round(ship:apoapsis).
  print " dif apo:    " + diff_apoapsis.
  print " target per: " + target_periapsis.
  print " cur per:    " + round(ship:periapsis).
  print " dif per:    " + diff_periapsis.
  print " target inc: " + target_inclination.
  print " cur inc:    " + round(ship:orbit:inclination).
  print " apo check: " + target_apoapsis_control.
  print " per check: " + target_periapsis_control.
  print " inc check: " + target_inclination_control.





  if target_apoapsis_control = true and target_inclination_control = true and target_periapsis_control = true {
    add maneuver.
    print "Node created and ready to be executed.".
  }
}