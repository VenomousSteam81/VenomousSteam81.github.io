#!/system/bin/sh

# Repeatedly kills Google Services.
# I don't know how effective this is or how much damage this can cause, SO PLEASE USE WITH CAUTION!!!
# All I really needed to kill was `com.android.vending` on my slow Lenovo 100e 2nd Gen MTK Chromebook, but I decided to add a bunch more.
# Made by VSteam81

apps=(
    "com.google.android.ext.services"
    "com.google.android.ext.shared"
    "com.google.android.deskclock" 
    "com.google.android.apps.cloudprint"
    "com.google.android.contacts"
    "com.google.android.syncadapters.contacts"
    "com.google.android.gms"
    "com.google.android.gsf"
    "com.google.android.tts"
    "com.google.android.feedback"
    "com.google.android.printservice.recommendation"
    "com.android.providers.telephony"
    "com.android.providers.calendar"
    "com.android.vending"
    "com.android.printspooler"
    "com.android.providers.contacts"
)

while true; do
    for app in "${apps[@]}"; do
        /system/bin/am force-stop $app
        echo "killed $app"
    done
    sleep 0.5
done
