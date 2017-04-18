// Role & Skill
// 1 || 2
// 3 || 4
// 5 || 6
Dim Skill1stIconPX = 60, Skill1stIconPY = 850
Dim Skill2ndIconPX = 410, Skill2ndIconPY = 850
Dim Skill3rdIconPX = 60, Skill3rdIconPY = 970
Dim Skill4thIconPX = 410, Skill4thIconPY = 970
Dim Skill5thIconPX = 60, Skill5thIconPY = 850
Dim Skill6thIconPX = 410, Skill6thIconPY = 1090

Dim Role1stIconPX = 140, Role1stIconPY = 850
Dim Role2ndIconPX = 440, Role2ndIconPY = 850
Dim Role3rdIconPX = 140, Role3rdIconPY = 980
Dim Role4thIconPX = 440, Role4thIconPY = 980
Dim Role5thIconPX = 140, Role5thIconPY = 1110
Dim Role6thIconPX = 440, Role6thIconPY = 1110

Dim MaxTimer = 30
Dim MaxGoingRound = 15
Dim ClickDelay = 500

Dim FirstMapCount = 10
Dim SecondMapCount = 15

Dim ChangeMap = false

Dim Xon = 2
Dim XonWaylay = 4
Dim SummonRole = 1

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
  Dim Count
  Count = 0
  Do
  Call MovingSecondMap()
  If ChangeMap = true Then 
  		ChangeMap = false
    	Exit Function
   End If
  Call XonAttack()
  Count = Count + 1
  Loop While Count < SecondMapCount
End Function
/////////////////////////////////////////////////////////////
Function ExploreFirstMap()
  Dim Count
  
  Count = 0
  Do
    Call MovingFirstMap()
    If ChangeMap = true Then 
    	ChangeMap = false
    	Exit Function
    End If
    Call XonAttack()
    Count = Count + 1
  Loop While Count < FirstMapCount
End Function
/////////////////////////////////////////////////////////////
Function XonAttack()
Dim Summon = false
  Call SlideSkill(Xon)
  Delay 500
  // summon can't evoke 404|848|0808FF
  If CmpColorEx("404|848|0808FF", 0.9) = 0 Then 
  	Summon = true
  	TracePrint "(XonAttack)Can EvokeSummon now"
  End If
  
  Call ClickSkill(XonWaylay)
  Delay 500
  If Summon = true Then 
  	EvokeSummon (SummonRole)
  	Summon = false
  	TracePrint "(XonAttack)EvokeSummon"
  End If
  
  //ClickRole(Xon)
  //Delay 500
  
  // ClickAuto
  Tap 86, 1234
  Delay ClickDelay
  Call WaitFinishedFight()
End Function
/////////////////////////////////////////////////////////////
Function MovingFirstMap()
  Dim result
  Dim Timer
  TracePrint "(MovingFirstMap)Start"
  Timer = 0
  Do
    result = CmpColorEx("537|1247|72BFE6", 0.9)
    If result = 1 Then 
      Call MovingDown(151,215, "4FE8FF")
      call MovingUp (152, 160, "4FE8FF")
    Else 
   	  MovingUp (152,154, "4D2E8E")
      Exit Do
    End If
    Timer = Timer + 1
  Loop While Timer < MaxGoingRound
  
  If Timer >= MaxGoingRound Then 
	ChangeMap = true
	TracePrint "(MovingFirstMap)ChangeMap = true"
End If

  TracePrint "(MovingFirstMap)Success"
End Function
/////////////////////////////////////////////////////////////
Function MovingSecondMap()
Dim result
Dim Timer
TracePrint "(MovingSecondMap)Start"
Timer = 0
Do
	result = CmpColorEx("537|1247|72BFE6", 0.9)
	If result = 1 Then 
	MovingUp (120,190, "9A5D1D")
	MovingDown(152, 271, "50E8FF")
	Else 
	Exit Do
	End If
	Timer = Timer + 1
Loop While Timer < MaxGoingRound

If Timer >= MaxGoingRound Then 
	ChangeMap = true
	TracePrint "(MovingSecondMap)ChangeMap = true"
End If

TracePrint "(MovingSecondMap)Success"
End Function
/////////////////////////////////////////////////////////////
Function MovingUp(px, py, color)
  Dim cmpclr = px & "|" & py & "|" & color
  TracePrint "(MovingUp)"
  If CmpColorEx(cmpclr, 0.8) = 1 Then 
  Exit Function
  End If
  TouchDown 358,848, 1
  TouchMove 358, 448, 1, 50
  Do
  If CmpColorEx(cmpclr, 0.8) = 1 Then 
  Exit Do
  End If
  If CmpColorEx("537|1247|72BFE6", 0.8) = 0 Then 
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
  If CmpColorEx(cmpclr, 0.8) = 1 Or CmpColorEx("360|1263|678FBF", 0.9) = 1 Then
    Exit Function
  End If
  TouchDown 358,448, 1
  TouchMove 358, 848, 1, 50
  Do
  If CmpColorEx(cmpclr, 0.8) = 1 Or CmpColorEx("165|206|4EE8FF", 0.9) = 1 Then
    Exit Do
  End If
  If CmpColorEx("537|1247|72BFE6", 0.8) = 0 Then 
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
Dim WaitTimer = 40
Dim msg

