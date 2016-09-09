#!/bin/sh

target=wpa_supplicant-2.5

install_depends(){
    sudo apt-get install libssl-dev libnl-genl-3-dev libnl-3-dev 
}

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
    sudo ./build/wpa_supplicant -Dnl80211,wext -i wlan2 -c config/wpa-psk-tkip.conf -d
}



build
run
