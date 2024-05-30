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
## Firmware Update - BTT-Eddy-usb
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
