; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_CHx9l:	
		dc.w SME_CHx9l_6-SME_CHx9l, SME_CHx9l_C-SME_CHx9l	
		dc.w SME_CHx9l_12-SME_CHx9l	
SME_CHx9l_6:	dc.b 1	
		dc.b $F0, $F, 0, 0, $F0	
SME_CHx9l_C:	dc.b 1	
		dc.b $F0, $F, 0, $10, $F0	
SME_CHx9l_12:	dc.b 2	
		dc.b $F0, $F, 0, $10, $F0	
		dc.b $D6, 5, 0, $20, $F8	
		even