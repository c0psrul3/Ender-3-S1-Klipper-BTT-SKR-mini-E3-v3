====================
Stepper Motor Wiring
====================

Including Conventions with Examples


*******************************************************************************


## Creality Stepper motor "42-34"  (our example in this document)

### Motor Diagram:

    [!img:./resources/Creality_42-34_Stepper_Motor_Specs.jpg]

### Motor Specifications:

    > Step angle: 1.8 degrees
    > Steps: 200
    > Rated Voltage: 3.3V DC
    > Rated Current: 1.5A
    > Rated speed: 1-1000rpm
    > Rated torque: 0.4NM
    > Ambient Temperature: -20 - 50℃
    > Length: 34mm
    > Weight: 275g
    > Coils: 2
    > Phase Resistance: 2.2 ohm +- 10% (20 degrees Celsius)
    > Phase Inductance: 3.8mH +- 20% (1khz 1V rms)
    > Motor Inertia: 57g. cm^2

### Motor Coil Internal Wiring:

    Fig 1.a
    ```
     1 (A) -----,      ___
                 )    /   \
                 )   ( (M) )
     3 (C) -----`     \___/
              
                     ╭╮╭╮╭╮
                     |    |
                     |    |
                    (B)  (D)
                     4    2
    ```

### Motor Input Connector Diagram (JST-PH 2.0mm):

    Fig 1.b
    ```
    ┌────────────────────┐
    │                    │
    │  1  2  3  4  5  6  │
    └───┬─┬────────┬─┬───┘

      (A)   (C)(B)   (D)

    ```

    NOTE:  above 'JST-PH' connector (Fig 1.b) is common on stepper motors and
           correspond to labels in above coil wiring diagram (Fig 1.a)


### Coil Exciting Sequence:
               _____________________________    
    Direction  | STEP  | A  | B  | C  | D  |  Direction
        ↓      |:-----:|:--:|:--:|:--:|:--:|      ↑
        ↓      |  1    | +  | +  | -  | -  |      ↑
        ↓      |  2    | -  | +  | +  | -  |      ↑
        ↓      |  3    | -  | -  | +  | +  |      ↑
        ↓      |  4    | +  | -  | -  | +  |      ↑
       CW      |_______|____|____|____|____|     CCW


### Motor Output Connector (ex: Octopus, SKR):

    ```
    JST-XH  2.54mm connector

           2B  2A  1A  1B
        ┌─────────────────┐
        │                 │
        │  ▢   O   O   O  │
        │                 │
        └──┬─┬───────┬─┬──┘

    PIN   (1) (2) (3) (4)

    ```


### Motor Input connector (6-pin) - cable side, facing female pins

    JST-PH  2.0mm connector - [specifications](../resources/JST-PH-connector-datasheet.pdf)

    NOTE: this is the connector on the wire side (not the connector found on the motor itself)
    ```
              COIL #2           COIL #1
          _____________    _________________

           BLK       BLU  GRN       RED
            │    NC   │    │    NC   │
            │    │    │    │    │    │
            │    │    │    │    │    │
        ┌──┬─┴────┴────┴────┴────┴────┴─┬───┬┐
        │  │                            │   ││
        │  │                            │   ││
        │  │                            │   ││
        │  └────────────────────────────┘   ││
        │                                   ││
        ├───┬─┬──┬─┬──┬─┬──┬─┬──┬─┬──┬─┬────┼│
        │   └─┘  └─┘  └─┘  └─┘  └─┘  └─┘    ││
        │                                   ││
        ├───────────────────────────────────┼│
        └────────────────────────────────────┘

    PIN     (6)  (5)  (4)  (3)  (2)  (1) 

    ```


## Motor Control Wiring Diagram (with color-coded wires)

  #### Conventions:

    * 1/2 indicates which motor coil
    * A/B indicates Neg(-) or Pos(+)
    * Wire Color is arbitrary but follows conventions described in linked additional reference[^1]

    -------------------------------------------------------------------------------------------
    | Controller |  Wire   |  Motor |  Coil     |   Wire   |  Motor   |  Motor |  Multimeter  |
    |  Pinout    |  Color  |  Coil  |  Polarity |   Color  |  Input   |  Coil  |  Continuity  |
    |:----------:|:-------:|:------:|:---------:|:--------:|:--------:|:------:|:------------:|
    |            |         |        |           |          |          |        |______________|
    |    2B  >---┼---RED---┼-- #2 --┼--- (+) ---┼---RED----┼--- (1) --┼----8)  |              |
    |            |         |        |           |          |          |    (   | 1-3  (BEEP!) |
    |    2A  >---┼---BLU---┼-- #2 --┼--- (-) ---╳---GRN----┼--- (3) --┼----8)  |______________|
    |    1A  >---┼---GRN---┼-- #1 --┼--- (-) ---╳---BLU----┼--- (4) --┼----8)  |              |
    |            |         |        |           |          |          |    (   | 4-6  (BEEP!) |
    |    1B  >---┼---BLK---┼-- #1 --┼--- (+) ---┼---BLK----┼--- (6) --┼----8)  |______________|
    |            |         |        |           |          |          |        |              |
    |____________|_________|________|___________|__________|__________|________|______________|

    Legend: X   cross wiring
            8)  motor coil


## Explanation

    When testing continuity on motor input pins, you will find continuity between each of the pos/neg pins for each of the coils.
    This way you can verify your wiring from the controller's pinout is mostly correct, at least for each of the coils.
    Consult your motor's specifications for exactly what polarity is expected.


### If your motor is moving the wrong direction

    It actually does matter which coil is which and what the polarity of the coils are. However, if they're wrong, the motor just turns the wrong way, 
    Switching the polarity of either (one) coil, like swapping motor input pins 1/4 (RED/BLUE)  or 3/6 (GREEN/BLACK)
    Motor direction can also be reversed in the firmware, so keep this in mind before possibly destroying your cable or connector.


## Additional References

[^1]: [Explanation of stepper motor wiring](https://caggius.wordpress.com/stepper-motor-wiring-conventions/)
[^2]: [Make 'n' Print - Stepper Motor Wiring](https://www.makenprint.uk/3d-printing/3d-printing-guides/3d-printer-mainboard-installation-guides/btt-skr-mini-e3-v3-guides/btt-skr-mini-e3-v3-setup-guide/#steppermotorwiring)
[^3]: [Reddit - Don't fry your mainboard with inappropriately wired X2.54 stepper motor connectors!](https://www.reddit.com/r/ender3/comments/dgunne/dont_fry_your_mainboard_with_inappropriately/)



