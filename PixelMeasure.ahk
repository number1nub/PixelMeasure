#NoEnv
#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%
;auto_version

hotkeys("#MButton", "PixelMeasure")
return


PixelMeasure() {
	static enabled, x1, y1
	
	enabled := !enabled
	if (enabled) {
		MouseGetPos, x1, y1
		SetTimer, MeasurePixels, On
		hotkeys("^MButton", "GotoOrigin")
		hotkeys("*Up", "MovePos")
		hotkeys("*Down", "MovePos")
		hotkeys("*Left", "MovePos")
		hotkeys("*Right", "MovePos")
	}
	else {
		SetTimer, MeasurePixels, Off
		hotkeys("^MButton")
		hotkeys("*Up")
		hotkeys("*Down")
		hotkeys("*Left")
		hotkeys("*Right")
		ToolTip
	}
	return
	
	MeasurePixels:
	MouseGetPos, x2, y2
	x2-=x1, y2-=y1	
	ToolTip, % "X: " Abs(x2) "`t" (!x2?"":x2>0?"Right":"Left") "`nY: " Abs(y2) "`t" (!y2?"":y2>0?"Down":"Up") "`n`n<Ctrl+MButton> - Go to origin"
	return
	
	GotoOrigin:
	BlockInput, On
	MouseMove, %x1%, %y1%, 0
	Sleep 500
	BlockInput, Off
	return
	
	MovePos:
	mods := GetMods()
	dir := RegExReplace(A_ThisHotkey, "^[\*\^\+\#]+")
	pixels := mods="!^" ? 25 : mods="^" ? 15 : mods="+" ? 1 : 5
	if (dir="Up" || dir="Down")
		MouseMove, 0, % ((dir="Up" ? -1:1)*pixels), 0, R
	else if (dir="Left" || dir="Right")
		MouseMove, % ((dir="Left" ? -1:1)*pixels), 0, 0, R
	return
}


#Include <Hotkeys>
#Include <GetMods>