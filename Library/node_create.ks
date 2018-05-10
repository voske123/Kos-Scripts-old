//script to create a transfer node that u can setup by just entering parameters. (apoapsis, periapsis, inclination)

function node_create {
  parameter target_apoapsis.
  parameter target_periapsis.
  parameter target_inclination.
  set target_apoapsis_control to false.
  set target_periapsis_control to false.
  set target_inclination_control to false.
  

  
  print " target apo: " + target_apoapsis.
  print " target per: " + target_periapsis.
  print " target inc: " + target_inclination.




  if target_apoapsis_control = true and target_inclination_control = true and target_periapsis_control = true {
    print "Node created and ready to be executed.".

  }
}