include(`local.m4')

# #############################################################
# WARNING!!!!! THIS FILE IS GENERATED FROM M4 TEMPLATE !!!!!!!!
# #############################################################

general {
        output_format = "i3bar"
        colors = true
        interval = 5
}

order += "read_file spotify"
order += "ipv6"
ifdef(`WAN', order += "wireless WAN")
ifdef(`ETH', order += "ethernet ETH")
ifdef(`EXT', order += "ethernet EXT")
order += "disk /"
ifdef(`HOM', order += "disk /home")
ifdef(`BAT', order += "battery 0")
order += "memory"
order += "load"
order += "tztime local"

wireless WAN {
        format_up = "W: %ip (%essid %quality, %frequency %bitrate)"
        format_down = "W: down"
}

ethernet ETH {
        format_up = "E: %ip (%speed)"
        format_down = "E: down"
}

ethernet EXT {
        format_up = "X: %ip (%speed)"
        format_down = "X: down"
}

battery 0 {
        format = "%status %percentage %remaining %emptytime"
        format_down = "No battery"
        status_chr = "CHR"
        status_bat = "`BAT'"
        status_unk = "UNK"
        status_full = "FULL"
        path = "/sys/class/power_supply/`BAT'%d/uevent"
        low_threshold = 10
}

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
        format = "/ %free"
}

disk "/home" {
        format = "%free"
}
general {
        output_format = "i3bar"
        colors = true
        interval = 5
}

read_file spotify {
    path = ~/.spotify_status
    color_good = "#FFFFFF"
}
