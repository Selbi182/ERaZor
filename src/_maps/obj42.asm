; ---------------------------------------------------------------------------
; Sprite mappings - Newtron enemy (GHZ)
; ---------------------------------------------------------------------------
		dc.w byte_DF58-Map_obj42, byte_DF68-Map_obj42
		dc.w byte_DF78-Map_obj42, byte_DF88-Map_obj42
		dc.w byte_DF9D-Map_obj42, byte_DFAD-Map_obj42
		dc.w byte_DFB8-Map_obj42, byte_DFC8-Map_obj42
		dc.w byte_DFD8-Map_obj42, byte_DFE8-Map_obj42
		dc.w byte_DFF8-Map_obj42
byte_DF58:	dc.b 3
		dc.b $EC, $D, 0, 0, $EC
		dc.b $F4, 0, 0,	8, $C
		dc.b $FC, $E, 0, 9, $F4
byte_DF68:	dc.b 3
		dc.b $EC, 6, 0,	$15, $EC
		dc.b $EC, 9, 0,	$1B, $FC
		dc.b $FC, $A, 0, $21, $FC
byte_DF78:	dc.b 3
		dc.b $EC, 6, 0,	$2A, $EC
		dc.b $EC, 9, 0,	$1B, $FC
		dc.b $FC, $A, 0, $21, $FC
byte_DF88:	dc.b 4
		dc.b $EC, 6, 0,	$30, $EC
		dc.b $EC, 9, 0,	$1B, $FC
		dc.b $FC, 9, 0,	$36, $FC
		dc.b $C, 0, 0, $3C, $C
byte_DF9D:	dc.b 3
		dc.b $F4, $D, 0, $3D, $EC
		dc.b $FC, 0, 0,	$20, $C
		dc.b 4,	8, 0, $45, $FC
byte_DFAD:	dc.b 2
		dc.b $F8, $D, 0, $48, $EC
		dc.b $F8, 1, 0,	$50, $C
byte_DFB8:	dc.b 3
		dc.b $F8, $D, 0, $48, $EC
		dc.b $F8, 1, 0,	$50, $C
		dc.b $FE, 0, 0,	$52, $14
byte_DFC8:	dc.b 3
		dc.b $F8, $D, 0, $48, $EC
		dc.b $F8, 1, 0,	$50, $C
		dc.b $FE, 4, 0,	$53, $14
byte_DFD8:	dc.b 3
		dc.b $F8, $D, 0, $48, $EC
		dc.b $F8, 1, 0,	$50, $C
		dc.b $FE, 0, $E0, $52, $14
byte_DFE8:	dc.b 3
		dc.b $F8, $D, 0, $48, $EC
		dc.b $F8, 1, 0,	$50, $C
		dc.b $FE, 4, $E0, $53, $14
byte_DFF8:	dc.b 0
		even