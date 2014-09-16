#!/sbin/sh

sed -i "s/persist.sys.dalvik.vm.lib=libart.so/persist.sys.dalvik.vm.lib=libdvm.so/g" "/system/build.prop"
sync
exit 0