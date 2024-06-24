; ---------------------------------------------------------------------------
; Sprite mappings - "SONIC TEAM	PRESENTS" and credits
; ---------------------------------------------------------------------------		
		dc.w byte_172F8-Map_obj8A, byte_1733F-Map_obj8A
		dc.w byte_17390-Map_obj8A, byte_173C3-Map_obj8A
		dc.w byte_1743C-Map_obj8A, byte_174A1-Map_obj8A
		dc.w byte_17524-Map_obj8A, byte_17598-Map_obj8A
		dc.w byte_17634-Map_obj8A, byte_17680-Map_obj8A
		dc.w byte_176A9-Map_obj8A
byte_172F8:	dc.b $19			 ; SONIC TEAM STAFF | THANKS FOR PLAYING THIS GAME
		dc.b $D0, 5, 0, $3E, $88	;T
		dc.b $D0, 5, 0, $3A, $98	;H
		dc.b $D0, 5, 0, 4, $A8	;A
		dc.b $D0, 5, 0, $1A, $B8	;N
		dc.b $D0, 5, 0, $58, $C8	;K
		dc.b $D0, 5, 0, $2E, $D8	;S
		dc.b $E1, 5, 0, $5C, $A8	;F
		dc.b $E1, 5, 0, $26, $B8	;O
		dc.b $E1, 5, 0, $22, $C8	;R
		dc.b $F2, 5, 0, $12, $C8	;P
		dc.b $F2, 5, 0, $16, $D8	;L
		dc.b $F2, 5, 0, 4, $E8	;A
		dc.b $F2, 5, 0, $2A, $F8	;Y
		dc.b $F2, 1, 0, $46, $8	;I
		dc.b $F2, 5, 0, $1A, $10	;N
		dc.b $F2, 5, 0, 0, $20	;G
		dc.b $32, 5, 0, $3E, $B5	;T
		dc.b $32, 5, 0, $3A, $C5	;H
		dc.b $32, 1, 0, $46, $D5	;I
		dc.b $32, 5, 0, $2E, $DD	;S
	; SPACE
		dc.b $32, 5, 0, 0, $FD	;G
		dc.b $32, 5, 0, 4, $D	;A
		dc.b $32, 9, 0, 8, $1D	;M
		dc.b $32, 5, 0, $0E, $31	;E
		dc.b $32, 0, 0, $60, $41	;Space
byte_1733F:	dc.b $12	; GAME PLAN CAROL YAS | PROJECT LEADER SELBI
		dc.b $D8, 5, 0, $12, $80	;P
		dc.b $D8, 5, 0, $22, $90	;R
		dc.b $D8, 5, 0, $26, $A0	;O
		dc.b $D8, 5, 0, $4C, $B0	;J
		dc.b $D8, 5, 0, $0E, $C0	;E
		dc.b $D8, 5, 0, $1E, $D0	;C
		dc.b $D8, 5, 0, $3E, $E0	;T
		dc.b $D8, 5, 0, $16, $0	;L
		dc.b $D8, 5, 0, $0E, $10	;E
		dc.b $D8, 5, 0, 4, $20	;A
		dc.b $D8, 5, 0, $42, $30	;D
		dc.b $D8, 5, 0, $0E, $40	;E
		dc.b $D8, 5, 0, $22, $50	;R
		dc.b $8, 5, 0, $2E, $D0	;S
		dc.b $8, 5, 0, $0E, $E0	;E
		dc.b $8, 5, 0, $16, $F0	;L
		dc.b $8, 5, 0, $48, $0	;B
		dc.b $8, 1, 0, $46, $10	;I
