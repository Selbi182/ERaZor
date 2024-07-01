; --------------------------------------------------------------------------------
; Sprite mappings - output from ClownMapEd - Sonic 1/CD format
; --------------------------------------------------------------------------------

MapObj0D_Offsets:
	dc.w	MapObj0D_Frame0-MapObj0D_Offsets
	dc.w	MapObj0D_Frame1-MapObj0D_Offsets
	dc.w	MapObj0D_Frame2-MapObj0D_Offsets
	dc.w	MapObj0D_Frame3-MapObj0D_Offsets
	dc.w	MapObj0D_Frame4-MapObj0D_Offsets

MapObj0D_Frame0:
	dc.b	2

	dc.b	-16
	dc.b	$0B
	dc.w	$0000
	dc.b	-24

	dc.b	-16
	dc.b	$0B
	dc.w	$0800
	dc.b	0

MapObj0D_Frame1:
	dc.b	1

	dc.b	-16
	dc.b	$0F
	dc.w	$000C
	dc.b	-16

MapObj0D_Frame2:
	dc.b	1

	dc.b	-16
	dc.b	$03
	dc.w	$001C
	dc.b	-4

MapObj0D_Frame3:
	dc.b	1

	dc.b	-16
	dc.b	$0F
	dc.w	$080C
	dc.b	-16

MapObj0D_Frame4:
	dc.b	2

	dc.b	-16
	dc.b	$0B
	dc.w	$0020
	dc.b	-24

	dc.b	-16
	dc.b	$0B
	dc.w	$002C
	dc.b	0

	even
