; ===========================================================================
; ---------------------------------------------------------------------------
; Starting Locations for levels
; ---------------------------------------------------------------------------

		dc.w	$0010, $0020	; GHZ 1 (Night Hill Place)
		dc.w	$0000, $01AC	; GHZ 2 (Intro Sequence)
		dc.w	$2630, $03AC	; GHZ 3 (Green Hill Place)
		dc.w	$0080, $00A8	; ghz 4

		dc.w	$0078, $006E	; lz 1
		dc.w	$02B0, $0160	; LZ 2 (Labyrinthy Place)
		dc.w	$00B4, $078C	; LZ 2 (Labyrinthy Place fast forward)
		dc.w	$0B80, $0000	; lz 4

		dc.w	$01AF+SCREEN_XCORR, $026C	; MZ 1 (Ruined Place)
		dc.w	$009C, $0264	; mz 2
		dc.w	$004F, $000F	; mz 3
		dc.w	$0080, $00A8	; mz 4

		dc.w	$0038, $02CE	; slz 1 (Special Place, loaded elsewhere)
		dc.w	$0034, $014E	; SLZ 2 (Scar Night Place)
		dc.w	$0B00, $036C	; SLZ 3 (Star Agony Place)
		dc.w	$0080, $00A8	; slz 4

		dc.w	$0380, $0060	; SYZ 1 (Uberhub casual)
		dc.w	$008E, $0030	; SYZ 1 (Uberhub frantic)
		dc.w	$0038, $00EE	; syz 3
		dc.w	$0080, $00A8	; syz 4

		dc.w	$01A0, $0160	; sbz 1 (Bomb Machine Cutscene, start loc irrelevant)
		dc.w	$0180, $068C	; SBZ 2 (Tutorial Place)
		dc.w	$0B86, $05AC	; SBZ 3 (Finalor Place)
		dc.w	$0080, $00A8	; sbz 4

		dc.w	$0620, $016B	; Unknown
		dc.w	$1030, $026C	; Ending Sequence
		dc.w	$0080, $00A8	; Null
		dc.w	$0080, $00A8	; Null
		even
; ---------------------------------------------------------------------------
; ===========================================================================