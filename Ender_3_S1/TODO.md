BTT Smart Filament Detector
---------------------------
https://github.com/bigtreetech/smart-filament-detection-module/tree/master


Orbiter Smart Filament Detector
-------------------------------

* FIX Macro: filament load
* FIX Macro: filament unload
* Implement Macro: orbiter filament load with smart sensor button



Start / End PRINT macros
------------------------

```cfg    
    [gcode_macro START_PRINT]
    gcode:
        {% set BED_TEMP = params.BED_TEMP|default(60)|float %}
        {% set EXTRUDER_TEMP = params.EXTRUDER_TEMP|default(210)|float %}
    
        # Start bed heating
        {action_respond_info("Heating Bed...")}
        M140 S{BED_TEMP}
    
        # Use absolute coordinates
        G90
    
        # Reset the G-Code Z offset (adjust Z offset if needed)
        SET_GCODE_OFFSET Z=0.0
    
        # Home the printer while we wait on the bed to heat up
        G28
    
        M190 S{BED_TEMP} # Wait for bed to reach temperature
        BED_MESH_CALIBRATE
        BED_MESH_PROFILE LOAD=default
    
        SMART_PARK
    
        M109 S{EXTRUDER_TEMP} # Set and wait for nozzle to reach temperature
    
        LINE_PURGE
    
    [gcode_macro END_PRINT]
    gcode:
        # Turn off bed, extruder, and fan
        M140 S0
        M104 S0
        M106 S0
        # Move nozzle away from print while retracting
        G91
        G1 X-2 Y-2 E-3 F300
        G1 Z50 F3000 # Raise nozzle
        G90 #Absolute positioning
        G1 X0 Y230 #Present print
    
```

