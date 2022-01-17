include(`local.m4')

general {
        output_format = "i3bar"
        colors = true
        interval = 5
}

order += "ipv6"
order += "wireless WAN"
order += "ethernet ETH"
order += "disk /"
ifdef(`BAT', 
`order += "battery 0"'
)
order += "memory"
order += "load"
order += "tztime local"

wireless WAN {
        format_up = "W: %ip (%quality at %essid, %bitrate)"
        format_down = "W: down"
}

ethernet ETH {
        format_up = "E: %ip (%speed)"
        format_down = "E: down"
}

ifdef(`BAT', 
`battery 0 {
        format = "%status %percentage %remaining %emptytime"
        format_down = "No battery"
        status_chr = "CHR"
        status_bat = "BAT"
        status_unk = "UNK"
        status_full = "FULL"
        path = "/sys/class/power_supply/`BAT'%d/uevent"
        low_threshold = 10
}')

tztime local {
        format = "%Y-%m-%d %H:%M"
}

load {
        format = "%5min"
}

cpu_temperature 0 {
        format = "T: %degrees °C"
        path = "/sys/devices/platform/coretemp.0/temp1_input"
}

memory {
        format = "%used"
        threshold_degraded = "10%"
        format_degraded = "MEMORY: %free"
}

disk "/" {
        format = "%free"
}