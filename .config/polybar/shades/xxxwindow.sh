#!/bin/bash

WM_DESKTOP=$(xdotool getwindowfocus)

if [ $WM_DESKTOP == "2123" ]; then

	echo " "

elif [ $WM_DESKTOP != "1883" ]; then

	WM_CLASS=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk 'NF {print $NF}' | sed 's/"/ /g')
	WM_NAME=$(xprop -id $(xdotool getactivewindow) WM_NAME | cut -d '=' -f 2 | awk -F\" '{ print $2 }')

	if [ $WM_CLASS == 'kitty' ]; then

		echo "%{F#ffffff}Kitty%{u-}"
	
	elif [ $WM_CLASS == 'Firefox' ]; then

		echo "%{F#ffffff}Custom name%{u-}"

	else

		echo "%{F#ffffff}$WM_NAME%{u-}"

	fi

fi