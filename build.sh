#! /bin/bash

# UltimaMod Variables
ULTIMAMOD_ROMNAME=UltimaMod
ULTIMAMOD_BUILD_VERSION=Folkvangr
ULTIMAMOD_VERSION_MAJOR=2
ULTIMAMOD_VERSION_MINOR=0.1
ULTIMAMOD_UPDATE_URL=http://www.ultimarom.com/rom/update/update_manifest.xml

AND_BUILD_NUMBER=KTU84P

DISTTYPE=user
DEVICE=
VENDOR=vendor/ultimamod
SEVENZIP=$VENDOR/tools/7za
NOW=$(date +"%Y%m%d")
CMVER=11
TYPE=

buildROM () { 
    runLunch
    brunch cm_"$DEVICE"-user
    repackROM ;
}

repackROM () {
    runLunch
    # Create the dirs
    mkdir -p "$OUTMOD"

    # Delete any existing files
    rm -rf "$OUTMOD"/*

    # Copy system files
    echo "Extracting CyanogenMod files"
    LATESTZIP=$(ls -t ${OUTFOLDER}/ | grep -e "cm-$CMVER.*\.zip" | cut -d. -f1 | head -n1)
    echo "Using file $LATESTZIP"
    $SEVENZIP x -o"$OUTMOD" "$OUTFOLDER"/"${LATESTZIP}".zip > /dev/null

    cp -a "$VENDOR"/CHANGELOG-UM.txt "$OUTMOD"/system/etc

    # Delete some unnecessary files
    rm -rf "$OUTMOD"/META-INF "$OUTMOD"/recovery
    rm -f "$OUTMOD"/system/priv-app/CMUpdater.apk
    rm -f "$OUTMOD"/system/priv-app/CMUpdater.odex

    echo "Copying UltimaMod files"

    # Copy in AROMA files
    cp -a "$VENDOR"/aroma/META-INF "$OUTMOD"/META-INF
    cp -a "$VENDOR"/aroma/overlay/"$DEVICE"/. "$OUTMOD"
    cp -a "$VENDOR"/aroma/ultima "$OUTMOD"/ultima
    cp -a "$VENDOR"/changelog.txt "$OUTMOD"/META-INF/com/google/android/aroma
    cp -a "$VENDOR"/license.txt "$OUTMOD"/META-INF/com/google/android/aroma
    cp -a "$VENDOR"/notes.txt "$OUTMOD"/META-INF/com/google/android/aroma

    # Move over optional files
    ## Live Wallpapers
    mkdir -p "$OUTMOD"/ultima/live_wallpapers/magic_smoke/app "$OUTMOD"/ultima/live_wallpapers/bubbles/app "$OUTMOD"/ultima/live_wallpapers/phasebeam/app "$OUTMOD"/ultima/live_wallpapers/photophase/app "$OUTMOD"/ultima/live_wallpapers/sunbeam/app "$OUTMOD"/ultima/live_wallpapers/holo_spiral/app
    mv "$OUTMOD"/system/app/MagicSmokeWallpapers.apk "$OUTMOD"/ultima/live_wallpapers/magic_smoke/app
    mv "$OUTMOD"/system/app/NoiseField.apk "$OUTMOD"/ultima/live_wallpapers/bubbles/app
    mv "$OUTMOD"/system/app/PhaseBeam.apk "$OUTMOD"/ultima/live_wallpapers/phasebeam/app
    mv "$OUTMOD"/system/app/PhotoPhase.apk "$OUTMOD"/ultima/live_wallpapers/photophase/app
    mv "$OUTMOD"/system/app/SunBeam.apk "$OUTMOD"/ultima/live_wallpapers/sunbeam/app
    mv "$OUTMOD"/system/app/HoloSpiralWallpaper.apk "$OUTMOD"/ultima/live_wallpapers/holo_spiral/app

    mv "$OUTMOD"/system/app/MagicSmokeWallpapers.odex "$OUTMOD"/ultima/live_wallpapers/magic_smoke/app
    mv "$OUTMOD"/system/app/NoiseField.odex "$OUTMOD"/ultima/live_wallpapers/bubbles/app
    mv "$OUTMOD"/system/app/PhaseBeam.odex "$OUTMOD"/ultima/live_wallpapers/phasebeam/app
    mv "$OUTMOD"/system/app/PhotoPhase.odex "$OUTMOD"/ultima/live_wallpapers/photophase/app
    mv "$OUTMOD"/system/app/SunBeam.odex "$OUTMOD"/ultima/live_wallpapers/sunbeam/app
    mv "$OUTMOD"/system/app/HoloSpiralWallpaper.odex "$OUTMOD"/ultima/live_wallpapers/holo_spiral/app
    
    ## Keyboards
    mkdir -p "$OUTMOD"/ultima/keyboards/aosp/app "$OUTMOD"/ultima/keyboards/aosp/lib
    mv "$OUTMOD"/system/app/LatinIME.apk "$OUTMOD"/ultima/keyboards/aosp/app
    mv "$OUTMOD"/system/app/LatinIME.odex "$OUTMOD"/ultima/keyboards/aosp/app
    mv "$OUTMOD"/system/lib/libjni_latinime.so "$OUTMOD"/ultima/keyboards/aosp/lib

    ## Camera
    mkdir -p "$OUTMOD"/ultima/camera/aosp/app "$OUTMOD"/ultima/camera/aosp/lib
    mv "$OUTMOD"/system/app/Camera2.apk "$OUTMOD"/ultima/camera/aosp/app
    mv "$OUTMOD"/system/app/Camera2.odex "$OUTMOD"/ultima/camera/aosp/app
    mv "$OUTMOD"/system/lib/libjni_mosaic.so "$OUTMOD"/ultima/camera/aosp/lib

    ## Boot animation
    mkdir -p "$OUTMOD"/ultima/bootanimation/cyan
    mv "$OUTMOD"/system/media/bootanimation.zip "$OUTMOD"/ultima/bootanimation/cyan/bootanimation.zip
    if [ "$DEVICE" == "jflte" ]; then
        mkdir -p "$OUTMOD"/ultima/bootanimation/stock "$OUTMOD"/ultima/bootanimation/l_preview
        cp $VENDOR/prebuilt/common/bootanimation/stock/BOOTANIMATION-1920x1080.zip "$OUTMOD"/ultima/bootanimation/stock/bootanimation.zip
        cp $VENDOR/prebuilt/common/bootanimation/l_preview/BOOTANIMATION-1920x1080.zip "$OUTMOD"/ultima/bootanimation/l_preview/bootanimation.zip
    else
        cp $VENDOR/prebuilt/common/bootanimation/stock/BOOTANIMATION-1280x720.zip "$OUTMOD"/ultima/bootanimation/stock/bootanimation.zip
        cp $VENDOR/prebuilt/common/bootanimation/l_preview/BOOTANIMATION-1280x720.zip "$OUTMOD"/ultima/bootanimation/l_preview/bootanimation.zip
    fi

    # Make specific alterations
    ## aroma-config
    FILE="$OUTMOD"/META-INF/com/google/android/aroma-config
    sed -i "s/ini_set(\"rom_version\",.*\"\");/ini_set(\"rom_version\",          \"${ULTIMAMOD_VERSION_MAJOR}.${ULTIMAMOD_VERSION_MINOR}\");/g" "$FILE"
    sed -i "s/ini_set(\"rom_device\",.*\"\");/ini_set(\"rom_device\",           \"$DEVICE\");/g" "$FILE"
    sed -i "s/ini_set(\"rom_date\",.*\"\");/ini_set(\"rom_date\",             \"$NOW\");/g" "$FILE"
    sed -i "s/setvar(\"rom_codename\",.*\"\");/setvar(\"rom_codename\",             \"$ULTIMAMOD_BUILD_VERSION\");/g" "$FILE"

    if [ "$DEVICE" == "jflte" ]; then
        REAL_TAB=$(echo -e "\t")
        sed -i "s/ini_set(\"dp\",\"4\");/ini_set(\"dp\",\"5\");/g" "$FILE"
        sed -i "s/ROM Version/ROM Version${REAL_TAB}/g" "$FILE"
    fi

    ## updater-script
    FILE="$OUTMOD"/META-INF/com/google/android/updater-script
    if [ "$DEVICE" == "jflte" ]; then
        sed -i "s|ui_print(\"Flashing CyanogenMod Kernel...\");|ui_print(\"Flashing CyanogenMod Kernel...\");\n\tassert(package_extract_file(\"boot.img\", \"/tmp/boot.img\"), run_program(\"/sbin/sh\", \"/system/etc/loki.sh\") == 0);\nifelse(is_substring(\"I337\", getprop(\"ro.bootloader\")), run_program(\"/sbin/sh\", \"-c\", \"busybox cp -R /system/blobs/gsm/* /system/\"));\nifelse(is_substring(\"I545\", getprop(\"ro.bootloader\")), run_program(\"/sbin/sh\", \"-c\", \"busybox cp -R /system/blobs/cdma/* /system/\"));\nifelse(is_substring(\"I545\", getprop(\"ro.bootloader\")), run_program(\"/sbin/sh\", \"-c\", \"busybox cp -R /system/blobs/vzw/* /system/\"));\nifelse(is_substring(\"I545\", getprop(\"ro.bootloader\")), run_program(\"/sbin/sh\", \"-c\", \"busybox sed -i 's/ro.com.google.clientidbase=android-google/ro.com.google.clientidbase=android-verizon/g' /system/build.prop\"));\nifelse(is_substring(\"L720\", getprop(\"ro.bootloader\")), run_program(\"/sbin/sh\", \"-c\", \"busybox cp -R /system/blobs/cdma/* /system/\"));\nifelse(is_substring(\"M919\", getprop(\"ro.bootloader\")), run_program(\"/sbin/sh\", \"-c\", \"busybox cp -R /system/blobs/gsm/* /system/\"));\nifelse(is_substring(\"R970\", getprop(\"ro.bootloader\")), run_program(\"/sbin/sh\", \"-c\", \"busybox cp -R /system/blobs/cdma/* /system/\"));\nifelse(is_substring(\"I9505\", getprop(\"ro.bootloader\")), run_program(\"/sbin/sh\", \"-c\", \"busybox cp -R /system/blobs/gsm/* /system/\"));\nifelse(is_substring(\"I9507\", getprop(\"ro.bootloader\")), run_program(\"/sbin/sh\", \"-c\", \"busybox cp -R /system/blobs/gsm/* /system/\"));\nifelse(is_substring(\"I9508\", getprop(\"ro.bootloader\")), run_program(\"/sbin/sh\", \"-c\", \"busybox cp -R /system/blobs/gsm/* /system/\"));\n|g" "$FILE"
        sed -i "s|run_program(\"/tmp/hardswap.sh\", \"/preload\", file_getprop(\"/tmp/aroma-data/hardswap.prop\", \"preload\"));|run_program(\"/tmp/hardswap.sh\", \"/cache\", file_getprop(\"/tmp/aroma-data/hardswap.prop\", \"preload\"));|g" "$FILE"
        echo 'assert(getprop("ro.product.device") == "jflte" || getprop("ro.build.product") == "jflte" || 
       getprop("ro.product.device") == "jfltexx" || getprop("ro.build.product") == "jfltexx" || 
       getprop("ro.product.device") == "i9505" || getprop("ro.build.product") == "i9505" || 
       getprop("ro.product.device") == "GT-I9505" || getprop("ro.build.product") == "GT-I9505" || 
       getprop("ro.product.device") == "jgedlte" || getprop("ro.build.product") == "jgedlte" || 
       getprop("ro.product.device") == "i9505g" || getprop("ro.build.product") == "i9505g" || 
       getprop("ro.product.device") == "GT-I9505G" || getprop("ro.build.product") == "GT-I9505G" || 
       getprop("ro.product.device") == "jfltevzw" || getprop("ro.build.product") == "jfltevzw" || 
       getprop("ro.product.device") == "jfltespr" || getprop("ro.build.product") == "jfltespr" || 
       getprop("ro.product.device") == "jflterefreshspr" || getprop("ro.build.product") == "jflterefreshspr" || 
       getprop("ro.product.device") == "jfltetmo" || getprop("ro.build.product") == "jfltetmo" || 
       getprop("ro.product.device") == "jfltecri" || getprop("ro.build.product") == "jfltecri" || 
       getprop("ro.product.device") == "jfltecsp" || getprop("ro.build.product") == "jfltecsp" || 
       getprop("ro.product.device") == "jflteatt" || getprop("ro.build.product") == "jflteatt" || 
       getprop("ro.product.device") == "jfltecan" || getprop("ro.build.product") == "jfltecan" || 
       getprop("ro.product.device") == "jflteusc" || getprop("ro.build.product") == "jflteusc" || 
       getprop("ro.product.device") == "jfltezm" || getprop("ro.build.product") == "jfltezm" || abort("Incorrect device. Please make sure you are using a supported device"););' | cat - "$FILE" | tee "$FILE"  > /dev/null
    else
        sed -i "s|ui_print(\"Flashing CyanogenMod Kernel...\");|ui_print(\"Flashing CyanogenMod Kernel...\");\n\tassert(package_extract_file(\"boot.img\", \"/tmp/boot.img\"), write_raw_image(\"/tmp/boot.img\", \"/dev/block/mmcblk0p5\"), delete(\"/tmp/boot.img\"));|g" "$FILE"
        echo 'assert(getprop("ro.product.device") == "m0" || getprop("ro.build.product") == "m0" || 
       getprop("ro.product.device") == "i9300" || getprop("ro.build.product") == "i9300" || 
       getprop("ro.product.device") == "GT-I9300" || getprop("ro.build.product") == "GT-I9300" || abort("Incorrect device. Please make sure you are using a supported device"););' | cat - "$FILE" | tee "$FILE"  > /dev/null
    fi

    ## build.prop
    FILE="$OUTMOD"/system/build.prop
    sed -i "s/ro.cm.display.version=.*$DEVICE//g" "$FILE"
    sed -i "s/ro.build.display.id=.*/ro.build.display.id=${AND_BUILD_NUMBER}/g" "$FILE"
    sed -i "s/ro.com.android.dateformat=MM-dd-yyyy/ro.com.android.dateformat=dd-MM-yyyy/g" "$FILE"
    echo " " >> "$FILE"
    echo "# UltimaMod" >> "$FILE"
    echo "ro.ua.romname=${ULTIMAMOD_ROMNAME}" >> "$FILE"
    echo "ro.ua.version=v${ULTIMAMOD_VERSION_MAJOR}.${ULTIMAMOD_VERSION_MINOR}" >> "$FILE"
    echo "ro.ua.codename=${ULTIMAMOD_BUILD_VERSION}" >> "$FILE"
    echo "ro.ua.version.stats=UltimaMod-${ULTIMAMOD_BUILD_VERSION}-v${ULTIMAMOD_VERSION_MAJOR}.${ULTIMAMOD_VERSION_MINOR}" >> "$FILE"
    echo "ro.ua.device=${DEVICE}" >> "$FILE"
    echo " " >> "$FILE"
    echo "# OTA Updates" >> "$FILE"
    echo "ro.ota.romname=${ULTIMAMOD_ROMNAME}" >> "$FILE"
    echo "ro.ota.version=${ULTIMAMOD_VERSION_MAJOR}.${ULTIMAMOD_VERSION_MINOR}" >> "$FILE"
    echo "ro.ota.codename=${ULTIMAMOD_BUILD_VERSION}" >> "$FILE"
    echo "ro.ota.device=${DEVICE}" >> "$FILE"
    echo "ro.ota.manifest= ${ULTIMAMOD_UPDATE_URL}" >> "$FILE"

    ## ArchiDroid INIT and debuggerd
    mv "$OUTMOD"/system/bin/debuggerd "$OUTMOD"/system/bin/debuggerd.real
    cp "$VENDOR"/prebuilt/common/bin/debuggerd "$OUTMOD"/system/bin/debuggerd
    cp -R "$VENDOR"/prebuilt/common/ultimamod "$OUTMOD"/system/ultimamod
    cp "$VENDOR"/prebuilt/common/xbin/ARCHIDROID_INIT "$OUTMOD"/system/xbin/ARCHIDROID_INIT
    cp "$VENDOR"/prebuilt/common/etc/init.d/00ARCHIDROID_INITD "$OUTMOD"/system/etc/init.d/00ARCHIDROID_INITD

    # Zip back up
    if [ -e "$ZIPNAME" ]; then
        rm "$ZIPNAME"
    fi

    ## Move Odex files
    mkdir -p "$OUTMOD"/ultima/odex/app "$OUTMOD"/ultima/odex/priv-app "$OUTMOD"/ultima/odex/framework
    find "$OUTMOD"/system/app/* -name "*.odex" -exec mv -t "$OUTMOD"/ultima/odex/app {} +
    find "$OUTMOD"/system/priv-app/* -name "*.odex" -exec mv -t "$OUTMOD"/ultima/odex/priv-app {} +
    find "$OUTMOD"/system/framework/* -name "*.odex" -exec mv -t "$OUTMOD"/ultima/odex/framework {} +

    echo "Creating ROM zip"
    $SEVENZIP a -r -mx9 -tzip "$ZIPNAME" ./"$OUTMOD"/* > /dev/null
    md5sum "$ZIPNAME" > "$ZIPNAME".md5

    echo -e "\e[1;91mYou can find your ROM zip in the CyanogenMod root folder"
    echo -e "\e[0m "
}

runLunch() {
    # Lunch using our selection
    breakfast cm_"$DEVICE"-user > /dev/null

    # UltimaMod variables
    OUTFOLDER=out/target/product/$DEVICE
    OUTMOD=$OUTFOLDER/ultimamod
    ZIPNAME=UltimaMod-${ULTIMAMOD_BUILD_VERSION}-v${ULTIMAMOD_VERSION_MAJOR}.${ULTIMAMOD_VERSION_MINOR}-${DEVICE}.zip

    # Delete the any existing ones, so that if the build fails, so does the repack
    if [ -e "$OUTZIP" ]; then
        rm -rf "$OUTZIP"
    fi
}

repoSync(){
    repo sync -j8
    ROOMSER=.repo/local_manifests/ultima_roomservice.xml
    UPSTREAM=$(cat ${ROOMSER} | grep -e "<remove-project path=\".*\"" | cut -d= -f2 | sed 's/name//1' | sed 's/\"//g')
    ORIGIN=ultimamod
    BRANCH=cm-11.0

    while read -r line; do
        echo "Upstream merging for $line"
        cd  "$line"
        UPSTREAM=$(cat UPSTREAMS)
        git pull https://www.github.com/"$UPSTREAM" "$BRANCH"
        git push "$ORIGIN" HEAD:"$BRANCH"
        croot
    done <<< "$UPSTREAM"
    echo " "
    echo " "
    echo "Anything else?"
    select more in "Yes" "No"; do
        case $more in
            Yes ) bash build.sh; break;;
            No ) exit 0; ;;
        esac
    done 
}

makeclean(){
    rm -rf ~/.ccache
    make clean
    echo " "
    echo " "
    echo "Anything else?"
    select more in "Yes" "No"; do
        case $more in
            Yes ) bash build.sh; break;;
            No ) exit 0; ;;
        esac
    done ;
}

create(){
    echo " "
    echo " "
    echo "Which device would you like to build? (These are the only supported devices, currently)"
    select product in "i9300" "jflte"; do
        case $product in
            i9300 ) DEVICE=i9300 ; break;;
            jflte ) DEVICE=jflte ; break;;
        esac
    done

    if [ $1 -eq 1 ]; then
        buildROM
    else
        repackROM
    fi 

    echo " "
    echo " "
    echo "Anything else?"
    select more in "Yes" "No"; do
        case $more in
            Yes ) bash build.sh; break;;
            No ) exit 0; ;;
        esac
    done ;

}
echo " "
echo " "
echo -e "\e[1;91mWelcome to the $ULTIMAMOD_ROMNAME ${ULTIMAMOD_VERSION_MAJOR}.${ULTIMAMOD_VERSION_MINOR} $ULTIMAMOD_BUILD_VERSION build script"
echo -e "\e[0m "
. build/envsetup.sh > /dev/null
echo "Please make your selections carefully"
echo " "
echo " "
echo "Do you wish to build now, sync or repack? (Choose repack to recreate the AROMA zip ONLY if you have already built)"
select build in "build" "repack" "sync" "clean"; do
    case $build in
        build ) create 1; break;;
        repack )  create 2; break;;
        sync ) repoSync; break;;
        clean ) makeclean; break ;;
    esac
done

exit 0