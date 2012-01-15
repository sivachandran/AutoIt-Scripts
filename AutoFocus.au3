Const $MAX_WINDOW_TITLES = 64
Dim $WindowTitles[$MAX_WINDOW_TITLES]

If $CmdLine[0] > 0 Then
   For $i = 1 To $CmdLine[0]
	  $WindowTitles[$i - 1] = $CmdLine[$i]
   Next
   $WindowTitleCount = $CmdLine[0]
Else
   $WindowTitleCount = 0
   While True
	  $windowTitle = InputBox("Window Title To Group", "Enter window title(regex) to group?" & @CRLF & "(Give empty string or press Cancel to stop)")
	  If $windowTitle == "" Then
		 ExitLoop
	  EndIf
	  
	  $WindowTitles[$WindowTitleCount] = $windowTitle
	  $WindowTitleCount += 1
	  If $WindowTitleCount == $MAX_WINDOW_TITLES Then
		 ExitLoop
	  EndIf
   WEnd
EndIf

$toolTip = "WindowGrouper: "
For $i = 0 To $WindowTitleCount - 1
   $toolTip &= '"'
   $toolTip &= $WindowTitles[$i]
   $toolTip &= '" '
Next
TraySetToolTip($toolTip)

$hasFocus = False
While True
   $activeWindowTitle = WinGetTitle(WinActive(""))
   $isGroupedWindow = False
   For $i = 0 To $WindowTitleCount - 1
	  If StringRegExp($activeWindowTitle, $WindowTitles[$i], 0) Then
		 If $hasFocus == False Then
			For $j = 0 To $WindowTitleCount - 1
			   If $WindowTitles[$i] <> $WindowTitles[$j] Then
				  ; find a better way to bring the window to front
				  WinSetOnTop("[REGEXPTITLE:" & $WindowTitles[$j] & "]", "", 1)
				  WinSetOnTop("[REGEXPTITLE:" & $WindowTitles[$j] & "]", "", 0)
			   EndIf
			Next
			$hasFocus = True
		 EndIf
		 $isGroupedWindow = True
	  EndIf
   Next
   
   If $isGroupedWindow == False Then
	  $hasFocus = False
   EndIf
   Sleep(5)
WEnd
