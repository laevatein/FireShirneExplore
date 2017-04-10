// 1 || 2
// 3 || 4
// 5 || 6



Dim Role1stIconPX = 140, Role1stIconPY = 850
Dim Role2ndIconPX = 440, Role2ndIconPY = 850
Dim Role3rdIconPX = 140, Role3rdIconPY = 980
Dim Role4thIconPX = 440, Role4thIconPY = 980
Dim Role5thIconPX = 140, Role5thIconPY = 1110
Dim Role6thIconPX = 440, Role6thIconPY = 1110

Dim MaxTimer = 50
Dim ClickDelay = 200

Dim FirstMapCount = 14
Dim SecondMapCount = 15

//////////
// Main //
//////////
ExploreFirstMap()

ExploreSecondMap()

//////////
// End  //
//////////
/////////////////////////////////////////////////////////////
Function ExploreSecondMap()
  Dim Timer
  Timer = 0
  Do
  Call MovingSecondMap()
  Call XonAttack()
  Timer = Timer + 1
  Loop While Timer < SecondMapCount
End Function
/////////////////////////////////////////////////////////////
Function ExploreFirstMap()
  Dim Timer
  Timer = 0
  Do
    Call MovingFirstMap()
    Call XonAttack()
    Timer = Timer + 1
  Loop While Timer < FirstMapCount
End Function
/////////////////////////////////////////////////////////////
Function XonAttack()
  Call SlideAblity(4)
  Delay 500
  Call ClickAbility()
  Delay 500
  Tap Role4thIconPX, Role4thIconPY
  Delay 500
  Tap 86, 1234
  Delay 500
  Call WaitFinishedFight()
End Function
/////////////////////////////////////////////////////////////
Function MovingFirstMap()
  Dim result
  TracePrint "(MovingFirstMap)Start"
  Do
    result = CmpColorEx("537|1247|72BFE6", 0.9)
    If result = 1 Then 
      call MovingUp (152, 171, "4FE8FF")
      call MovingDown(152, 271, "4FE8FF")
    Else 
      Exit Do
    End If
  Loop

  TracePrint "(MovingFirstMap)Success"
End Function
/////////////////////////////////////////////////////////////
Function MovingSecondMap()
Dim result

TracePrint "(MovingSecondMap)Start"
Do
	result = CmpColorEx("537|1247|72BFE6", 0.9)
	If result = 1 Then 
	MovingUp (152, 171, "4D2E8D")
	MovingDown(152, 271, "50E8FF")
	Else 
	Exit Do
	End If
Loop

TracePrint "(MovingSecondMap)Success"
End Function
/////////////////////////////////////////////////////////////
Function MovingUp(px, py, color)
  Dim cmpclr = px & "|" & py & "|" & color
  TracePrint "(MovingUp)"
  TouchDown 358,848, 1
  TouchMove 358, 448, 1, 200
  Do
  If CmpColorEx(cmpclr, 0.9) = 1 Then 
  //If CmpColorEx("152|171|4FE8FF", 0.9) = 1 Then 
  Exit Do
  End If
  If CmpColorEx("537|1247|72BFE6", 0.9) = 0 Then 
  Exit Do
  End If
  Loop
  TouchUp
  TracePrint "(MovingUp)Success"
End Function
/////////////////////////////////////////////////////////////
Function MovingDown(px, py, color)
  Dim cmpclr = px & "|" & py & "|" & color
  TracePrint "(MovingDown)"
  TouchDown 358,448, 1
  TouchMove 358, 848, 1, 200
  Do
  If CmpColorEx(cmpclr, 0.9) = 1 Then
    Exit Do
  End If
  If CmpColorEx("537|1247|72BFE6", 0.9) = 0 Then 
    Exit Do
  End If
  Loop
  TouchUp 
  TracePrint "(MovingDown)Success"
End Function
/////////////////////////////////////////////////////////////
Function WaitFinishedFight()
Dim Timer
Dim result
Dim WaitTimer = 30
Dim msg

Timer = 0

Do

msg = "(WaitFinishedFight)Waitting..." & CStr(Timer) & " secs"
TracePrint msg
result = CmpColorEx("311|406|FFF7EE", 0.9)
	If result = 0 Then 
		Delay 1000
		Timer = Timer + 1
	Else 
		Delay 1000
		Exit Do
	End If
Loop While Timer < WaitTimer

If Timer >= WaitTimer Then 
	TracePrint "(WaitFinishedFight)Exit"
	Exit Function
End If

Tap 311, 406
Delay 1000
TracePrint "(WaitFinishedFight)Success"

End Function

/////////////////////////////////////////////////////////////
Function SlideAblity(RoleNumber)
  Dim Timer
  If RoleNumber = 1 Then
  Else If RoleNumber = 2 Then
  Else If RoleNumber = 3 Then
  Else If RoleNumber = 4 Then
  Else If RoleNumber = 5 Then
  Else If RoleNumber = 6 Then
  End If
  Dim result
  Timer = 0
  Do
  result = CmpColorEx("439|961|FFFFFF", 0.9)
  If result = 1 Then 
    Exit Do 
  Else 
    Timer = Timer + 1
    Delay 500
  End If
  Loop While Timer < MaxTimer

  If Timer >= MaxTimer Then 
    TracePrint "(SlideAblity)Exit"
    Exit Function
  End If

  // slide to ability
  TouchDown 439, 961, 1
  TouchMove 593, 966, 1, 200

  TracePrint "(SlideAblity)Success"
End Function
/////////////////////////////////////////////////////////////


Function ClickAbility()
Dim Timer
Dim result

Timer = 0
Do
result = CmpColorEx("71|978|41DBF9", 0.9)
If result = 1 Then
	Exit Do
Else 
	Timer = Timer + 1
	Delay 500
End If
Loop While Timer < MaxTimer

If Timer >= MaxTimer Then 
	TracePrint "(ClickAbility)Exit"
	Exit Function
End If

Tap 71, 978
Delay ClickDelay

TracePrint "(ClickAbility)Success"
End Function

/////////////////////////////////////////////////////////////

Function ClickAuto()
Dim Timer
Dim result
result = CmpColorEx("86|1234|FFFFFF", 0.9)
Timer = 0
Do
If result = 0 Then 
	Exit Do
Else 
	Tap 86, 1234
	Timer = Timer + 1
	Delay ClickDelay
End If
Loop While Timer < MaxTimer

If Timer >= MaxTimer Then 
	TracePrint "(ClickAuto)Exit"
	Exit Function
End If

	TracePrint "(ClickAuto)Success"
End Function

/////////////////////////////////////////////////////////////
