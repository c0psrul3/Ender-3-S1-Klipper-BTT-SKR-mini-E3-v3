# Building and Flashing Klipper to BTT SKR-Mini-E3-v3

----

## Build Firmware

* refer to klipper firmware config file [](./resources/_config_klipper.firmware_build__BIGTREETECH-SKR-mini-E3)

* put config file in `~/klipper/` folder
  ```sh
  mv ./resources/_config_klipper.firmware_build__BIGTREETECH-SKR-mini-E3 \
      pi@mainsail-pi.local:/home/pi/klipper/config.BIGTREETECH-SKR-mini-E3
  ```

* build klipper firmware

    ```sh
    # check configuration
    KCONFIG_CONFIG=config.BIGTREETECH-SKR-mini-E3 make menuconfig
    # build firmware
    KCONFIG_CONFIG=config.BIGTREETECH-SKR-mini-E3 make
    ```

----

## Updating Firmware 

#### Method 1: Attempt to flash with `make`   (WORKS FOR ME)

1. attempt to flash directly with `make flash`
    ```sh
    make flash FLASH_DEVICE=/dev/serial/by-id/...
    ```
2. this may result in error

  ![klipper flash attempt BTT SKR Mini E3 v3](./resources/screenshot.klipper-flash-results.skr-mini-e3v3-stm32g0b1x.png)

3. follow instructions given in output to flash device that may have been successfully put in DFU mode:
    a. check config setting for vendor:device
      ```sh
      awk '/VENDOR/ || /DEVICE/' ~/klipper/.config
      ```
    b. perform flash device, per error message output
      ```sh
      make flash FLASH_DEVICE=0483:df11
      ```


#### Method 2: Attempt to flash with `dfu-util`

NOTE: INCOMPLETE INSTRUCTIONS

  ```sh
  sudo dfu-util --reset --path 3-1.1 --alt 0 --dfuse-address 0x8002000:leave --download "out/klipper.bin"
  ```
  
  ```sh
  sudo dfu-util -p 3-1.1 -R -a 0 -s 0x8002000:leave -D out/klipper.bin
  ```


#### Method 3: using `flash-sdcard.py`

* see [Klipper Docs - SDCard updates](https://www.klipper3d.org/SDCard_Updates.html?h=script)

* using `flash-sdcard.py`  [https://www.reddit.com/r/klippers/comments/17mbkif/flashing_klipper_update_on_skr_mini_e3_v3_over_usb/](https://www.reddit.com/r/klippers/comments/17mbkif/flashing_klipper_update_on_skr_mini_e3_v3_over_usb/)

* general process:
    ```sh
    sudo service klipper stop
    cd ~/klipper
    git pull
    make clean
    make menuconfig
    make
    ./scripts/flash-sdcard.sh /dev/ttyACM0 btt-skr-v1.3
    sudo service klipper start
    ```
 

----

## Other options to try

#### install katapult (canboot)

https://klipper.discourse.group/t/flashing-klipper-bin-to-btt-skr-mini-e3-v3/6841/25?page=2


#### References:

* BTT Wiki for SKR MINI E3 [Firmware Update - HowTo](https://bttwiki.com/SKR%20MINI%20E3.html#firmware-of-motherboard)

* see [dfu-util manpage](https://dfu-util.sourceforge.net/dfu-util.1.html)


* [https://3dprintscape.com/skr-mini-e3-v3-firmware-guide/](https://3dprintscape.com/skr-mini-e3-v3-firmware-guide/)


