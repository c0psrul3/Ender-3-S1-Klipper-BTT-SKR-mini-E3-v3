
# E3D Hemera XS Revo

## General info

  ### Revo Hemera XS Documentation
  (https://e3d-online.zendesk.com/hc/en-us/articles/6453846673821-Revo-Hemera-XS-Documentation-)



  Summary
  + Drive type: dual drive with adjustable tension idler
  + Max printing temperature: 300°C
  + Mass: 256.25g (including Revo hotside)
  + Max pushing force: 120N (depending on filament)
  + DIRECT DRIVE DIMENSIONS
  + Flow rate: 600mm³/min (depending on filament)
  + Nominal steps per mm (x16): 397
    + steps_per_mm: 397
    + full_steps_per_rotation: 200
    + microsteps: 16
    + rotation_distance = 200 * 16 / 397 = 8

  + Max motor current 1.4A
  + Filament diameter: 1.75mm

  + Maximum nominal volumetric throughput: 600mm³/min (PLA at 220°C)


  CONNECTIONS
  + Fan: Dupont 0.1”
  + Heater: Molex Micro-Fit 3.0, 2 pin horizontal
  + Temperature sensor: Molex Micro-Fit 3.0, 2 pin horizontal
  + Assembly is supplied with 1m cables to connect to mainboard

  SERVICE TEMPERATURES
  + Note, these are max ambient service temperatures of the components used,
  + and not a guaranteed operating temperature of the system
  + Fan: 50°C
  + Motor: 85°C
  + Polymer bushing: 90°C
  + Bearings: 100°C
  + Acetal idler components: 120°C

  + Initial Resistance of a 24V heater at 23°C: 14.4Ω
  + Temp Coefficient of HeaterCore: 0.002078
  + Temp Coefficient of Heater Cartridge: 0.002078

  Fan Specification (Direct)
  + Width: 40mm
  + Depth: 10mm
  + Cable: 1000mm
  + Voltage: 12VDC and 24VDC
  + Current: 0.08A (12V) and 0.04A (24V)
  + RPMS: 7500±10% (12V) and 6900±10% (24V)
  + Speed: 7000RPM
  + Connector: Dupont 0.1”
  + Startup voltage: 6 VDC (12V) and 12VDC (24V)Airflow: 6.8 CFM
  + Static Pressure: 4.55 mmH20
  + Noise level: 33.6 dBA
  + Weight: 14g

  Motor Specification & Diagrams
  + Motor cable length: 1000mm
  + Phase no: 2 phases
  + Rated voltage per phase: 3.22V
  + Recommended Current: 1.40A Peak (~0.99A RMS)
  + Resistance: 2.3Ω per phase
  + Inductance: 2.5mH
  + Holding torque: 180mNm
  + Detent torque: 10mNm
  + Rotate direction: ABĀB̅ CW
  + Insulation class: Class B
  + Rotor inertia: 24.3gcm²
  + Connector: JST - 56B - PH
  + Step angle: 1.8°
  + Motor mass: 160g


  #### Revo Nozzle Maximum Flow Rates 
  (https://e3d-online.zendesk.com/hc/en-us/articles/6467176228253-Revo-Nozzle-Maximum-Flow-Rates-)

  |:----------:|:-------------------:|:------------------------------:|
  |            |                     |                                |
  | Nozzle     |  Filament, Temp(C)  |  Volumetric Flow Rate (mm3/s)  |
  |            |                     |                                |
  |:----------:|:-------------------:|:------------------------------:|
  | 0.4 Brass  |  PLA  220           |  13                            |
  |            |  PETG 240           |  17                            |
  |            |  ASA  260           |  15                            |
  |:----------:|:-------------------:|:------------------------------:|
  | 0.6 Brass  |  PLA  220           |  14                            |
  |            |  PETG 240           |  18                            |
  |            |  ASA  260           |  16                            |
  |:----------:|:-------------------:|:------------------------------:|
  | 0.8 Brass  |  PLA  220           |  17                            |
  |            |  PETG 240           |  20                            |
  |            |  ASA  260           |  17                            |
  |:----------:|:-------------------:|:------------------------------:|
  
  + Factors that can affect volumetric flow rate:
    + Extruder force can become a limiting factor, as the flow rate increases
      the force required to extrude increases. Not all extruders will be able
      to achieve the same flow as the Hemera XS.
    + Layer height. As layer height decreases, the shear load increases. This
      then increases the back pressure experienced by the extruder.
    + Line width. Increasing line width also increases the shear load, however,
      it was found that prints with a larger line width performed better than
      prints with the standard line width, provided they were printed at the
      same volumetric flow rate. This is because under extrusion has a greater
      effect on prints with thin walls.
    + Print Temperature. As temperature increases viscosity decreases. The
      temperatures have been kept within the normal printing ranges as
      exceeding the recommended temperatures reduces the polymer's structural
      properties. Printing outside of the recommended temperatures can also
      potentially result in the production of toxic fumes.

 

## Setup

  ### Revo Hemera XS Assembly Guide 
  (https://e3d-online.zendesk.com/hc/en-us/articles/4984720792349-Revo-Hemera-XS-Assembly-Guide)


  ### Mounting Hemera XS
  (https://e3d-online.zendesk.com/hc/en-us/articles/4798448268701-Hemera-XS-motor-swap-guide#h_01G111X6BNV8AXJJS2G6700H2G)
  
    + A note on Idler tension:
    Remember to adjust the idler tension so that the white spring block is flush with the front face of the idler.
    ![Idler_adjustment.svg](https://e3d-online.zendesk.com/hc/article_attachments/4931366811805/Idler_adjustment.svg)
  
  
  ### E Steps per mm Calibration
  (https://e3d-online.zendesk.com/hc/en-us/articles/4413621225489-Revo-Hemera-E-Steps-per-mm-Calibration)
  
    + see also: [Klipper Docs - Rotation distance](https://www.klipper3d.org/Rotation_Distance.html)


  ### Revo Hemera XS Datasheet
  (https://e3d-online.com/pages/hemera-xs-datasheet)

  ### Revo Hemera Max Temperature Guide
  (https://e3d-online.zendesk.com/hc/en-us/articles/4408846677777-Revo-Hemera-Max-Temperature-Guide)
    + Up to 300C

  ### Filament Starter Settings
  (https://e3d-online.zendesk.com/hc/en-us/articles/4777443097757-Filament-Starter-Settings)


  ### Revo Hemera RepRap Firmware Guide
  (https://e3d-online.zendesk.com/hc/en-us/articles/4409935560081-Revo-Hemera-RepRap-Firmware-Guide)
    + Revo temp sensor type: "ATC Semitec 104NT-4-R025H42G"

## Other

  ###  Revo Hemera XS Reference CAD 
  (https://e3d-online.zendesk.com/hc/en-us/articles/4434692051357-Revo-Hemera-XS-Reference-CAD)

  ###  Revo Reference Hemera CAD 
  (https://e3d-online.zendesk.com/hc/en-us/articles/4413023524497-Revo-Reference-Hemera-CAD)
