

## request reset
  ```sh
  python3 scripts/flash_can.py -r -u 1d8516137409
  ```

## installing Katapult and Klipper firmware


+ check that can0 interface is UP
  ```sh
  pi@mainsail:~/katapult $ ip link
  ...
  8: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1024
      link/can 
  ```

+ query for can devices
  ```sh
  pi@mainsail:~/katapult $ ./scripts/flash_can.py -q
  Resetting all bootloader node IDs...
  Checking for Katapult nodes...
  Detected UUID: 1d8516137409, Application: Katapult
  Query Complete
  ```

+ flash klipper firmware (already compiled)
  ```sh
  pi@mainsail:~/katapult $ ./scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 1d8516137409
  Sending bootloader jump command...
  Resetting all bootloader node IDs...
  Attempting to connect to bootloader
  Katapult Connected
  Protocol Version: 1.0.0
  Block Size: 64 bytes
  Application Start: 0x10004000
  MCU type: rp2040
  Verifying canbus connection
  Flashing '/home/pi/klipper/out/klipper.bin'...
  
  [##################################################]
  
  Write complete: 148 pages
  Verifying (block count = 592)...
  
  [##################################################]
  
  Verification Complete: SHA = BCE9C50128C36EE56A60CEDABF5E6F40CD8E5F05
  Flash Success
  pi@mainsail:~/katapult $ ./scripts/flash_can.py -q
  Resetting all bootloader node IDs...
  Checking for Katapult nodes...
  Detected UUID: 1d8516137409, Application: Klipper
  Query Complete
  ```

+ 
  
