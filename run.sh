#!/bin/sh

target=wpa_supplicant-2.5

build()
{
    if [ ! -f ./build/wpa_supplicant ];then
        echo "compile wpa_supplicant"
        if [ ! -d ./$target/ ];then
            echo "unzip $target package"
            tar -xf $target.tar.gz
        fi
        cp ./config/deconfig ./$target/wpa_supplicant/.config
        cd ./$target/wpa_supplicant; make; cd -
        mkdir -p build
        cp $target/wpa_supplicant/wpa_supplicant ./build
    fi
}

run()
{
    sudo ./build/wpa_supplicant -Dnl80211,wext -i wlxe84e060a11bd -c config/wpa-psk-tkip.conf -d
}



build
run