byte_17390:	dc.b $8			 ; PROGRAM YU 2 | ASM SELBI
		dc.b $D8, 5, 0, 4, $90	;A
		dc.b $D8, 5, 0, $2E, $A0 ;S
		dc.b $D8, 9, 0, 8, $B0	;M
		dc.b $8, 5, 0, $2E, $E8	;S
		dc.b $8, 5, 0, $0E, $F8	;E
		dc.b $8, 5, 0, $16, $8	;L
		dc.b $8, 5, 0, $48, $18	;B
		dc.b $8, 1, 0, $46, $28	;I
byte_173C3:	dc.b $10		 ; CHARACTER DESIGN BIGISLAND | ART SEGA SELBI SCAA
		dc.b $D8, 5, 0, 4, $90	;A
		dc.b $D8, 5, 0, $22, $A0	;R
		dc.b $D8, 5, 0, $3E, $B0	;T
		dc.b $F8, 5, 0, $2E, $C0	;S
		dc.b $F8, 5, 0, $0E, $D0	;E
		dc.b $F8, 5, 0, 0, $E0	;G
		dc.b $F8, 5, 0, 4, $F0	;A
		dc.b $18, 5, 0, $2E, $C0	;S
		dc.b $18, 5, 0, $0E, $D0	;E
		dc.b $18, 5, 0, $16, $E0	;L
		dc.b $18, 5, 0, $48, $F0	;B
		dc.b $18, 1, 0, $46, $0	;I
		dc.b $38, 5, 0, $2E, $C0	;S
		dc.b $38, 5, 0, $1E, $D0	;C
		dc.b $38, 5, 0, 4, $E0	;A
		dc.b $38, 5, 0, 4, $F0	;A
byte_1743C:	dc.b $18		 ; DESIGN JINYA	PHENIX RIE | STAGE DESIGN CLOUDIAR SELBI
		dc.b $D8, 5, 0, $2E, $88	;S
		dc.b $D8, 5, 0, $3E, $98	;T
		dc.b $D8, 5, 0, 4, $A8	;A
		dc.b $D8, 5, 0, 0, $B8	;G
		dc.b $D8, 5, 0, $0E, $C8	;E
		dc.b $D8, 5, 0, $42, $E8	;D
		dc.b $D8, 5, 0, $0E, $F8	;E
		dc.b $D8, 5, 0, $2E, $8	;S
		dc.b $D8, 1, 0, $46, $18	;I
		dc.b $D8, 5, 0, 0, $20	;G
		dc.b $D8, 5, 0, $1A, $30	;N
		dc.b $F8, 5, 0, $1E, $C0	;C
		dc.b $F8, 5, 0, $16, $D0	;L
		dc.b $F8, 5, 0, $26, $E0	;O
		dc.b $F8, 5, 0, $32, $F0	;U
		dc.b $F8, 5, 0, $42, $0	;D
		dc.b $F8, 1, 0, $46, $10	;I
		dc.b $F8, 5, 0, 4, $18	;A
		dc.b $F8, 5, 0, $22, $28	;R
		dc.b $18, 5, 0, $2E, $C0	;S
		dc.b $18, 5, 0, $0E, $D0	;E
		dc.b $18, 5, 0, $16, $E0	;L
		dc.b $18, 5, 0, $48, $F0	;B
		dc.b $18, 1, 0, $46, $0	;I