Timer = 0

Do
msg = "(WaitFinishedFight)Waitting..." & Timer & " secs"
TracePrint msg
	If CmpColorEx("290|647|FFF7EE", 0.9) = 1 And CmpColorEx("430|647|FFF7EE", 0.9) = 1 And CmpColorEx("311|406|FFF7EE", 0.9) = 1 Then 
		Exit Do
	Else 
		Delay 1000
		Timer = Timer + 1
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
Function SlideSkill(RoleNumber)
  Dim Timer
  Dim pX, pY
  If RoleNumber = 1 Then 
  	pX = Role1stIconPX
  	pY = Role1stIconPY
  ElseIf RoleNumber = 2 Then
  	pX = Role2ndIconPX
  	pY = Role2ndIconPY
  ElseIf RoleNumber = 3 Then
  	pX = Role3rdIconPX
  	pY = Role3rdIconPY
  ElseIf RoleNumber = 4 Then
  	pX = Role4thIconPX
  	pY = Role4thIconPY
  ElseIf RoleNumber = 5 Then
  	pX = Role5thIconPX
  	pY = Role5thIconPY
  ElseIf RoleNumber = 6 Then
  	pX = Role6thIconPX
  	pY = Role6thIconPY
  End If
  
  // Role 4th's sword 379,909, FFFFFF
  // Role 2nd's sword 379,780, FFFFFF
  
  Timer = 0
  // Wait into fight scane
  Do
  If CmpColorEx("384|898|494949", 0.9) = 1 Then 
    Exit Do 
  Else 
    Timer = Timer + 1
    Delay 500
  End If
  Loop While Timer < MaxTimer

  If Timer >= MaxTimer Then 
    TracePrint "(SlideSkill)Exit"
    Exit Function
  End If

  // Slide to skill
  // Role MP 588|759|DAC2B3
  Timer = 0
  Do
  TouchDown pX, pY, 1
  TouchMove pX + 150, pY, 1, 200
  If CmpColorEx("588|759|DAC2B3", 0.9) = 1 Then 
  	Exit Do
  Else 
  	Timer = Timer + 1
  End If
  Loop While Timer < MaxTimer
  
  If Timer >= MaxTimer Then 
    TracePrint "(SlideSkill)Exit"
    Exit Function
  End If

  TracePrint "(SlideSkill)Success"
End Function
/////////////////////////////////////////////////////////////
Function ClickRole(RoleNumber)
Dim pX, pY
TracePrint "(ClickRole)RoleNumber = " & RoleNumber 
  If RoleNumber = 1 Then 
  	pX = Role1stIconPX
  	pY = Role1stIconPY
  ElseIf RoleNumber = 2 Then
  	pX = Role2ndIconPX
  	pY = Role2ndIconPY
  ElseIf RoleNumber = 3 Then
  	pX = Role3rdIconPX
  	pY = Role3rdIconPY
  ElseIf RoleNumber = 4 Then
  	pX = Role4thIconPX
  	pY = Role4thIconPY
  ElseIf RoleNumber = 5 Then
  	pX = Role5thIconPX
  	pY = Role5thIconPY
  ElseIf RoleNumber = 6 Then
  	pX = Role6thIconPX
  	pY = Role6thIconPY
  End If
  
  Tap pX, pY
  Delay ClickDelay
  
  End Function
Function ClickSkill(SkillNumber)
Dim Timer
Dim result
Dim pX, pY
TracePrint "(ClickSkill)SkillNumber = " & SkillNumber 
  If SkillNumber = 1 Then 
  	pX = Skill1stIconPX
  	pY = Skill1stIconPY
  ElseIf SkillNumber = 2 Then
  	pX = Skill2ndIconPX
  	pY = Skill2ndIconPY
  ElseIf SkillNumber = 3 Then
  	pX = Skill3rdIconPX
  	pY = Skill3rdIconPY
  ElseIf SkillNumber = 4 Then
  	pX = Skill4thIconPX
  	pY = Skill4thIconPY
  ElseIf SkillNumber = 5 Then
  	pX = Skill5thIconPX
  	pY = Skill5thIconPY
  ElseIf SkillNumber = 6 Then
  	pX = Skill6thIconPX
  	pY = Skill6thIconPY
  End If

// frame 384|898|494949
Timer = 0
Do
If CmpColorEx("384|898|494949", 0.9) = 1 Then 
Exit Do
Else 
Tap pX, pY
Delay ClickDelay
Timer = Timer + 1
End If
Loop While Timer < MaxTimer

If Timer >= MaxTimer Then 
    TracePrint "(ClickSkill)Exit"
    Exit Function
  End If

TracePrint "(ClickSkill)Success"
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
Function EvokeSummon(RoleNumber)
SlideSkill (RoleNumber)
Delay ClickDelay
ClickSkill (2)
Delay ClickDelay
//ClickRole (RoleNumber)
//Delay ClickDelay
End Function
