SetTitleMatchMode, 2

;#####################################################################
; Close Bracket script
;#####################################################################

; This code inserts the close bracket automatically in a context sensitive way. 
; In the following summary, the "|" character indicates where the cursor is after 
; typing the hot keys

;if you type   [ + string        you get [string|] 
;if you type   []                you get []|
;if you type   [ + (backspace)   both open and close bracket are deleted
;if you type   [ + (up,down,left,right,end,home or delete) 
;       you get just the open bracket and the cursor goes where it is supposed to go.

; HINT:  if you want to type "function()" then navigate away, add a space [i.e. "function( )"] and when you navigate away, the close bracket will remain

; The idea behind the last behaviour is that if you are navigating away from the 
; open bracket without entering text, you probably dont want the close bracket 
; right beside the open bracket.

; to apply this code to a multiple editors add all your text editing apps here

GroupAdd, TextEditors, Notepad
GroupAdd, TextEditors, Microsoft Visual
GroupAdd, TextEditors, powershell
GroupAdd, TextEditors, Flash
GroupAdd, TextEditors, Code::Blocks

#ifWinActive, ahk_group TextEditors
	altkeys =
	(Join: LTrim
	AppsKey : LWin : RWin : LControl : LShift : RShift : LAlt : RAlt
	PrintScreen : CtrlBreak : Pause : Break
	Space : Tab : Enter : Escape : Delete : Insert : Home : End : PgUp : PgDn : Up : Down : Left : Right
	ScrollLock : CapsLock : NumLock
	Numpad0 : Numpad1 : Numpad2 : Numpad3 : Numpad4 : Numpad5 : Numpad6 : Numpad7 : Numpad8 : Numpad9
	NumpadDown : NumpadLeft : NumpadRight : NumpadUp
	NumpadIns : NumpadEnd : NumpadPgDn : NumpadClear : NumpadHome : NumpadPgUp
	NumpadDot : NumpadDel : NumpadDiv : NumpadMult : NumpadAdd : NumpadSub : NumpadEnter
	F1 : F2 : F3 : F4 : F5 : F6 : F7 : F8 : F9 : F10 : F11 : F12 : F13 : F14 : F15 : F16 : F17 : F18 : F19 : F20 : F21 : F22 : F23 : F24
	Browser_Back : Browser_Forward : Browser_Refresh : Browser_Stop : Browser_Search : Browser_Favorites : Browser_Home
	Volume_Mute : Volume_Down : Volume_Up
	Media_Next : Media_Prev : Media_Stop : Media_Play_Pause
	Launch_Mail : Launch_Media : Launch_App1 : Launch_App2
	mbutton : rbutton : lbutton
	)

	Loop,Parse,altkeys,:, %A_Space%
		Hotkey, % "~" A_LoopField, EndcharIsTyped,ON

	; This resets the A_Hotstring  variabile to empty when an non brackt/paren is typed 
	Chars=-@#$^&*_{+}:;|/\,.?! ```%`t1234567890-=qwertyuiop\asdfghjkl;zxcvbnm,./'
	Loop,Parse,Chars
		Hotkey, % "~" A_LoopField, EndcharIsTyped,ON

	; These keys indicate that the inserted close bracket/paren is not likely wanted
	; so delete the close bracket and reset the A_HotString Variable. (You may want to add a mouse click to this list of hotkeys.)
	up::
	down::
	left::
	right::
	~backspace::
	end::
	home::
		If (A_HotString = "(" ) 
			send, {del}
		If (A_HotString = "{" ) 
			send, {del}
		If (A_HotString = "[" ) 
			send, {del}
		If (A_HotString = """" )  ;escaped double quote
			send, {del}
		If (A_HotString = "'" )  ;escaped double quote
			send, {del}


		If (A_ThisLabel = "up" )
		  sendinput {up}
		If (A_ThisLabel = "down" ) 
		 sendinput {down}
		If (A_ThisLabel = "left" ) 
		 sendinput {left}
		If (A_ThisLabel = "right" ) 
		 sendinput {right}
		If (A_ThisLabel = "end"  )
		 sendinput {end}
		If (A_ThisLabel = "home" ) 
		 sendinput {home}

	EndcharIsTyped:
		A_Hotstring := "" ; remove any saved Global HotStrings
		return


	:*b0?:(::
		A_HotString := (RegExMatch(A_ThisLabel,"\:(?P<String>[^:]+)$",Hot) ? HotString : "")
		sendinput {)}{left}
	return
	:b0*?:[::
		A_HotString := (RegExMatch(A_ThisLabel,"\:(?P<String>[^:]+)$",Hot) ? HotString : "")
		sendinput {]}{left}
	return
	:b0*?:{::
		A_HotString := (RegExMatch(A_ThisLabel,"\:(?P<String>[^:]+)$",Hot) ? HotString : "")
		sendinput {}}{left}
	return
	:b0*?:"::
		A_HotString := (RegExMatch(A_ThisLabel,"\:(?P<String>[^:]+)$",Hot) ? HotString : "")
		sendinput {"}{left}
	return
	:b0*?:'::
		A_HotString := (RegExMatch(A_ThisLabel,"\:(?P<String>[^:]+)$",Hot) ? HotString : "")
		sendinput {'}{left}
	return

	; if you type the close bracket you dont need the inserted bracket
	:b0*?:)::
		If (A_HotString = "(" ) 
		sendinput {del}
		gosub, EndcharIsTyped
	return
	:b0*?:]::
		If (A_HotString = "[" ) 
		sendinput {del}
		gosub, EndcharIsTyped
	return
	:b0*?:}::
		If (A_HotString = "{" ) 
		sendinput {del}
		gosub, EndcharIsTyped
	return
	:b0*?:"::
		If (A_HotString = """" )  ;escaped double quote
		sendinput {del}
		gosub, EndcharIsTyped
	return
	:b0*?:'::
		If (A_HotString = "'" )  ;escaped double quote
		sendinput {del}
		gosub, EndcharIsTyped
	return
	
	
	; paste and delete should not initiate the removal of the close bracket/paren
	~^v::
	~delete::
		gosub, EndcharIsTyped
	return
#IfWinActive 