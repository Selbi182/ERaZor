; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_s_ima:	
		dc.w SME_s_ima_1A-SME_s_ima, SME_s_ima_2A-SME_s_ima	
		dc.w SME_s_ima_3A-SME_s_ima, SME_s_ima_4A-SME_s_ima	
		dc.w SME_s_ima_5A-SME_s_ima, SME_s_ima_6A-SME_s_ima	
		dc.w SME_s_ima_7A-SME_s_ima, SME_s_ima_85-SME_s_ima	
		dc.w SME_s_ima_90-SME_s_ima, SME_s_ima_96-SME_s_ima	
		dc.w SME_s_ima_9C-SME_s_ima, SME_s_ima_A2-SME_s_ima	
		dc.w SME_s_ima_A8-SME_s_ima	
SME_s_ima_1A:	dc.b 3	
		dc.b $F1, $A, 0, 0, $F4	
		dc.b 9, 8, 0, $12, $F4	
		dc.b $E7, 1, 0, $21, $FC	
SME_s_ima_2A:	dc.b 3	
		dc.b $F1, $A, 0, 9, $F4	
		dc.b 9, 8, 0, $12, $F4	
		dc.b $E7, 1, 0, $21, $FC	
SME_s_ima_3A:	dc.b 3	
		dc.b $F0, $A, 0, 0, $F4	
		dc.b 8, 8, 0, $15, $F4	
		dc.b $E6, 1, 0, $21, $FC	
SME_s_ima_4A:	dc.b 3	
		dc.b $F1, $A, 0, 9, $F4	
		dc.b 9, 8, 0, $18, $F4	
		dc.b $E7, 1, 0, $21, $FC	
SME_s_ima_5A:	dc.b 3	
		dc.b $F0, $A, 0, 0, $F4	
		dc.b 8, 8, 0, $1B, $F4	
		dc.b $E6, 1, 0, $21, $FC	
SME_s_ima_6A:	dc.b 3	
		dc.b $F1, $A, 0, 9, $F4	
		dc.b 9, 8, 0, $1E, $F4	
		dc.b $E7, 1, 0, $21, $FC	
SME_s_ima_7A:	dc.b 2	
		dc.b $F1, $A, 0, 0, $F4	
		dc.b 9, 8, 0, $12, $F4	
SME_s_ima_85:	dc.b 2	
		dc.b $F1, $A, 0, 9, $F4	
		dc.b 9, 8, 0, $12, $F4	
SME_s_ima_90:	dc.b 1	
		dc.b $E7, 1, 0, $23, $FC	
SME_s_ima_96:	dc.b 1	
		dc.b $E7, 1, 0, $25, $FC	
SME_s_ima_9C:	dc.b 1	
		dc.b $FC, 0, 0, $27, $FC	
SME_s_ima_A2:	dc.b 1	
		dc.b $FC, 0, 0, $28, $FC	
SME_s_ima_A8:	dc.b 1	
		dc.b $E7, 1, 0, $21, $FC	
		even