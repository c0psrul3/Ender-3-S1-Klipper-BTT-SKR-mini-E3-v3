# Ender 3 S1 - Klipper, Marlin, and stock LCD Reference

## Ender3S1 Mainboard Diagram
![Ender3S1 Mainboard Diagram](./BoardDiagram.jpg)

## Marlin
  + [Github - Marlin Firmware Configurations](https://github.com/MarlinFirmware/Configurations)
    + [Marlin-Configurations__LCD_Files.README.md](./Marlin-Configurations/config/examples/Creality/Ender-3 S1/LCD Files/README.md)
      + [Ender 3 V2 - LCD firmware](./Marlin-Configurations/config/examples/Creality/Ender-3 V2/LCD Files)
    + [Marlin-Configurations.README.md](./Marlin-Configurations/config/examples/Creality/Ender-3 S1/README.md)
    + [Marlin-Configurations__STM32F1](./Marlin-Configurations/config/examples/Creality/Ender-3 S1/STM32F1)
    + [Marlin-Configurations__STM32F4](./Marlin-Configurations/config/examples/Creality/Ender-3 S1/STM32F4) (my board)
  + [GitHub - mriscoc/Ender3V2S1](https://github.com/mriscoc/Ender3V2S1/wiki/How-to-install-the-firmware)
  + [BTT_SKR_Mini_E3_V3__MarlinUI__configuration](./Marlin-Configurations/config/examples/Creality/Ender-3 V2/BigTreeTech SKR Mini E3 v3/MarlinUI)

## Klipper
  + [Ender 3 S1 Klipper Config - 3D Print Beginner](https://3dprintbeginner.com/wp-content/uploads/2022/02/Ender-3-S1-Klipper-Config-1.zip)
  + [Ender 3 S1 Klipper Config - local copy](./Ender 3 S1 Klipper Config/printer.cfg)

  ### KAMP (https://github.com/kyleisah/Klipper-Adaptive-Meshing-Purging)

  ### Klipper config with KAMP (klipper adaptive meshing purging)
    (https://github.com/jmedlin/Ender3-S1-Pro--Klipper-Config)


## How to tell the difference between Ender 3 LCDs
  For the Ender 3S1 you must to use the `private` display firmware / icon assets, available here:
  + **Original Ender 3V2 DWIN display**
    ![Ender3v2-DWIN](https://user-images.githubusercontent.com/2745567/156829365-a58a3afc-77e3-40b9-9e16-5edfe3073de8.jpg)
  + **Original Ender 3S1 DACAI display**
    ![Ender3S1-DACAI](https://user-images.githubusercontent.com/2745567/156829472-2c38a4ab-bdde-4c21-b78f-a30692c96500.jpg)




## Flashing Ender3 controller board:

  + possible method with `dfu-util`:
    ```
    make flash FLASH_DEVICE=/dev/serial/by-id/usb-1a86_USB2.0-Serial-if00-port0
    ```

  + run `make` and find output firmware in `out/klipper.bin`
  + then place file on SDCARD in path `STM32F4_UPDATE/klipper-<VERSION>.bin`  (alone, no other files in this directory)
  + NOTE: subsequent flashing of the controller will not actually happen unless the new firmware bin file has a unique name from the previous.  recommendataion is to use the firmware version in the filename


## BigTreeTech Pi
  + flashing SDcard for BTT-pi (https://github.com/bigtreetech/CB1)


