;	dc.w (unused), left boundary, right boundary
;	dc.w upper boundary, lower boundary, default Y-camera position

	dc.w $0004, $0000, $2185	; GHZ 1
	dc.w $0000, $0300, $0060
	dc.w $0004, $02C0, $1E40	; GHZ 2
	dc.w $0000, $0100, $0060
	dc.w $0004, $25C5, $5060	; GHZ 3
	dc.w $0000, $0410, $0060
	dc.w $0004, $0000, $2ABF	; GHZ 4
	dc.w $0000, $0300, $0060
	dc.w $0004, $0000, $19BF	; LZ 1
	dc.w $0000, $0530, $0060
	dc.w $0004, $0000, $0DC0	; LZ 2
	dc.w $0000, $0720, $0060
	dc.w $0004, $0000, $202F	; LZ 3
	dc.w $FF00, $0800, $0060
	dc.w $0004, $0000, $20BF	; LZ 4 (SBZ 3)
	dc.w $0000, $0720, $0060
	dc.w $0004, $0000, $1DBF	; MZ 1
	dc.w $0000, $0520, $0060
	dc.w $0004, $0000, $17BF	; MZ 2
	dc.w $0000, $0520, $0060
	dc.w $0004, $0000, $1800	; MZ 3
	dc.w $0000, $0720, $0060
	dc.w $0004, $0000, $16BF	; MZ 4
	dc.w $0000, $0720, $0060
	dc.w $0004, $0000, $1FBF	; SLZ 1
	dc.w $0000, $0640, $0060
	dc.w $0004, $0000, $0A60	; SLZ 2
	dc.w $0000, $0620, $0060
	dc.w $0004, $0A60, $1FBF	; SLZ 3
	dc.w $0000, $0620, $0060
	dc.w $0004, $0000, $1FBF	; SLZ 4
	dc.w $0000, $0720, $0060
	dc.w $0004, $0070, $1990	; SYZ 1 (Uberhub)
	dc.w $0000, $021C, $0060
	dc.w $0004, $0000, $28C0	; SYZ 2
	dc.w $0000, $0520, $0060
	dc.w $0004, $0000, $2C00	; SYZ 3
	dc.w $0000, $0620, $0060
	dc.w $0004, $0000, $2EC0	; SYZ 4
	dc.w $0000, $0620, $0060
	dc.w $0004, $0000, $2460	; SBZ 1
	dc.w $0000, $0810, $0060
	dc.w $0004, $0000, $2460	; SBZ 2
	dc.w $0000, $0710, $0060
	dc.w $0004, $0000, $245E	; SBZ 3 (FZ)
	dc.w $0510, $0510, $0060
	dc.w $0004, $0000, $3EC0	; SBZ 4
	dc.w $0000, $0720, $0060
	dc.w $0004, $0000, $0500	; ending sequence (fake)
	dc.w $0110, $0310, $0060
	dc.w $0004, $0000, $0EC0	; Ending Sequence (real)
	dc.w $0110, $0310, $0060
	dc.w $0004, $0000, $2FFF	;
	dc.w $0000, $0520, $0060
	dc.w $0004, $0000, $2FFF	;
	dc.w $0000, $0520, $0060