; ---------------------------------------------------------------------------
; Sprite mappings - lava geyser / lava that falls from the ceiling (MZ)
; ---------------------------------------------------------------------------
		dc.w byte_F272-Map_obj4C, byte_F27D-Map_obj4C
		dc.w byte_F288-Map_obj4C, byte_F29D-Map_obj4C
		dc.w byte_F2B2-Map_obj4C, byte_F2D1-Map_obj4C
		dc.w byte_F2F0-Map_obj4C, byte_F2FB-Map_obj4C
		dc.w byte_F306-Map_obj4C, byte_F339-Map_obj4C
		dc.w byte_F36C-Map_obj4C, byte_F39F-Map_obj4C
		dc.w byte_F3BE-Map_obj4C, byte_F3DD-Map_obj4C
		dc.w byte_F3FC-Map_obj4C, byte_F44D-Map_obj4C
		dc.w byte_F49E-Map_obj4C, byte_F4EF-Map_obj4C
		dc.w byte_F50E-Map_obj4C, byte_F52D-Map_obj4C
byte_F272:	dc.b 2
		dc.b $EC, $B, 0, 0, $E8
		dc.b $EC, $B, 8, 0, 0
byte_F27D:	dc.b 2
		dc.b $EC, $B, 0, $18, $E8
		dc.b $EC, $B, 8, $18, 0
byte_F288:	dc.b 4
		dc.b $EC, $B, 0, 0, $C8
		dc.b $F4, $E, 0, $C, $E0
		dc.b $F4, $E, 8, $C, 0
		dc.b $EC, $B, 8, 0, $20
byte_F29D:	dc.b 4
		dc.b $EC, $B, 0, $18, $C8
		dc.b $F4, $E, 0, $24, $E0
		dc.b $F4, $E, 8, $24, 0
		dc.b $EC, $B, 8, $18, $20
byte_F2B2:	dc.b 6
		dc.b $EC, $B, 0, 0, $C8
		dc.b $F4, $E, 0, $C, $E0
		dc.b $F4, $E, 8, $C, 0
		dc.b $EC, $B, 8, 0, $20
		dc.b $E8, $E, 0, $90, $E0
		dc.b $E8, $E, 8, $90, 0
byte_F2D1:	dc.b 6
		dc.b $EC, $B, 0, $18, $C8
		dc.b $F4, $E, 0, $24, $E0
		dc.b $F4, $E, 8, $24, 0
		dc.b $EC, $B, 8, $18, $20
		dc.b $E8, $E, 8, $90, $E0
		dc.b $E8, $E, 0, $90, 0
byte_F2F0:	dc.b 2
		dc.b $E0, $F, 0, $30, $E0
		dc.b $E0, $F, 8, $30, 0
byte_F2FB:	dc.b 2
		dc.b $E0, $F, 8, $30, $E0
		dc.b $E0, $F, 0, $30, 0
byte_F306:	dc.b $A
		dc.b $90, $F, 0, $40, $E0
		dc.b $90, $F, 8, $40, 0
		dc.b $B0, $F, 0, $40, $E0
		dc.b $B0, $F, 8, $40, 0
		dc.b $D0, $F, 0, $40, $E0
		dc.b $D0, $F, 8, $40, 0
		dc.b $F0, $F, 0, $40, $E0
		dc.b $F0, $F, 8, $40, 0
		dc.b $10, $F, 0, $40, $E0
		dc.b $10, $F, 8, $40, 0
byte_F339:	dc.b $A
		dc.b $90, $F, 0, $50, $E0
		dc.b $90, $F, 8, $50, 0
		dc.b $B0, $F, 0, $50, $E0
		dc.b $B0, $F, 8, $50, 0
		dc.b $D0, $F, 0, $50, $E0
		dc.b $D0, $F, 8, $50, 0
		dc.b $F0, $F, 0, $50, $E0
		dc.b $F0, $F, 8, $50, 0
		dc.b $10, $F, 0, $50, $E0
		dc.b $10, $F, 8, $50, 0
byte_F36C:	dc.b $A
		dc.b $90, $F, 0, $60, $E0
		dc.b $90, $F, 8, $60, 0
		dc.b $B0, $F, 0, $60, $E0
		dc.b $B0, $F, 8, $60, 0
		dc.b $D0, $F, 0, $60, $E0
		dc.b $D0, $F, 8, $60, 0
		dc.b $F0, $F, 0, $60, $E0
		dc.b $F0, $F, 8, $60, 0
		dc.b $10, $F, 0, $60, $E0
		dc.b $10, $F, 8, $60, 0
