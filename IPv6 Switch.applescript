on run
	
	tell application "Finder"
		activate
		set dialog_result to display dialog "Click \"IPv6 OFF\" to disable IPv6. Click \"IPv6 ON\" to enable IPv6." with title "Enable/Disable IPv6" buttons {"IPv6 OFF", "IPv6 ON", "Cancel"} default button "IPv6 OFF" giving up after 1800
		-- with icon stop
		set re_Button to button returned of dialog_result
		
		
		if re_Button is "IPv6 OFF" then
			do shell script "logger \"IPv6 Script - Disabling IPv6 on all interfaces.\""
			
			try
				do shell script "#/bin/bash while read line; do networksetup -setv6off $line; done < <(tail <(networksetup -listallnetworkservices))"
				do shell script "logger \"IPv6 Script - Disabled IPv6.\""
				display dialog "IPv6 addressing has been turned off." with icon stop buttons {"OK"} default button "OK"
			on error errMsg number errNum
				display dialog "Error!" with icon stop buttons {"OK"} default button "OK"
			end try
			
		else if re_Button is "IPv6 ON" then
			do shell script "logger \"IPv6 Script - Enabling IPv6 on all interfaces.\""
			
			try
				do shell script "#/bin/bash while read line; do networksetup -setv6automatic $line; done < <(tail <(networksetup -listallnetworkservices))"
				
				do shell script "logger \"IPv6 Script - Enabled IPv6.\""
				
				display dialog "IPv6 addressing has been turned on." with icon stop buttons {"OK"} default button "OK"
			on error errMsg number errNum
				display dialog "Error!" with icon stop buttons {"OK"} default button "OK"
			end try
			
		end if
		
	end tell
end run
