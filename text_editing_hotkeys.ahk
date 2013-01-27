
SetKeyDelay, -1
CoordMode, Tooltip, Screen

; ----------------------------Basic Movement------------------------------------
; ----------Word forward--------------
!w::
{
	Send, ^{Right}
	return
}

+!w::
{
	Send, +^{Right}
	return
}

; ----------Word backward--------------
!b::
{
	Send, ^{Left}
	return
}

+!b::
{
	Send, +^{Left}
	return
}

; ----------Moving up/down/left/right--------------

; -----LEFT------
!j::
{
	Send, {Left}
	return
}
+!j::
{
	Send, +{Left}
	return
}

; -----DOWN------
!k::
{
	Send, {Down}
	return
}

!+k::
{
	Send, +{Down}
	return
}

; -----RIGHT------
!l::
{
	Send, {Right}
	return
}
+!l::
{
	Send, +{Right}
	return
}

; -----UP------
!i::
{
	Send, {Up}
	return
}

+!i::
{
	Send, +{Up}
	return
}

; ----------------------------------Line operations-----------------------------

;-----------EOL--------------
!e::
{
	Send, {End}
	return
}

!+e::
{
	Send, +{End}
	return
}

;-----------BOL--------------
!q::
{
	Send, {Home}
	return
}

!+q::
{
	Send, +{Home}
	return
}

;-----------OPEN LINE BELOW------------
!o::
{
	Send, {End}{Enter}
	return
}

;-----------OPEN LINE ABOVE------------
+!o::
{
	Send, {Home}{Enter}{Up}
	return
}

;-----------Delete line----------------
+^d::
{
	Send, {End}+{Home}{Del}{Backspace}{Home}
	return
}

;-----------Copy line----------------
^d::
{
	Send, {Home}+{End}^c{End}{Enter}^v
	return
}

; ----------------------------------OTHER STUFF---------------------------------

;-----------DELETE-----------
!d::
{
	Send, {Del}
	return
}

;-----------SEMICOLON AT EOL-----------
!s::
{
	Send, {End};
	return
}
 
 
;------------ADD BRACES OLD-------------
/*
!p::
{
	SendPlay, {{} 						;sendplay important!
	SendPlay, {Enter}{Enter}{}}{Up}
	return
}
*/

;------------ADD SQUIGLY BRACES AND OPEN LINE-------------
!p::
{
	SendPlay, {{}{Enter} 						;sendplay important!
	return
}


;------------ADD SQUARE BRACKETS-------------
!8::
{
	SendPlay, [
	return
}


!9::
{
	SendPlay, ]
	return
}

;------------ADD SQUIGLY BRACKETS-------------
!7::
{
	SendPlay, {{}
	return
}


!0::
{
	SendPlay, {}}
	return
}

;------------PgUp and Down-------------
!^j::
{
	Send, !{Left}
	return
}

!^i::
{
	Send, {PgUp}
	return
}

!^l::
{
	Send, !{Right}
	return
}

!^k::
{
	Send, {PgDn}
	return
}

/*
!n::
{
	WinGetClass, class, A
	MsgBox, The active window's class is "%class%".
	return
}
*/
!a::
{ 
	Send, {-}{>}
	return
}

;-----------------------------------EXPERIMENTAL--------------------------------

; Change this to caps-lock (!) key, or make it only work inside text editing programs

/*
!2::Wrap("""", """")
!7::Wrap("{", "}")
!8::Wrap("(", ")")
!+8::Wrap("[", "]")
!SC02B::Wrap("'", "'") ;' character
!u::WrapWithTag()
*/

Wrap(tag1, tag2) {

    OldClipboard := Clipboard

    Clipboard := ""

    sleep, 10

    send, ^c

    sleep, 10

    if (Clipboard = "") {

      Clipboard := OldClipboard
			return

    }

    Clipboard :=  tag1 . Clipboard . tag2

    send, ^v

    Clipboard := OldClipboard
	return
}

WrapWithTag() {
	
	InputBox, char, Input character, , 20, 10
	start := "<" . char . ">"
	end := "<" . char . "/>"
	Wrap(start, end)
	return
	
}
	
;----------------------------------
; Hotstrings for programming
;----------------------------------
/*
#Hotstring c ; Case sensitive
#Hotstring EndChars  .(
:R:pu::public
:R:st::static
:R:pr::private
:R:fi::final
:R:str::string
:R :Str::String
:R  :STr::String
:R:bo::boolean
:R:re::return
:R:imp::implements
:R:sout::System.out.println
*/