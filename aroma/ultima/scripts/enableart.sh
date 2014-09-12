#!/sbin/sh

sed -i "s/persist.sys.dalvik.vm.lib=libdvm.so/persist.sys.dalvik.vm.lib=libart.so/g" "/system/build.prop"
sync
exit 0