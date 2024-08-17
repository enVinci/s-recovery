# On Host Computer

1. **Install Raspbian OS using Imager**
    ```bash
    sudo apt install rpi-imager
    ```
    1.1. Configure installation according to `imager_options.png`.

    1.2. The username can be anything.

    1.3. Internet connection is required!

2. **Use GParted to Modify Partition on SD Card**

    2.1. Grow rootfs partition `sdcard_partitions_modify.png`. Depends on Imager version.

    2.2. Create linux-swap partition `sdcard_partitions_modify.png`.

    2.3. SD Card partitions after formatting `sdcard_partitions.png`.

3. **Copy Scripts to Raspberry [deprecated]**

    3.1. Copy Configuration scripts to Raspberry:
    ```bash
    sudo cp -r ~/Downloads/rpi/config/ /media/sd_mount_point/rootfs/home/
    ```
    3.2. Copy Tool scripts to Raspberry:
    ```bash
    sudo cp -r ~/Downloads/rpi/tools/ /media/sd_mount_point/rootfs/home/
    ```

4. **Add to fstab newly Created Swap Partition to OS installation**

    4.1. Run the Raspberry init script with host init option:
        ```bash
        ./raspi_init.sh --host
        ```

# On Raspberry

1. **Start Logging to a File [optional]**
    ```bash
    script -af ~/Downloads/raspi_init.log
    date
    ```

2. **Run Config Scripts**
    ```bash
    ~/../config/raspi_install_camera.sh
    ```
    ```bash
    ~/../config/raspi_init.sh
    ```
