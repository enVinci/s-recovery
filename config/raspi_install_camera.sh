## Manual: https://docs.arducam.com/Raspberry-Pi-Camera/Native-camera/16MP-IMX519/
cd ~/Downloads/
wget -O install_pivariety_pkgs.sh https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/install_script/install_pivariety_pkgs.sh
chmod +x ~/Downloads/install_pivariety_pkgs.sh
~/Downloads//install_pivariety_pkgs.sh -p libcamera_dev
~/Downloads//install_pivariety_pkgs.sh -p libcamera_apps
# Configuration file path
CONFIG_FILE="/boot/firmware/config.txt"
LINE_TO_ADD="dtoverlay=imx519"
SECTION_NAME='\[all\]'

add_to_config_file() {
    local CONFIG_FILE="${1}"
    local LINE_TO_ADD="${2}"
    local SECTION_NAME="${3}"

    [ ! -f "${CONFIG_FILE}" ] && echo "Error: ${CONFIG_FILE} does not exist!" && return 1

    grep -Eq '^'"$LINE_TO_ADD" "${CONFIG_FILE}" && echo "Nothing to do. Line already exists in ${CONFIG_FILE}." && return 0

    # Check if the line already exists (uncommented or commented)
    if grep -Eq '^\s*#?\s*'"$LINE_TO_ADD" "${CONFIG_FILE}"; then
        # Uncomment the line if it's commented
        sudo sed -Ei '/^\s*#?\s*'"$LINE_TO_ADD"'/s/^\s*#?\s*//' "${CONFIG_FILE}"
        [ $? -eq 0 ] && echo "Removed comment in the line $LINE_TO_ADD."
    else
        if [[ "${SECTION_NAME}" == "" ]]; then
            sh -c "echo '${LINE_TO_ADD}' >> ${CONFIG_FILE}"
            [ $? -eq 0 ] && echo "Added $LINE_TO_ADD to the end of file."
        else
            # Check if the section exists
            if grep -q "${SECTION_NAME}" "${CONFIG_FILE}"; then
                # Add the line below the section
                sudo sed -i "/${SECTION_NAME}/a\\${LINE_TO_ADD}" "${CONFIG_FILE}"
                [ $? -eq 0 ] && echo "Added $LINE_TO_ADD in the specified section."
            else
                echo "Error: Section ${SECTION_NAME} not found in ${CONFIG_FILE}."
                return 1
            fi
        fi
    fi
}

add_to_config_file "${CONFIG_FILE}" "${LINE_TO_ADD}" "${SECTION_NAME}"

# sudo nano "${CONFIG_FILE}"
