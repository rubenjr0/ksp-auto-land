wait until ship:unpacked.
clearscreen.
print "== TestBed Bootloader ==".

switch to 0.

FROM {LOCAL countdown IS 5.} UNTIL countdown = 0 STEP {SET countdown TO countdown - 1.} DO {
    PRINT countdown.
    WAIT 1.
}

run launch.
run land.
