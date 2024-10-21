#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5

# Current Theme
dir="$HOME/.config/rofi/powermenu"
theme='style'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
shutdown=''
reboot=''
lock=''
suspend=''
logout='󰗽'
yes=''
no=''

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime" \
		-theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/shared/confirm.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--suspend' ]]; then
			mpc -q pause
			amixer set Master mute
			systemctl suspend
		elif [[ $1 == '--logout' ]]; then
                        swaymsg exit
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
                swaylock \
                  --screenshots \
                  --clock \
                  --indicator \
                  --font "Inter" \
                  --indicator-radius 100 \
                  --indicator-thickness 7 \
                  --effect-blur 7x5 \
                  --effect-vignette 0.5:0.5 \
                  --text-color D19A66 \
                  --ring-color 61AFEF \
                  --key-hl-color 4378A3 \
                  --bs-hl-color BE5046 \
                  --line-color 00000000 \
                  --inside-color 00000088 \
                  --separator-color 00000000 \
                  --line-wrong-color 00000000 \
                  --inside-wrong-color 00000088 \
                  --text-wrong-color BE5046 \
                  --ring-wrong-color BE5046 \
                  --line-clear-color 00000000 \
                  --line-ver-color 00000000 \
                  --ring-ver-color 61AFEF \
                  --inside-ver-color 00000088 \
                  --inside-clear-color 00000088 \
                  --ring-clear-color D19A66 \
                  --text-clear-color D19A66 \
                  --text-ver-color 61AFEF \
                  --grace 2 \
                  --fade-in 0.2
                 ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
