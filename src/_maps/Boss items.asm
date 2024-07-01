; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_A2xNg:	
		dc.w SME_A2xNg_10-SME_A2xNg, SME_A2xNg_16-SME_A2xNg	
		dc.w SME_A2xNg_1C-SME_A2xNg, SME_A2xNg_22-SME_A2xNg	
		dc.w SME_A2xNg_28-SME_A2xNg, SME_A2xNg_2E-SME_A2xNg	
		dc.w SME_A2xNg_43-SME_A2xNg, SME_A2xNg_4E-SME_A2xNg	
SME_A2xNg_10:	dc.b 1	
		dc.b $F8, 5, 0, 0, $F8	
SME_A2xNg_16:	dc.b 1	
		dc.b $F8, 5, 0, 0, $F8	
SME_A2xNg_1C:	dc.b 1	
		dc.b $FC, 0, 0, 6, $FC	
SME_A2xNg_22:	dc.b 1	
		dc.b $14, 9, 0, 7, $F4	
SME_A2xNg_28:	dc.b 1	
		dc.b $14, 5, 0, $D, $F8	
SME_A2xNg_2E:	dc.b 4	
		dc.b $F0, 4, 0, $11, $F8	
		dc.b $F8, 1, 0, $13, $F8	
		dc.b $F8, 1, 8, $13, 0	
		dc.b 8, 4, 0, $15, $F8	
SME_A2xNg_43:	dc.b 2	
		dc.b 0, 5, 0, $17, 0	
		dc.b 0, 0, 0, $1B, $10	
SME_A2xNg_4E:	dc.b 2	
		dc.b $18, 4, 0, $1C, 0	
		dc.b 0, $B, 0, $1E, $10	
		even