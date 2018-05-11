//script to create a transfer that u can setup by just entering parameters. (apoapsis, periapsis, inclination)

function node_create {
  parameter target_apoapsis.
  parameter target_periapsis.
  parameter target_inclination.

  set target_apoapsis_control to false.
  set target_periapsis_control to false.
  set target_inclination_control to false.

  lock diff_inclination to round(target_inclination - ship:orbit:inclination).
  lock diff_apoapsis to round(target_apoapsis - ship:apoapsis).
  lock diff_periapsis to round(target_periapsis - ship:apoapsis).
  
  set normal to vcrs(ship:velocity:orbit, body:position).
  set antinormal to -vcrs(ship:velocity:orbit, body:position).

  print " target apo: " + target_apoapsis                   at (0,10).
  print " cur apo:    " + round(ship:apoapsis)              at (0,11).
  print " dif apo:    " + diff_apoapsis                     at (0,12).
  print " target per: " + target_periapsis                  at (0,13).
  print " cur per:    " + round(ship:periapsis)             at (0,14).
  print " dif per:    " + diff_periapsis                    at (0,15).
  print " target inc: " + target_inclination                at (0,16).
  print " cur inc:    " + round(ship:orbit:inclination)     at (0,17).
  print " apo check:  " + target_apoapsis_control           at (0,18).
  print " per check:  " + target_periapsis_control          at (0,19).
  print " inc check:  " + target_inclination_control        at (0,20).


  when diff_apoapsis < 100 then {
    set target_apoapsis_control to true.
  }
  when diff_periapsis < 100 then {
    set target_periapsis_control to true.
  }
  when diff_inclination < 0.1 then {
    set target_inclination_control to true.
  }
  
  
  if target_inclination_control = false {      
      if diff_inclination > 0 {
        lock steering to normal.
        print "steering to normal".
        wait until vang(normal, ship:facing:vector) < 2.
        print " in position".
        

      } else if diff_inclination < 0 {
        
        lock steering to antinormal.
        print "steering to anti-normal".
        wait until vang(antinormal, ship:facing:vector) < 2.
        print " in position".
        
        
      }

      until target_inclination_control = true {
                lock throttle to 1.
              } 
      print "burn finished".
      


      //lock throttle to 1.

      

      
      lock throttle to 0.

      //calculate deltav needed for inclination change.
      
      
     
   }
  if target_apoapsis_control = false {    
    //calculate deltav needed for apoapsis change.
  }
  if target_periapsis_control = false {
    
    //calculate deltav needed for periapsis change.
  }
  

  //print " burntime:   " + t.
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
    wait 2.
    clearscreen.
    print "New orbit achieved".
  }
}