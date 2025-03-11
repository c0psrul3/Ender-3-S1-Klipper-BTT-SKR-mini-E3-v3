
## BTT Octopus MAX
## ---------------
[BTT Wiki - Octopus Max](https://bttwiki.com/Octopus%20MAX%20EZ.html)
1.  flash firmware with `make flash ...`
    ```sh
      make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_stm32h723xx_1E002B001251313236343430-if00
    ```


## LDO Nitehawk 36 USB
[LDO Documentation - Nitehawk-36](https://docs.ldomotors.com/en/Toolboard/nitehawk-36#uploading-klipper-via-make-flash)
1.  flash firmware with `make flash ...`
    ```sh
      make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_rp2040_30333938340AA3E0-if00
    ```



## BTT Eddy USB
## ------------
[BTT Wiki - Eddy](https://bttwiki.com/Eddy.html)
[Klipper Docs - Eddy](https://www.klipper3d.org/Eddy_Probe.html)

1.  Hold down the Boot button, then connect the power supply to enter DFU

2.  flash firmware
    ```sh
      make flash FLASH_DEVICE=2e8a:0003
    ```



## BTT HBB Fe
## ------------
[BTT Wiki - HBB Fe](https://bttwiki.com/HBB.html)

1.  Hold down the Boot button, then connect the power supply to enter DFU

2.  flash firmware
    ```sh
      make flash FLASH_DEVICE=2e8a:0003
    ```

3. find device
    ```sh
    lsusb
    
    > Bus 003 Device 090: ID 0483:df11 STMicroelectronics STM Device in DFU Mode
    ```


## BTT SKR Mini E3 v3
## ------------------
[BTT Wiki - SKR Mini E3 v3](https://bttwiki.com/SKR%20MINI%20E3.html)




##
## Firmware Update - HermitCrab2
##
  ```sh
  cd ~/klipper
  make clean

  cp _config.BTT-HermitCrab2 .config
  make

  cd ../katapult/scripts/
  ./flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 1d8516137409
  ```

##
## Firmware Update - BTT-Eddy-usb
##
  ```sh
  cd ~/klipper
  make clean

  cp _config.BTT-Eddy .config
  make

  make flash FLASH_DEVICE=2e8a:0003
  ```

##
## Firmware Update - BTT-SKR-Mini-E3-v3
##
  ```sh
  cd ~/klipper
  make clean

  cp _config.BTT-SKR-Mini-E3-v3 .config
  make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_stm32g0b1xx_1600120012504B5735313920-if00 
    #
    # NOTE: may output an error

  # check that mcu is in DFU mode
  lsusb | grep DFU
    #
    # expecting:
    # > Bus 003 Device 090: ID 0483:df11 STMicroelectronics STM Device in DFU Mode

  # attempt flash with USB "vendor:device"
  make flash FLASH_DEVICE=0483:df11

  ls -hFl /dev/serial/by-id/*Klipper_stm32g0b1*
    #
    # expecting:
    # > /dev/serial/by-id/usb-Klipper_stm32g0b1xx_1600120012504B5735313920-if00 -> ../../ttyACM3
  ```
