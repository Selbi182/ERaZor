
; ===========================================================================
; ---------------------------------------------------------------------------
; V-blanking routine
; ---------------------------------------------------------------------------

; loc_B10:
VBlank:				; XREF: StartOfRom
		movem.l	d0-a6,-(sp)

		tst.b	VBlank_MusicOnly		; is "music only" flag set (effectively disabled VBlank, only SMPS works)
		bne.s	VBlank_Exit			; if yes, skip all of VBlank

		bsr.w	BlackBars.VBlankUpdate

		tst.b	VBlankRoutine			; are we lagging (VBlank unwanted, interrupted game loop)
		beq.w	VBlank_LagFrame			; if yes, oh shit oh fuck, go to the emergency routine immediately

		move.l	VBlankCallback, d0
		beq.s	@callback_ok
		movea.l	d0, a0
		moveq	#0, d0
		move.l	d0, VBlankCallback
		jsr	(a0)
	@callback_ok:

		addq.l	#1, VBlank_NonLagFrameCounter
		move.w	VDP_Ctrl,d0
		move.l	#$40000010,VDP_Ctrl
		move.l	($FFFFF616).w,($C00000).l
		btst	#6,($FFFFFFF8).w		; are we PAL?
		beq.s	loc_B42				; if not, branch
		move.w	#$700,d0
		dbf	d0, *				; waste ~$700 * 10 cycles on PAL consoles

loc_B42:
		move.b	VBlankRoutine,d0
		andi.w	#$3E,d0
		move.w	VBlankTable(pc,d0.w),d0
		jsr	VBlankTable(pc,d0.w)

; loc_B5E:
VBlank_Exit:				; XREF: VBlank_LagFrame
		move.b	#0,VBlankRoutine
	if def(__BENCHMARK__)=0
		bsr.s	UpdateSoundDriver	; update sound driver stuff now
	endif
		addq.l	#1,VBlank_FrameCounter	; increase 1 to V-Blank counter
		movem.l	(sp)+,d0-a6
		rte	
; ===========================================================================
	; Benchmark builds exclude SMPS for timing consistency
	if def(__BENCHMARK__)=0
UpdateSoundDriver:
		ints_enable			; enable interrupts (we can accept horizontal interrupts from now on)
		tst.b	($FFFFF64F).w		; is SMPS currently running?
		bne.s	@end			; if yes, branch
		move.b	#1,($FFFFF64F).w	; set "SMPS running flag"
		jsr	SoundDriverUpdate	; run SMPS
		clr.b	($FFFFF64F).w		; reset "SMPS running flag"
@end:		rts
	endif

; ===========================================================================
VBlankTable:	dc.w VBlank_LagFrame-VBlankTable	; $00
		dc.w loc_C32-VBlankTable	; $02
		dc.w loc_C44-VBlankTable	; $04
		dc.w loc_C5E-VBlankTable	; $06
		dc.w VBlank_Level-VBlankTable	; $08 (main one for levels)
		dc.w loc_DA6-VBlankTable	; $0A
		dc.w loc_E72-VBlankTable	; $0C
		dc.w loc_F8A-VBlankTable	; $0E
		dc.w loc_C64-VBlankTable	; $10 (pause)
		dc.w loc_F9A-VBlankTable	; $12
		dc.w loc_C36-VBlankTable	; $14
		dc.w loc_FA6-VBlankTable	; $16
		dc.w loc_E72-VBlankTable	; $18
	        dc.w VSelbiScreen-VBlankTable	; $1A
	        dc.w VStoryScreen-VBlankTable	; $1C
; ===========================================================================

; loc_B88:
VBlank_LagFrame:				; XREF: VBlank; VBlankTable
		cmpi.b	#$8C,(GameMode).w
		beq.s	loc_B9A
		cmpi.b	#$C,(GameMode).w	; are we in the level game mode?
		bne.w	VBlank_Exit		; if not, branch