byte_174A1:	dc.b $20	;  SOUND PRODUCE MASATO NAKAMURA | MUSIC EDUARDOKNU CKLES DALEKSAM  SOTI
		dc.b $D0, 9, 0, 8, $80		; M
		dc.b $D0, 5, 0, $32, $94	; U
		dc.b $D0, 5, 0, $2E, $A4	; S
		dc.b $D0, 1, 0, $46, $B4	; I
		dc.b $D0, 5, 0, $1E, $BC	; C

		dc.b $F8, 5, 0, $0E, $98	; E
		dc.b $F8, 5, 0, $42, $A8	; D
		dc.b $F8, 5, 0, $32, $B8	; U
		dc.b $F8, 5, 0, 4, $C8		; A
		dc.b $F8, 5, 0, $22, $D8	; R
		dc.b $F8, 5, 0, $42, $E8	; D
		dc.b $F8, 5, 0, $26, $F8	; O
		dc.b $F8, 5, 0, $58, $8	; K
		dc.b $F8, 5, 0, $1A, $18	; N
		dc.b $F8, 5, 0, $32, $28	; U
		dc.b $F8, 5, 0, $1E, $38	; C
		dc.b $F8, 5, 0, $58, $48	; K
		dc.b $F8, 5, 0, $16, $58	; L
		dc.b $F8, 5, 0, $0E, $68	; E
		dc.b $F8, 5, 0, $2E, $78	; S

		dc.b $18, 5, 0, $42, $98	; D
		dc.b $18, 5, 0, 4, $A8		; A
		dc.b $18, 5, 0, $16, $B8	; L
		dc.b $18, 5, 0, $0E, $C8	; E
		dc.b $18, 5, 0, $58, $D8	; K
		dc.b $18, 5, 0, $2E, $E8	; S
		dc.b $18, 5, 0, 4, $F8		; A
		dc.b $18, 9, 0, 8, $8		; M

		dc.b $38, 5, 0, $2E, $98	; S
		dc.b $38, 5, 0, $26, $A8	; O
		dc.b $38, 5, 0, $3E, $B8	; T
		dc.b $38, 1, 0, $46, $C8	; I
byte_17524:	dc.b $2B	;  SONIC TEAM STAFF | RANDOMNESS SOTI SONICVAAN IRIXION SNKENJOI
		dc.b $B8, 5, 0, $2E, $90	; S
		dc.b $B8, 5, 0, $12, $A0	; P
		dc.b $B8, 5, 0, $0E, $B0	; E
		dc.b $B8, 5, 0, $1E, $C0	; C
		dc.b $B8, 1, 0, $46, $D0	; I
		dc.b $B8, 5, 0, 4, $D8		; A
		dc.b $B8, 5, 0, $16, $E8	; L
		dc.b $B8, 0, 0, $60, $C    ;Space
		dc.b $B8, 5, 0, $3E, $8	; T
		dc.b $B8, 5, 0, $3A, $18	; H
		dc.b $B8, 5, 0, 4, $28		; A
		dc.b $B8, 5, 0, $1A, $38	; N
		dc.b $B8, 5, 0, $58, $48	; K
		dc.b $B8, 5, 0, $2E, $58	; S

		dc.b $D8, 5, 0, $2E, $C0	; S
		dc.b $D8, 5, 0, $26, $D0	; O
		dc.b $D8, 5, 0, $3E, $E0	; T
		dc.b $D8, 1, 0, $46, $F0	; I

		dc.b $F8, 5, 0, $2E, $C0	; S
		dc.b $F8, 5, 0, $26, $D0	; O
		dc.b $F8, 5, 0, $1A, $E0	; N
		dc.b $F8, 1, 0, $46, $F0	; I
		dc.b $F8, 5, 0, $1E, $F8	; C
		dc.b $F8, 1, $10, 8, $8 ; V (part 1)		
		dc.b $F8, 1, $10, $C, $10 ; V (part 2)
		dc.b $F8, 5, 0, 4, $15		; A
		dc.b $F8, 5, 0, 4, $25		; A
		dc.b $F8, 5, 0, $1A, $35	; N

		dc.b $18, 1, 0, $46, $C0	; I
		dc.b $18, 5, 0, $22, $C8	; R
		dc.b $18, 1, 0, $46, $D8	; I
		dc.b $18, 5, 0, $50, $E0	; X
		dc.b $18, 1, 0, $46, $F0	; I
		dc.b $18, 5, 0, $26, $F8	; O
		dc.b $18, 5, 0, $1A, $8	; N

		dc.b $38, 5, 0, $2E, $C0	; S
		dc.b $38, 5, 0, $1A, $D0	; N
		dc.b $38, 5, 0, $58, $E0	; K
		dc.b $38, 5, 0, $0E, $F0	; E
		dc.b $38, 5, 0, $1A, $0	; N
		dc.b $38, 5, 0, $4C, $10	; J
		dc.b $38, 5, 0, $26, $20	; O
		dc.b $38, 1, 0, $46, $30	; I
