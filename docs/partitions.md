# Instructions On Partition Usage

* System Partition
* Product Partition
* SystemExt Partition

Devices running on Android Version **7** to **9**, use system partition for installing BiTGApps components.

Devices running on Android Version **10**, use product partition for installing BiTGApps components.

Devices running on Android Version **11**/**12**, use system_ext partition for installing BiTGApps components.

## Conflict

Installation will never fail for devices running on Android Nougat/Oreo/Pie.

For any reason, if you do not have **product** or **system_ext** partition support enabled in your device then,
at the time of installation you will be notified with following texts.

* On Android 10

```! Product partition not found. Aborting...```

* On Android 11/12

```! SystemExt partition not found. Aborting...```

## MIUI Vendor

If you use MIUI Vendor instead of OSS. You may face mounting issues with vendor partition and at the time of installation you will be notified with following texts.

```! Read-only /vendor partition. Aborting...```

Either switch to OSS vendor or convert stock vendor sparse image to raw image. Conversion from sparse to raw image, can be done by sim2img tool.

Here is an example of converting image using sim2img
* `simg2img vendor.img vendor.raw.img`
