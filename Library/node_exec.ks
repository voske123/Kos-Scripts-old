// node_exec script
clearscreen.

function node_exec{

  local enginelist is LIST().
    list ENGINES in enginelist.
    local count is 0.
    local ispsum is 0.

    for e in enginelist {
      if e:IGNITION {
        set count to count + 1.
        set ispsum to ispsum + e:ISP.        
      }
    }

  local f is SHIP:AVAILABLETHRUST.   // Engine Thrust (kg * m/s²)
  local m is SHIP:MASS.        // Starting mass (kg)
  local e is CONSTANT():E.            // Base of natural log
  local g is 9.82.                 // Gravitational acceleration constant (m/s²)
  local dv is nextnode:deltav:mag. // deltav from the nextnode.
  local isp is ispsum/count.        //isp average


  set t to (m - (m / e^(dv / (isp * g)))) / (f / (isp * g)).

  lock steering to nextnode:burnvector.

  wait until vang(ship:facing:vector, nextnode:burnvector) < 2.

  set node_time to time:seconds + nextnode:eta - (t/2).



  warpto (time:seconds + nextnode:eta - 60).

  wait until time:seconds > node_time.

  set old_vector_mag to nextnode:burnvector:mag + 1.

  lock throttle to nextnode:deltav:mag / (ship:availablethrust / ship:mass).

  wait 0.1.

  //old_vector_mag = nextnode:burnvector:mag
  until old_vector_mag <= nextnode:burnvector:mag {
    set old_vector_mag to nextnode:burnvector:mag.
    wait 0.
  }
      
    
  lock throttle to 0.
  unlock steering.
  wait 1.

  remove nextnode.
  clearscreen.
  print "Node executed.".
   
}