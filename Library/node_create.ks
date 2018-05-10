//script to create a transfer node that u can setup by just entering parameters. (apoapsis, periapsis, inclination)


function node_create {
  parameter target_apoapsis.
  parameter target_periapsis.
  parameter target_inclination.

  set target_apoapsis_control to false.
  set target_periapsis_control to false.
  set target_inclination_control to false.
  
  if ship:apoapsis = target_apoapsis {
    set target_apoapsis_control to true.
  }
  if ship:periapsis = target_periapsis {
    set target_periapsis_control to true.
  }
  if ship:orbit:inclination = target_inclination {
    set target_inclination_control to true.
  }

  if target_apoapsis_control = false {
    global diff_apoapsis to (target_apoapsis - ship:apoapsis).
  }
  if target_periapsis_control = false {
    global diff_periapsis to (target_periapsis - ship:apoapsis).
  }
  if target_inclination_control = false {
    global diff_inclination to (target_inclination - ship:orbit:inclination).
  }
  print " target apo: " + target_apoapsis.
  print " target per: " + target_periapsis.
  print " target inc: " + target_inclination.
  print " apo check: " + target_apoapsis_control.
  print " per check: " + target_periapsis_control.
  print " inc check: " + target_inclination_control.





  if target_apoapsis_control = true and target_inclination_control = true and target_periapsis_control = true {
    print "Node created and ready to be executed.".

  }
}