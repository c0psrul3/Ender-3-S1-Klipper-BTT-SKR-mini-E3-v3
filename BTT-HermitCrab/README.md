# BigTreeTech HermitCrab (with CAN)

[source - "github.com:bigtreetech/HermitCrab"](https://github.com/bigtreetech/HermitCrab/blob/master/CanbusKlipper/Klipper/README.md)

### USB device info _out-of-the-box_
```
Bus 001 Device 008: ID 0483:5740 STMicroelectronics Virtual COM Port
```

## Firmware update
  + USB device info for HermitCrab in DFU mode
    ```
    Bus 001 Device 010: ID 0483:df11 STMicroelectronics STM Device in DFU Mode
    ```
  * [USB direct firmware](https://github.com/bigtreetech/HermitCrab/blob/master/CanbusKlipper/Klipper/firmware-F072-USB.bin)
  * [CANbus controlled firmware](https://github.com/bigtreetech/HermitCrab/blob/master/CanbusKlipper/Klipper/firmware-F072-Canbus.bin)

### Firmware Update Software:
  CRAP! DO NOT USE  (https://www.st.com/en/development-tools/stm32cubeprog.html#st-get-software)

### Firmware Update with `dfu-util`
  [REF: youtube video](https://www.youtube.com/watch?v=ekbxtDS_8cM&t=3m46s)
  ```
  # 
  dfu-util -a 0 -D firmware-F072-USB.bin --dfuse-address 0x08000000:force:mass-erase -d 0483:df11
  ```

### USB device info - after firmware upgrade with "usb firmware"  (not CAN)
  ```
  Bus 001 Device 019: ID 1d50:614e OpenMoko, Inc. stm32f072xb
  ```

### Klipper configuration of HermitCrab for extruder

We're going to use the USB connection, for now, until we get more familiar with it
### Klipper configuration of HermitCrab for extruder









    Communication interface = USB (on PA11/PA12)
    USB ids 0x1d50 for USB vender ID, and 0x614f for USB device ID. (Note: it is important that hte USB device ID is not the default 0x614e assigned by Klipper as this causes the device to lose connection during FIRMWARE_RESTART









