//script to create a transfer that u can setup by just entering parameters. (apoapsis, periapsis, inclination)

function orbit_change {
  parameter target_apoapsis.
  parameter target_periapsis.
  parameter target_inclination.

  set target_apoapsis_control to false.
  set target_periapsis_control to false.
  set target_inclination_control to false.

  set diff_inclination to round(target_inclination - ship:orbit:inclination).
  lock abs_diff_inclination to abs(diff_inclination).
  set diff_apoapsis to round(target_apoapsis - ship:apoapsis).
  set diff_periapsis to round(target_periapsis - ship:apoapsis).
  
  lock normal to -vcrs(ship:velocity:orbit, body:position).
  lock antinormal to vcrs(ship:velocity:orbit, body:position).

    print " target apo: " + "   " + target_apoapsis               + ".   "    at (0,10).
    print " cur apo:    " + "   " + round(ship:apoapsis)          + ".   "    at (0,11).
    print " dif apo:    " + "   " + diff_apoapsis                 + ".   "    at (0,12).
    print " target per: " + "   " + target_periapsis              + ".   "    at (0,13).
    print " cur per:    " + "   " + round(ship:periapsis)         + ".   "    at (0,14).
    print " dif per:    " + "   " + diff_periapsis                + ".   "    at (0,15).
    print " target inc: " + "   " + target_inclination            + ".   "    at (0,16).
    print " cur inc:    " + "   " + round(ship:orbit:inclination) + ".   "    at (0,17).
    print " dif inc:    " + "   " + diff_inclination              + ".   "    at (0,18).
    print " abs dif:    " + "   " + abs(diff_inclination)         + ".   "    at (0,19).
    print " apo check:  " + "   " + target_apoapsis_control       + ".   "    at (0,20).
    print " per check:  " + "   " + target_periapsis_control      + ".   "    at (0,21).
    print " inc check:  " + "   " + target_inclination_control    + ".   "    at (0,22).
  

  when diff_apoapsis < 100 then {
    set target_apoapsis_control to true.
  }
  when diff_periapsis < 100 then {
    set target_periapsis_control to true.
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
        
          print " target apo: " + "   " + target_apoapsis               + ".   "    at (0,10).
          print " cur apo:    " + "   " + round(ship:apoapsis)          + ".   "    at (0,11).
          print " dif apo:    " + "   " + diff_apoapsis                 + ".   "    at (0,12).
          print " target per: " + "   " + target_periapsis              + ".   "    at (0,13).
          print " cur per:    " + "   " + round(ship:periapsis)         + ".   "    at (0,14).
          print " dif per:    " + "   " + diff_periapsis                + ".   "    at (0,15).
          print " target inc: " + "   " + target_inclination            + ".   "    at (0,16).
          print " cur inc:    " + "   " + round(ship:orbit:inclination) + ".   "    at (0,17).
          print " dif inc:    " + "   " + diff_inclination              + ".   "    at (0,18).
          print " abs dif:    " + "   " + abs(diff_inclination)         + ".   "    at (0,19).
          print " apo check:  " + "   " + target_apoapsis_control       + ".   "    at (0,20).
          print " per check:  " + "   " + target_periapsis_control      + ".   "    at (0,21).
          print " inc check:  " + "   " + target_inclination_control    + ".   "    at (0,22).

          until ship:orbit:inclination > abs_diff_inclination {
            lock throttle to 1.
            print " target apo: " + "   " + target_apoapsis               + ".   "    at (0,10).
            print " cur apo:    " + "   " + round(ship:apoapsis)          + ".   "    at (0,11).
            print " dif apo:    " + "   " + diff_apoapsis                 + ".   "    at (0,12).
            print " target per: " + "   " + target_periapsis              + ".   "    at (0,13).
            print " cur per:    " + "   " + round(ship:periapsis)         + ".   "    at (0,14).
            print " dif per:    " + "   " + diff_periapsis                + ".   "    at (0,15).
            print " target inc: " + "   " + target_inclination            + ".   "    at (0,16).
            print " cur inc:    " + "   " + round(ship:orbit:inclination) + ".   "    at (0,17).
            print " dif inc:    " + "   " + diff_inclination              + ".   "    at (0,18).
            print " abs dif:    " + "   " + abs(diff_inclination)         + ".   "    at (0,19).
            print " apo check:  " + "   " + target_apoapsis_control       + ".   "    at (0,20).
            print " per check:  " + "   " + target_periapsis_control      + ".   "    at (0,21).
            print " inc check:  " + "   " + target_inclination_control    + ".   "    at (0,22).
          }
          print "burn complete.".
          set target_inclination_control to true.
          print "Inclination reached".
          print " inc check:  " + "   " + target_inclination_control    + ".   "    at (0,22).
        }    
       
      

           


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
  

  
  





  if target_apoapsis_control = true and target_inclination_control = true and target_periapsis_control = true {
    wait 2.
    clearscreen.
    print "New orbit achieved".
  }
}