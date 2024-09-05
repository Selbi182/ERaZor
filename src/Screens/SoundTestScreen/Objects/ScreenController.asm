
SoundTest_Obj_ScreenController:
	
	move.b	#$81, $30(a0)
	move.l	#@Main, $3C(a0)

@Main:
	move.b	Joypad|Press, d0

	btst	#iRight, d0
	beq.s	@0
	addq.b	#1, $30(a0)
	KDebug.WriteLine "Music %<.b $30(a0)>"
	rts

@0	btst	#iLeft, d0
	beq.s	@1
	subq.b	#1, $30(a0)
	KDebug.WriteLine "Music %<.b $30(a0)>"
	rts

@1:	btst	#iC, d0
	beq.s	@ret
	move.b	$30(a0), d0
	jmp	PlaySound_Special

@ret	rts