loc_B9A:
		cmpi.b	#1, CurrentZone		; are we LZ?	; is level LZ?
		bne.w	VBlank_Exit		; if not, branch

		move.w	VDP_Ctrl,d0
		btst	#6,($FFFFFFF8).w
		beq.s	loc_BBA
		move.w	#$700,d0
		dbf	d0,*

loc_BBA:
		tst.b	($FFFFF64E).w
		bne.s	loc_BFE
		lea	VDP_Ctrl,a5
		move.l	#$94009340,(a5)
		move.l	#$96FD9580,(a5)
		move.w	#$977F,(a5)
		move.w	#$C000,(a5)
		move.w	#$80,-(sp)
		move.w	(sp)+,(a5)
		bra.s	loc_C22
; ===========================================================================

loc_BFE:				; XREF: loc_BC8
		lea	VDP_Ctrl,a5
		move.l	#$94009340,(a5)
		move.l	#$96FD9540,(a5)
		move.w	#$977F,(a5)
		move.w	#$C000,(a5)
		move.w	#$80,-(sp)
		move.w	(sp)+,(a5)

loc_C22:				; XREF: loc_BC8
		cmpi.b	#1, CurrentZone		; are we LZ?
		bne.s	@0
		move.w	($FFFFF624).w,(a5)
@0:		move.b	($FFFFF625).w,($FFFFFE07).w

		bra.w	VBlank_Exit
; ===========================================================================

loc_C32:				; XREF: VBlankTable
		bsr	UpdateFrame
		cmpi.b	#1, CurrentZone		; are we LZ?
		bne.s	@0
		move.w	($FFFFF624).w,(a5)
@0:		move.b	($FFFFF625).w,($FFFFFE07).w


loc_C36:				; XREF: VBlankTable
		tst.w	($FFFFF614).w
		beq.w	locret_C42
		subq.w	#1,($FFFFF614).w

locret_C42:
		rts	
; ===========================================================================

loc_C44:				; XREF: VBlankTable
		bsr	UpdateFrame
		cmpi.b	#1, CurrentZone		; are we LZ?
		bne.s	@0
		move.w	($FFFFF624).w,(a5)
@0:		move.b	($FFFFF625).w,($FFFFFE07).w

		jsr 	ExecuteDrawRequests
		tst.w	($FFFFF614).w
		beq.w	locret_C5C
		subq.w	#1,($FFFFF614).w

locret_C5C:
		rts	
; ===========================================================================

loc_C5E:				; XREF: VBlankTable
		bsr	UpdateFrame
		cmpi.b	#1, CurrentZone		; are we LZ?
		bne.s	@0
		move.w	($FFFFF624).w,(a5)
@0:		move.b	($FFFFF625).w,($FFFFFE07).w

		rts	
; ===========================================================================

loc_C64:				; XREF: VBlankTable
		cmpi.b	#$10,(GameMode).w ; is	game mode = $10	(special stage)	?
		beq.w	loc_DA6		; if yes, branch

;loc_C6E:				; XREF: VBlankTable
VBlank_Level:
		bsr	ReadJoypads
		tst.b	($FFFFF64E).w
		bne.s	loc_CB0
		lea	VDP_Ctrl,a5
		move.l	#$94009340,(a5)
		move.l	#$96FD9580,(a5)
		move.w	#$977F,(a5)
		move.w	#$C000,(a5)
		move.w	#$80,-(sp)
		move.w	(sp)+,(a5)
		bra.s	loc_CD4
; ===========================================================================

loc_CB0:				; XREF: loc_C76
		lea	VDP_Ctrl,a5
		move.l	#$94009340,(a5)
		move.l	#$96FD9540,(a5)
		move.w	#$977F,(a5)
		move.w	#$C000,(a5)
		move.w	#$80,-(sp)
		move.w	(sp)+,(a5)

loc_CD4:				; XREF: loc_C76
		cmpi.b	#1, CurrentZone		; are we LZ?
		bne.s	@0
		move.w	($FFFFF624).w,(a5)
