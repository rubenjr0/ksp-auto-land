PRINT "= Landing".

SET brakeAlt TO MAX(ALT:PERIAPSIS, BODY:RADIUS / 5).
LOCK radar TO SHIP:BOUNDS:BOTTOMALTRADAR.
LOCK size TO SHIP:BOUNDS:SIZE:Z.
LOCK prog TO SHIP:VELOCITY:SURFACE.

LOCK STEERING TO prog.
PRINT "Waiting to kill horizontal speed at " + brakeAlt + "m".
WAIT UNTIL radar <= brakeAlt.

PRINT "Braking Stage".
BRAKES ON.
// STAGE.
IF GROUNDSPEED / AIRSPEED > 0.3 {
    PRINT "Killing horizontal speed".
    WAIT 3.
    LOCK THROTTLE TO 1.
    WAIT UNTIL GROUNDSPEED / AIRSPEED <= 0.3.
    LOCK THROTTLE TO 0.
} ELSE {
    PRINT "No need to kill horizontal speed".
}

PRINT "Preparing burn".
LOCK STEERING TO "KILL".
LOCK STEERING TO prog.

PRINT "Awaiting burn".
WAIT UNTIL (radar - 2 * size) <= (AIRSPEED ^ 2 / (2 * (AVAILABLETHRUST / MASS - BODY:MU / BODY:RADIUS ^ 2))).
LOCK THROTTLE TO (MASS/ AVAILABLETHRUST) * ((BODY:MU / BODY:RADIUS ^ 2) + AIRSPEED ^ 2 / (2 * radar)).
PRINT "FIRING ENGINES".

PRINT "Waiting to deploy shell".
WAIT UNTIL radar <= 50.
LOCK STEERING TO "KILL".
STAGE.
GEAR ON.
LIGHTS ON.
BRAKES OFF.

WAIT UNTIL VERTICALSPEED >= -1.
LOCK THROTTLE TO 1.
STAGE.
AG10 ON.

PRINT "= Landing complete".