byte_17598:	dc.b $4C	; SPECIAL THANKS FUJIO MINEGISHI PAPA | SPECIAL THANKS CLOUDIAR EDUARDOKNUCKLES DEOXYSKYOGRE IRIXION SONICVAAN
		dc.b $A0, 5, 0, $2E, $80	;S
		dc.b $A0, 5, 0, $12, $90	;P
		dc.b $A0, 5, 0, $0E, $A0	;E
		dc.b $A0, 5, 0, $1E, $B0	;C
		dc.b $A0, 1, 0, $46, $C0	;I
		dc.b $A0, 5, 0, 4, $C8	;A
		dc.b $A0, 5, 0, $16, $D8	;L
		dc.b $A0, 5, 0, $3E, $F8	;T
		dc.b $A0, 5, 0, $3A, $8	;H
		dc.b $A0, 5, 0, 4, $18	;A
		dc.b $A0, 5, 0, $1A, $28	;N
		dc.b $A0, 5, 0, $58, $38	;K
		dc.b $A0, 5, 0, $2E, $48	;S
		dc.b $A0, 5, 0, $36, $68	;  2

		dc.b $BA, 5, 0, $1E, $95	;C
		dc.b $BA, 5, 0, $16, $A5	;L
		dc.b $BA, 5, 0, $26, $B5	;O
		dc.b $BA, 5, 0, $32, $C5	;U
		dc.b $BA, 5, 0, $42, $D5	;D
		dc.b $BA, 1, 0, $46, $E5	;I
		dc.b $BA, 5, 0, 4, $ED	;A
		dc.b $BA, 5, 0, $22, $FD	;R
		
		dc.b $D4, 5, 0, $0E, $95	;E
		dc.b $D4, 5, 0, $42, $A5	;D
		dc.b $D4, 5, 0, $32, $B5	;U
		dc.b $D4, 5, 0, 4, $C5	;A
		dc.b $D4, 5, 0, $22, $D5	;R
		dc.b $D4, 5, 0, $42, $E5	;D
		dc.b $D4, 5, 0, $26, $F5	;O
		dc.b $D4, 5, 0, $58, $5	;K
		dc.b $D4, 5, 0, $1A, $15	;N
		dc.b $D4, 5, 0, $32, $25	;U
		dc.b $D4, 5, 0, $1E, $35	;C
		dc.b $D4, 5, 0, $58, $45	;K
		dc.b $D4, 5, 0, $16, $55	;L
		dc.b $D4, 5, 0, $0E, $65	;E
		dc.b $D4, 5, 0, $2E, $75	;S
		
		dc.b $EE, 5, 0, $42, $95	;D
		dc.b $EE, 5, 0, $0E, $A5	;E
		dc.b $EE, 5, 0, $26, $B5	;O
		dc.b $EE, 5, 0, $50, $C5	;X
		dc.b $EE, 5, 0, $2A, $D5	;Y
		dc.b $EE, 5, 0, $2E, $E5	;S
		dc.b $EE, 5, 0, $58, $F5	;K
		dc.b $EE, 5, 0, $2A, $5	;Y
		dc.b $EE, 5, 0, $26, $15	;O
		dc.b $EE, 5, 0, 0, $25	;G
		dc.b $EE, 5, 0, $22, $35	;R
		dc.b $EE, 5, 0, $0E, $45	;E
		
		dc.b $9, 1, 0, $46, $95	;I
		dc.b $9, 5, 0, $22, $9D	;R
		dc.b $9, 1, 0, $46, $AD	;I
		dc.b $9, 5, 0, $50, $B5	;X
		dc.b $9, 1, 0, $46, $C5	;I
		dc.b $9, 5, 0, $26, $CD	;O
		dc.b $9, 5, 0, $1A, $DD	;N

		dc.b $25, 9, 0, 8, $95	;M
		dc.b $25, 5, 0, 4, $A9	;A
		dc.b $25, 5, 0, $22, $B9	;R
		dc.b $25, 5, 0, $58, $C9	;K
		dc.b $25, 5, 0, $0E, $D9	;E
		dc.b $25, 5, 0, $2A, $E9	;Y
		dc.b $25, 5, 0, $4C, $F9	;J
		dc.b $25, 5, 0, $0E, $9	;E
		dc.b $25, 5, 0, $2E, $19	;S
		dc.b $25, 5, 0, $3E, $29	;T
		dc.b $25, 5, 0, $0E, $39	;E
		dc.b $25, 5, 0, $22, $49	;R

		dc.b $41, 1, 0, $46, $95	;I
		dc.b $41, 5, 0, $26, $9D	;O
		dc.b $41, 5, 0, $4C, $AD	;J
		dc.b $41, 5, 0, $1A, $BD	;N
		dc.b $41, 5, 0, $0E, $CD	;E
		dc.b $41, 5, 0, $58, $DD	;K
		dc.b $41, 5, 0, $1A, $ED	;N
		dc.b $41, 5, 0, $2E, $FD	;S
		
