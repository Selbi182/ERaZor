; --------------------------------------------------------------------------------
; Sprite mappings - output from ClownMapEd - Sonic 1/CD format
; --------------------------------------------------------------------------------

SYZPlatformMaps:
	dc.w	SYZPlatform_Frame0-SYZPlatformMaps
	dc.w	SYZPlatform_Frame1-SYZPlatformMaps
	dc.w	SYZPlatform_Frame2-SYZPlatformMaps

SYZPlatform_Frame0:

	dc.b	12

	dc.b	-9
	dc.b	$07
	dc.w	$0004
	dc.b	-16

	dc.b	-9
	dc.b	$07
	dc.w	$0014
	dc.b	0

	dc.b	-9
	dc.b	$00
	dc.w	$0000
	dc.b	-48

	dc.b	-9
	dc.b	$00
	dc.w	$0008
	dc.b	-40

	dc.b	-9
	dc.b	$00
	dc.w	$0008
	dc.b	-32

	dc.b	-9
	dc.b	$00
	dc.w	$0008
	dc.b	-24

	dc.b	15
	dc.b	$00
	dc.w	$0003
	dc.b	-24

	dc.b	-9
	dc.b	$00
	dc.w	$0008
	dc.b	16

	dc.b	-9
	dc.b	$00
	dc.w	$0008
	dc.b	24

	dc.b	-9
	dc.b	$00
	dc.w	$0008
	dc.b	32

	dc.b	15
	dc.b	$00
	dc.w	$001F
	dc.b	16

	dc.b	-9
	dc.b	$00
	dc.w	$001C
	dc.b	40

SYZPlatform_Frame1:
	dc.b	3

	dc.b	-60
	dc.b	$06
	dc.w	$0020
	dc.b	-8

	dc.b	-56
	dc.b	$06
	dc.w	$0020
	dc.b	-32

	dc.b	-56
	dc.b	$06
	dc.w	$0020
	dc.b	16

SYZPlatform_Frame2:
	dc.b	3

	dc.b	-6
	dc.b	$06
	dc.w	$0020
	dc.b	-8

	dc.b	-2
	dc.b	$06
	dc.w	$0020
	dc.b	-32

	dc.b	-2
	dc.b	$06
	dc.w	$0020
	dc.b	16

	even
