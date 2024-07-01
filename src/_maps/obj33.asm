; ---------------------------------------------------------------------------
; Sprite mappings - pushable blocks (MZ, LZ)
; ---------------------------------------------------------------------------
		dc.w byte_C2EA-Map_obj33
		dc.w byte_C2F0-Map_obj33
byte_C2EA:	dc.b 1
		dc.b $F0, $F, 0, 8, $F0	; single block
byte_C2F0:	dc.b 4
		dc.b $F0, $F, 0, 8, $C0	; row of 4 blocks
		dc.b $F0, $F, 0, 8, $E0
		dc.b $F0, $F, 0, 8, 0
		dc.b $F0, $F, 0, 8, $20
		even