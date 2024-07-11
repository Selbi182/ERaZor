; ---------------------------------------------------------------------------
; Animation script - Crabmeat enemy
; ---------------------------------------------------------------------------
		dc.w byte_972A-Ani_obj1F, byte_972E-Ani_obj1F, byte_9732-Ani_obj1F
		dc.w byte_9736-Ani_obj1F, byte_973C-Ani_obj1F, byte_9742-Ani_obj1F
		dc.w byte_9748-Ani_obj1F, byte_974C-Ani_obj1F, byte_kill1-Ani_obj1F
		dc.w byte_kill2-Ani_obj1F, byte_kill3-Ani_obj1F, byte_kill4-Ani_obj1F
		dc.w byte_kill5-Ani_obj1F, byte_kill6-Ani_obj1F, byte_kill7-Ani_obj1F
		dc.w byte_kill8-Ani_obj1F, byte_kill9-Ani_obj1F, byte_kill10-Ani_obj1F
		dc.w byte_kill11-Ani_obj1F, byte_kill12-Ani_obj1F
byte_972A:	dc.b $A, 0, $FF, 0
byte_972E:	dc.b $A, 2, $FF, 0
byte_9732:	dc.b $A, $22, $FF, 0
byte_9736:	dc.b $A, 1, $21, 0, $FF, 0
byte_973C:	dc.b $A, $21, 3, 2, $FF, 0
byte_9742:	dc.b $A, 1, $23, $22, $FF, 0
byte_9748:	dc.b $A, 4, $FF, 0
byte_974C:	dc.b 1,	5, 6, $FF
byte_kill1:	dc.b 9, 1,$21,0, $FD, 9
byte_kill2:	dc.b 8, 1,$21,0, $FD, $A
byte_kill3:	dc.b 7, 1,$21,0, $FD, $B
byte_kill4:	dc.b 6, 1,$21,0,1,$21,0, $FD, $C
byte_kill5:	dc.b 5, 1,$21,0,1,$21,0, $FD, $D
byte_kill6:	dc.b 4, 1,$21,0,1,$21,0, $FD, $E
byte_kill7:	dc.b 3, 1,$21,0,1,$21,0,1,$21,0, $FD, $F
byte_kill8:	dc.b 2, 1,$21,0,1,$21,0,1,$21,0, $FD, $10
byte_kill9:	dc.b 1, 1,$21,0,1,$21,0,1,$21,0, $FD, $11
byte_kill10:	dc.b 0, 1,$21,0,1,$21,0,1,$21,0,1,$21,0, $FD, $12
byte_kill11:	dc.b 90, 0, $FD, $13
byte_kill12:	dc.b 0, 1, $FF
		even