@0:		move.b	($FFFFF625).w,($FFFFFE07).w

		lea	VDP_Ctrl,a5
		move.l	#$940193C0,(a5)
		move.l	#$96E69500,(a5)
		move.w	#$977F,(a5)
		move.w	#$7C00,(a5)
		move.w	#$83,-(sp)
		move.w	(sp)+,(a5)

		lea	VDP_Ctrl,a5
		move.l	#$94019340,(a5)
		move.l	#$96FC9500,(a5)
		move.w	#$977F,(a5)
		move.w	#$7800,(a5)
		move.w	#$83,-(sp)
		move.w	(sp)+,(a5)
		jsr	(ProcessDMAQueue).l

loc_D50:

;Demo_Time:
		jsr 	ExecuteDrawRequests
		jsr	HudUpdate
		rts
; End of function Demo_Time

; ===========================================================================

loc_DA6:				; XREF: VBlankTable
		bsr	ReadJoypads
		lea	VDP_Ctrl,a5
		move.l	#$94009340,(a5)
		move.l	#$96FD9580,(a5)
		move.w	#$977F,(a5)
		move.w	#$C000,(a5)
		move.w	#$80,-(sp)
		move.w	(sp)+,(a5)
		lea	VDP_Ctrl,a5
		move.l	#$94019340,(a5)
		move.l	#$96FC9500,(a5)
		move.w	#$977F,(a5)
		move.w	#$7800,(a5)
		move.w	#$83,-(sp)
		move.w	(sp)+,(a5)
		lea	VDP_Ctrl,a5
		move.l	#$940193C0,(a5)
		move.l	#$96E69500,(a5)
		move.w	#$977F,(a5)
		move.w	#$7C00,(a5)
		move.w	#$83,-(sp)
		move.w	(sp)+,(a5)
		bsr	PalCycle_SS
		jsr	(ProcessDMAQueue).l

loc_E64:
		tst.w	($FFFFF614).w
		beq.w	locret_E70
		subq.w	#1,($FFFFF614).w

locret_E70:
		rts	
; ===========================================================================

loc_E72:				; XREF: VBlankTable
		bsr	ReadJoypads
		tst.b	($FFFFF64E).w
		bne.s	loc_EB4
		lea	VDP_Ctrl,a5
		move.l	#$94009340,(a5)
		move.l	#$96FD9580,(a5)
		move.w	#$977F,(a5)
		move.w	#$C000,(a5)
		move.w	#$80,-(sp)
		move.w	(sp)+,(a5)
		bra.s	loc_ED8
; ===========================================================================

loc_EB4:				; XREF: loc_E7A
		lea	VDP_Ctrl,a5
		move.l	#$94009340,(a5)
		move.l	#$96FD9540,(a5)
		move.w	#$977F,(a5)
		move.w	#$C000,(a5)
		move.w	#$80,-(sp)
		move.w	(sp)+,(a5)

loc_ED8:				; XREF: loc_E7A
		cmpi.b	#1, CurrentZone		; are we LZ?
		bne.s	@0
		move.w	($FFFFF624).w,(a5)
@0:		move.b	($FFFFF625).w,($FFFFFE07).w

		lea	VDP_Ctrl,a5
		move.l	#$940193C0,(a5)
		move.l	#$96E69500,(a5)

loc_EEE:
		move.w	#$977F,(a5)
		move.w	#$7C00,(a5)
		move.w	#$83,-(sp)
		move.w	(sp)+,(a5)
		lea	VDP_Ctrl,a5
		move.l	#$94019340,(a5)
		move.l	#$96FC9500,(a5)
		move.w	#$977F,(a5)
		move.w	#$7800,(a5)
		move.w	#$83,-(sp)
		move.w	(sp)+,(a5)
		jsr	(ProcessDMAQueue).l

loc_F54:
		jsr 	ExecuteDrawRequests
		jsr	HudUpdate
		rts	
; ===========================================================================

loc_F8A:				; XREF: VBlankTable
		bsr	UpdateFrame
		cmpi.b	#1, CurrentZone		; are we LZ?
		bne.s	@0
		move.w	($FFFFF624).w,(a5)