byte_F39F:	dc.b 6
		dc.b $90, $F, 0, $40, $E0
		dc.b $90, $F, 8, $40, 0
		dc.b $B0, $F, 0, $40, $E0
		dc.b $B0, $F, 8, $40, 0
		dc.b $D0, $F, 0, $40, $E0
		dc.b $D0, $F, 8, $40, 0
byte_F3BE:	dc.b 6
		dc.b $90, $F, 0, $50, $E0
		dc.b $90, $F, 8, $50, 0
		dc.b $B0, $F, 0, $50, $E0
		dc.b $B0, $F, 8, $50, 0
		dc.b $D0, $F, 0, $50, $E0
		dc.b $D0, $F, 8, $50, 0
byte_F3DD:	dc.b 6
		dc.b $90, $F, 0, $60, $E0
		dc.b $90, $F, 8, $60, 0
		dc.b $B0, $F, 0, $60, $E0
		dc.b $B0, $F, 8, $60, 0
		dc.b $D0, $F, 0, $60, $E0
		dc.b $D0, $F, 8, $60, 0
byte_F3FC:	dc.b $10
		dc.b $90, $F, 0, $40, $E0
		dc.b $90, $F, 8, $40, 0
		dc.b $B0, $F, 0, $40, $E0
		dc.b $B0, $F, 8, $40, 0
		dc.b $D0, $F, 0, $40, $E0
		dc.b $D0, $F, 8, $40, 0
		dc.b $F0, $F, 0, $40, $E0
		dc.b $F0, $F, 8, $40, 0
		dc.b $10, $F, 0, $40, $E0
		dc.b $10, $F, 8, $40, 0
		dc.b $30, $F, 0, $40, $E0
		dc.b $30, $F, 8, $40, 0
		dc.b $50, $F, 0, $40, $E0
		dc.b $50, $F, 8, $40, 0
		dc.b $70, $F, 0, $40, $E0
		dc.b $70, $F, 8, $40, 0
byte_F44D:	dc.b $10
		dc.b $90, $F, 0, $50, $E0
		dc.b $90, $F, 8, $50, 0
		dc.b $B0, $F, 0, $50, $E0
		dc.b $B0, $F, 8, $50, 0
		dc.b $D0, $F, 0, $50, $E0
		dc.b $D0, $F, 8, $50, 0
		dc.b $F0, $F, 0, $50, $E0
		dc.b $F0, $F, 8, $50, 0
		dc.b $10, $F, 0, $50, $E0
		dc.b $10, $F, 8, $50, 0
		dc.b $30, $F, 0, $50, $E0
		dc.b $30, $F, 8, $50, 0
		dc.b $50, $F, 0, $50, $E0
		dc.b $50, $F, 8, $50, 0
		dc.b $70, $F, 0, $50, $E0
		dc.b $70, $F, 8, $50, 0
byte_F49E:	dc.b $10
		dc.b $90, $F, 0, $60, $E0
		dc.b $90, $F, 8, $60, 0
		dc.b $B0, $F, 0, $60, $E0
		dc.b $B0, $F, 8, $60, 0
		dc.b $D0, $F, 0, $60, $E0
		dc.b $D0, $F, 8, $60, 0
		dc.b $F0, $F, 0, $60, $E0
		dc.b $F0, $F, 8, $60, 0
		dc.b $10, $F, 0, $60, $E0
		dc.b $10, $F, 8, $60, 0
		dc.b $30, $F, 0, $60, $E0
		dc.b $30, $F, 8, $60, 0
		dc.b $50, $F, 0, $60, $E0
		dc.b $50, $F, 8, $60, 0
		dc.b $70, $F, 0, $60, $E0
		dc.b $70, $F, 8, $60, 0
byte_F4EF:	dc.b 6
		dc.b $E0, $B, 0, 0, $C8
		dc.b $E8, $E, 0, $C, $E0
		dc.b $E8, $E, 8, $C, 0
		dc.b $E0, $B, 8, 0, $20
		dc.b $D8, $E, 0, $90, $E0
		dc.b $D8, $E, 8, $90, 0
byte_F50E:	dc.b 6
		dc.b $E0, $B, 0, $18, $C8
		dc.b $E8, $E, 0, $24, $E0
		dc.b $E8, $E, 8, $24, 0
		dc.b $E0, $B, 8, $18, $20
		dc.b $D8, $E, 8, $90, $E0
		dc.b $D8, $E, 0, $90, 0
byte_F52D:	dc.b 0
		even