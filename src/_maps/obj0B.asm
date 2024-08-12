; --------------------------------------------------------------------------------
; Sprite mappings - output from ClownMapEd - Sonic 1/CD format
; --------------------------------------------------------------------------------

CME_1E40BFFC:
	dc.w	CME_1E40BFFC_0-CME_1E40BFFC
	dc.w	CME_1E40BFFC_1-CME_1E40BFFC

CME_1E40BFFC_0:
	dc.b	2

	dc.b	-32
	dc.b	$03
	dc.w	$0000
	dc.b	-4

	dc.b	0
	dc.b	$03
	dc.w	$1000
	dc.b	-4

CME_1E40BFFC_1:
	dc.b	4

	dc.b	-32
	dc.b	$00
	dc.w	$0000
	dc.b	-4

	dc.b	24
	dc.b	$00
	dc.w	$1000
	dc.b	-4

	dc.b	-28
	dc.b	$05
	dc.w	$0004
	dc.b	-4

	dc.b	12
	dc.b	$05
	dc.w	$1004
	dc.b	-4

	even
