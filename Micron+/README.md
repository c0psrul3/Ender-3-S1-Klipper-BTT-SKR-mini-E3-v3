
# [Micron+ 180](https://github.com/PrintersForAnts/Micron/blob/main/R1_Beta/readme.md) setup and configuration

* Configuration and Instructions adopted from [maz0r/klipper_canbus](https://github.com/maz0r/klipper_canbus)


## General Setup

* Configure Systemd Network-Manager for canbus
  [systemd-networkd.md](https://github.com/maz0r/klipper_canbus/blob/main/extras/systemd-networkd.md)


* ToqueCAN uses the same config as BTT-U2C
  [u2c.md](https://github.com/maz0r/klipper_canbus/blob/main/controller/u2c.md)

## Notes on configuring Micron+ kit from Fabreeko
* [HoneyBadger Edge to Edge Heater](https://www.fabreeko.com/products/fabreeko-edge-to-edge-heaters-for-voron-printers?_pos=1&_sid=183997d92&_ss=r&variant=44851221692671)
  > Set klipper to Generic 3950 thermistor type


## BigTreeTech EBB36
[BTT Docs - EBB36](https://github.com/bigtreetech/docs/blob/master/docs/EBB%2036%20CAN.md)

EBB36 V1.2 Pinout
[!img:../resources/EBB36\ CAN\ V1.1\&V1.2-PIN.png]

### Setup instructions followed, as described [here](https://github.com/EricZimmerman/VoronTools/blob/main/EBB_CAN.md)

* make menuconfig for katapult, see [_config.btt-ebb36](./katapult/_config.btt-ebb36)

* flashed with katapult

  ```
  $ sudo dfu-util -a 0 -D ~/katapult/out/katapult.bin --dfuse-address 0x08000000:force:mass-erase:leave -d 0483:df11

  dfu-util 0.9
  
  Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
  Copyright 2010-2016 Tormod Volden and Stefan Schmidt
  This program is Free Software and has ABSOLUTELY NO WARRANTY
  Please report bugs to http://sourceforge.net/p/dfu-util/tickets/
  
  dfu-util: Invalid DFU suffix signature
  dfu-util: A valid DFU suffix will be required in a future dfu-util release!!!
  Opening DFU capable USB device...
  ID 0483:df11
  Run-time device DFU version 011a
  Claiming USB DFU Interface...
  Setting Alternate Setting #0 ...
  Determining device status: state = dfuIDLE, status = 0
  dfuIDLE, continuing
  DFU mode device DFU version 011a
  Device returned transfer size 1024
  DfuSe interface name: "Internal Flash   "
  Performing mass erase, this can take a moment
  Downloading to address = 0x08000000, size = 4484
  Download	[=========================] 100%         4484 bytes
  Download done.
  File downloaded successfully
  dfu-util: Error during download get_status
  ```
  This was SUCCESSFUL

* connect canbus, remove USBV jumper

* query canbus
  ```
  $ sudo service klipper stop
  $ python3 ~/katapult/scripts/flashtool.py -i can0 -q

  Detected UUID: 6c2675e22f42, Application: Katapult
  ```
  notice `Application: Katapult`

  Record the UUID. This is YOUR uuid and will be used for the next step and in your cfg files.

* make menuconfig for klipper, see [_config.btt-ebb36](./klipper/_config.btt-ebb36)

* flash klipper
  Now its time to flash klipper via CAN! Run the following command, substituting your uuid:
  ```
  $ python3 ~/katapult/scripts/flashtool.py -i can0 -u b6d9de35f24f -f ~/klipper/out/klipper.bin

  Sending bootloader jump command...
  Resetting all bootloader node IDs...
  Attempting to connect to bootloader
  Katapult Connected
  Protocol Version: 1.0.0
  Block Size: 64 bytes
  Application Start: 0x8002000
  MCU type: stm32g0b1xx
  Verifying canbus connection
  Flashing '/home/pi/klipper/out/klipper.bin'...

  [##################################################]

  Write complete: 15 pages
  Verifying (block count = 450)...

  [##################################################]

  Verification Complete: SHA = D792AB868BE02E7902A4A9AA4318F1752FF531E8
  Flash Success
  ```
  The EBB will be flashed and you should see a message about success, etc. Request for uuids again via:

* query canbus again
  ```
  $ python3 ~/katapult/scripts/flashtool.py -i can0 -q
  
  Resetting all bootloader node IDs...
  Checking for Katapult nodes...
  Detected UUID: 6c2675e22f42, Application: Klipper
  Query Complete
  ```
  notice `Application: Klipper`




## BTT Octopus MAX

[BTT Docs - Octopus MAX EZ](https://github.com/bigtreetech/docs/blob/master/docs/Octopus%20MAX%20EZ.md)
[BTT Docs - EZ2209](https://github.com/bigtreetech/docs/blob/master/docs/EZ2209.md)

[Klipper Docs - CANBUS](https://www.klipper3d.org/CANBUS.html)

* Octopus Max Pinout
  [!img:../resources/BIGTREETECH\ Octopus\ MAX\ EZ\ V1.0\ PinOut.png]

* Octopus Max Peripheral Layout
  [!img:../resources/Octopus_MAX_EZ_Peripheral.png]

* Stepper and Stuff wiring diagram
  [!img:../resources/octopus-stepper-and-stuff-wiring-diagram.png]

* 120V bed heater wiring
  [!img:../resources/BTTOctopus_Pro-ssr-SPI-wiring.png]

### Fan Control (3/4 pin)
* PWM fans should not use voltage selection jumpers (eg. FAN4,FAN5,FAN6)
  [source reference](https://www.nicksherlock.com/2022/01/driving-a-4-pin-computer-pwm-fan-on-the-btt-octopus-using-klipper/)
  1. remove voltage select jumpers
  2. connect the PWM pin (the “negative” pin of that fan header) to the fan’s PWM input so:
     [!img:../resources/octopus-max-pwm-fan-wiring-diagram.png]
  3. Note that the PWM signal is inverted (i.e. setting 0% fan speed will
     actually give us 100%), so we also need to invert the pin definition to fix
     this by adding a “!” in front of the pin name in Klipper like so:
  4. UNFINISHED

* Noctua Fan pin configurations [reference](https://faqs.noctua.at/en/support/solutions/articles/101000081757)

  [!img:https://s3-eu-central-1.amazonaws.com/euc-cdn.freshdesk.com/data/helpdesk/attachments/production/101038057173/original/Mfx4nDMokYS-xh5_1C_Bx0YWrghK4v-QNg.png?1666086047]


## STLs

* [R1 / BFI Z-Idlers](https://github.com/PrintersForAnts/Micron/tree/main/R1_Beta/STLs/Gantry/Idlers)
* [R1 / X_axis / beacon_probe_mount_x1.stl](https://github.com/PrintersForAnts/Micron/blob/main/R1_Beta/STLs/Gantry/X_Axis/Probes/beacon_probe_mount_x1.stl)

