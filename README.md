# Ender-3-S1-Marlin-BTT-SKR-Mini-E3-V3-0-Klipper

*From:*
  Ender 3 S1 + Marlin
*To:*
  BIGTREETECH SKR Mini E3 V3.0 + Klipper / MainsailOS (rPi-Z2) + OctoKlipper

----
## IMPORTANT - Latest Mainboard Variants of STM32F401

+ There are two variants - STM32F401RET6 and STM32F401RCT6 (mine), that sucks.
  STM32F401RCT6 SoC has only 256k flash memory, while STM32F401RET6 has 512k
  This limits either what firmware you can install or what features can be
  enabled when compiling firmware so the bin actually fits.

From [mriscoc wiki](https://github.com/mriscoc/Ender3V2S1/wiki#versions) regarding that firmware:
> ...some features are disabled in the F4 UBL firmware version, for
> example: BAUD_RATE_GCODE, INDIVIDUAL_AXIS_HOMING_SUBMENU, SOUND_MENU_ITEM,
> LONG_FILENAME_WRITE_SUPPORT, BINARY_FILE_TRANSFER, POWER_LOSS_RECOVERY.

----
## Links

+ Ender 3
  + [General setup / reference](https://howchoo.com/diy/setting-up-creality-ender-3-v2-3d-printer)
  + [Ender 3 V2 Firmware - Reddit](https://www.reddit.com/r/Ender3v2Firmware/)

+ Ender 3 S1
  + [Ender 3 S1 - service tutorial : mainboard replacement](https://youtu.be/hOpYfUAOO-4)
  + [mriscoc/Ender3V2S1 - Marlin Firmware](https://github.com/mriscoc/Ender3V2S1)

+ [BTT SKR Mini E3 V3.0](https://biqu.equipment/collections/control-board/products/bigtreetech-skr-mini-e3-v2-0-32-bit-control-board-for-ender-3)
  + [SKR-mini-E3-V3.0-klipper.cfg](https://github.com/bigtreetech/BIGTREETECH-SKR-mini-E3/blob/master/firmware/V3.0/Klipper/SKR-mini-E3-V3.0-klipper.cfg)
  + [great guide by theSt33v to setup SKR Mini E3 on Ender3S1](https://github.com/theSt33v/Ender-3-S1-Skr-Mini-E3V3-Edition)

+ [OctoPrint](https://octoprint.org/)
  + [OctoKlipper Plugin](https://plugins.octoprint.org/plugins/klipper/)

+ Klipper and stuff
  + [How To Install Klipper On Creality Ender 3 S1: Config And Setup | 3D Print Beginner](https://3dprintbeginner.com/how-to-install-klipper-on-ender-3-s1/)
  + [How To Install FluiddPi On RaspberryPi | 3D Print Beginner](https://3dprintbeginner.com/how-to-install-fluiddpi-on-raspberry-pi/)

### Ender 3 S1 - mainboard diagram
[!img:./reference/BoardDiagram.jpg]

## BIGTREETECH SKR Mini E3 V3.0 (cutsheet)
[!img:https://cdn.shopifycdn.net/s/files/1/1619/4791/files/MINI_E3_-_1.jpg]


