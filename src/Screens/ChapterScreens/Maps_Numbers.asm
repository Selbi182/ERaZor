; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_L9OMt:	
		dc.w SME_L9OMt_E-SME_L9OMt, SME_L9OMt_14-SME_L9OMt	
		dc.w SME_L9OMt_1F-SME_L9OMt, SME_L9OMt_2F-SME_L9OMt	
		dc.w SME_L9OMt_3A-SME_L9OMt, SME_L9OMt_40-SME_L9OMt	
		dc.w SME_L9OMt_4B-SME_L9OMt	
SME_L9OMt_E:	dc.b 1	
		dc.b $E0, 6, 0, 0, $F8	
SME_L9OMt_14:	dc.b 2	
		dc.b $E0, 6, 0, 0, $F0	
		dc.b $E0, 6, 0, 0, 0	
SME_L9OMt_1F:	dc.b 3	
		dc.b $E0, 6, 0, 0, $E8	
		dc.b $E0, 6, 0, 0, $F8	
		dc.b $E0, 6, 0, 0, 8	
SME_L9OMt_2F:	dc.b 2	
		dc.b $E0, $E, 0, 0, $EA	
		dc.b $E0, 2, 0, $C, $A	
SME_L9OMt_3A:	dc.b 1	
		dc.b $E0, $A, 0, 6, $F2	
SME_L9OMt_40:	dc.b 2	
		dc.b $E0, $A, 0, 6, $EA	
		dc.b $E0, 6, 0, 0, 6	
SME_L9OMt_4B:	dc.b 3	
		dc.b $E0, $A, 0, 6, $E2	
		dc.b $E0, 6, 0, 0, $FE	
		dc.b $E0, 6, 0, 0, $E	
		even