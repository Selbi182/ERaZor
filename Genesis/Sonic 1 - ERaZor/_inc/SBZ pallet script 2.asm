; ---------------------------------------------------------------------------
; Scrap Brain Zone 2 pallet cycling script
; ---------------------------------------------------------------------------
	dc.w 6
	dc.b 7,	8
	dc.w Pal_SBZCyc1
	dc.w $FB50
	dc.b $D, 8
	dc.w Pal_SBZCyc2
	dc.w $FB52
	dc.b 9,	8
	dc.w Pal_SBZCyc9
	dc.w $FB70
	dc.b 7,	8
	dc.w Pal_SBZCyc6
	dc.w $FB72
	dc.b 3,	3
	dc.w Pal_SBZCyc8
	dc.w $FB78
	dc.b 3,	3
	dc.w Pal_SBZCyc8+2
	dc.w $FB7A
	dc.b 3,	3
	dc.w Pal_SBZCyc8+4
	dc.w $FB7C
	dc.b 3, 8
	dc.w Pal_SBZCyc2
	dc.w $FB32
	even