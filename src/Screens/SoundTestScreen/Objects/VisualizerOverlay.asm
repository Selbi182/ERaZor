
; -----------------------------------------------------------------------------
; Overlay layer for visualizer (with higlight and octave separators)
; -----------------------------------------------------------------------------

SoundTest_Obj_VisualizerOverlay:
	SoundTest_CreateChildObject #@Init	; generate secondary sprite (becase we can't cover more than 256 pixels)
	move.w	#$80+3*8-4+$80, obX(a0)		; X-position for the main sprite
	move.w	#$80+3*8-4+$80+$80, obX(a1)	; X-position for the secondary sprite
	move.b	#1, obFrame(a1)			; set secondary sprite frame

@Init:
	move.w	#(SoundTest_UIBorderOverlay_VRAM/$20)|$6000, obGfx(a0)
	move.l	#@SpriteMappings, obMap(a0)
	move.b	#0, obPriority(a0)
	move.w	#$80+5*8-8, obScreenY(a0)
	move.l	#@Display, obCodePtr(a0)

; -----------------------------------------------------------------------------
@Display:
	move.b	SoundTest_FadeCounter, d0	; are we fading out?
	bne.s	@Ret				; if yes, branch
	jmp	DisplaySprite

@Ret:	rts

; -----------------------------------------------------------------------------
; Visualizer overlay: Sprite mappings
; -----------------------------------------------------------------------------

@SpriteMappings:
	dc.w	@Frame1-@SpriteMappings
	dc.w	@Frame2-@SpriteMappings

@Frame1:
	dc.b	8*4
	@y: = 0
	rept 4
		dc.b	@y, $F, 0, 4*2, -$80
		dc.b	@y, $F, 0, 4*1, -$60
		dc.b	@y, $F, 0, 0, -$40
		dc.b	@y, $F, 0, 4*4, -$20
		dc.b	@y, $F, 0, 4*3, 0
		dc.b	@y, $F, 0, 4*2, $20
		dc.b	@y, $F, 0, 4*1, $40
		dc.b	@y, $F, 0, 0, $60
		@y: = @y + $20
	endr

@Frame2:
	dc.b	4
	@y: = 0
	rept 4
		dc.b	@y, %1011, 0, 4*4, 0
		@y: = @y + $20
	endr
	even