byte_17634:	dc.b $10			 ; PRESENTED BY	SEGA | PRESENTED BY SELBI
		dc.b $F8, 5, 0,	$12, $80
		dc.b $F8, 5, 0,	$22, $90
		dc.b $F8, 5, 0,	$E, $A0
		dc.b $F8, 5, 0,	$2E, $B0
		dc.b $F8, 5, 0,	$E, $C0
		dc.b $F8, 5, 0,	$1A, $D0
		dc.b $F8, 5, 0,	$3E, $E0
		dc.b $F8, 5, 0,	$E, $F0
		dc.b $F8, 5, 0,	$42, 0
		dc.b $F8, 5, 0,	$48, $18
		dc.b $F8, 5, 0,	$2A, $28
		dc.b $F, 5, 0, $2E, $30	;S
		dc.b $F, 5, 0, $0E, $40	;E
		dc.b $F, 5, 0, $16, $50	;L
		dc.b $F, 5, 0, $48, $60	;B
		dc.b $F, 1, 0, $46, $70	;I
byte_17680:	dc.b 7	; TRY AGAIN | KTHXBAI
		dc.b $30, 5, 0, $58, $CC	;K
		dc.b $30, 5, 0, $3E, $DC	;T
		dc.b $30, 5, 0, $3A, $EC	;H
		dc.b $30, 5, 0, $50, $FC	;X
		dc.b $30, 5, 0, $48, $C	;B
		dc.b $30, 5, 0, 4, $1C	;A
		dc.b $30, 1, 0, $46, $2C	;I
byte_176A9:	dc.b $D	; SONIC TEAM PRESENTS | SELBI PRESENTS
		dc.b $E0, 5, 0, $2E, $DA	;S
		dc.b $E0, 5, 0, $0E, $E8	;E
		dc.b $E0, 5, 0, $16, $F7	;L
		dc.b $E0, 5, 0, $48, 6	;B
		dc.b $E0, 1, 0, $46, $16	;I

		dc.b 0, 5, 0, $12, $C0	;P
		dc.b 0, 5, 0, $22, $CF	;R
		dc.b 0, 5, 0, $0E, $DE	;E
		dc.b 0, 5, 0, $2E, $ED	;S
		dc.b 0, 5, 0, $0E, $FB	;E
		dc.b 0, 5, 0, $1A, $B	;N
		dc.b 0, 5, 0, $3E, $1A	;T
		dc.b 0, 5, 0, $2E, $2A	;S
		even