@0:		move.b	($FFFFF625).w,($FFFFFE07).w

		addq.b	#1,($FFFFF628).w
		move.b	#$E,VBlankRoutine
		rts	
; ===========================================================================

loc_F9A:				; XREF: VBlankTable
		bsr	UpdateFrame
		cmpi.b	#1, CurrentZone		; are we LZ?
		bne.s	@0
		tst.b	($FFFFFFE9).w		; is fade out currently in progress?
		bne.s	@1			; if yes, branch
		move.w	($FFFFF624).w,(a5)
@0:		move.b	($FFFFF625).w,($FFFFFE07).w
@1:
		rts
; ===========================================================================

loc_FA6:				; XREF: VBlankTable
		bsr	ReadJoypads
		lea	VDP_Ctrl,a5
		move.l	#$94009340,(a5)
		move.l	#$96FD9580,(a5)
		move.w	#$977F,(a5)
		move.w	#$C000,(a5)
		move.w	#$80,-(sp)
		move.w	(sp)+,(a5)
		lea	VDP_Ctrl,a5
		move.l	#$94019340,(a5)
		move.l	#$96FC9500,(a5)
		move.w	#$977F,(a5)
		move.w	#$7800,(a5)
		move.w	#$83,-(sp)
		move.w	(sp)+,(a5)
		lea	VDP_Ctrl,a5
		move.l	#$940193C0,(a5)
		move.l	#$96E69500,(a5)
		move.w	#$977F,(a5)
		move.w	#$7C00,(a5)
		move.w	#$83,-(sp)
		move.w	(sp)+,(a5)
		jsr	(ProcessDMAQueue).l

loc_1060:
		tst.w	($FFFFF614).w
		beq.w	locret_106C
		subq.w	#1,($FFFFF614).w

locret_106C:
		rts	
; ===========================================================================

VSelbiScreen:
		bsr	ReadJoypads
		lea    VDP_Ctrl,a5
		move.l    #$94009340,(a5)
		move.l    #$96FD9580,(a5)
		move.w    #$977F,(a5)
		move.w    #$C000,(a5)
		move.w    #$80,-(sp)
		move.w    (sp)+,(a5)
		tst.w    ($FFFFF614).w
		beq.s    @NoTimer
		subq.w    #1,($FFFFF614).w

@NoTimer:
		rts    
; ===========================================================================

VStoryScreen:
		jsr	StoryScreen_UpdateFromVBlank
		jmp	UpdateFrame

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


UpdateFrame:				; XREF: loc_C32; et al
		bsr	ReadJoypads
		tst.b	($FFFFF64E).w
		bne.s	loc_10B0
		lea	VDP_Ctrl,a5
		move.l	#$94009340,(a5)
		move.l	#$96FD9580,(a5)
		move.w	#$977F,(a5)
		move.w	#$C000,(a5)
		move.w	#$80,-(sp)
		move.w	(sp)+,(a5)
		bra.s	loc_10D4
; ===========================================================================

loc_10B0:				; XREF: UpdateFrame
		lea	VDP_Ctrl,a5
		move.l	#$94009340,(a5)
		move.l	#$96FD9540,(a5)
		move.w	#$977F,(a5)
		move.w	#$C000,(a5)
		move.w	#$80,-(sp)
		move.w	(sp)+,(a5)

loc_10D4:				; XREF: UpdateFrame
		lea	VDP_Ctrl,a5
		move.l	#$94019340,(a5)
		move.l	#$96FC9500,(a5)
		move.w	#$977F,(a5)
		move.w	#$7800,(a5)
		move.w	#$83,-(sp)
		move.w	(sp)+,(a5)
		lea	VDP_Ctrl,a5
		move.l	#$940193C0,(a5)
		move.l	#$96E69500,(a5)
		move.w	#$977F,(a5)
		move.w	#$7C00,(a5)
		move.w	#$83,-(sp)
		move.w	(sp)+,(a5)
		jsr	(ProcessDMAQueue).l
		rts	
; End of function UpdateFrame