
VBlank_SetMusicOnly:	macro
	addq.b	#1, VBlank_MusicOnly
	endm
	
VBlank_UnsetMusicOnly:	macro
	subq.b	#1, VBlank_MusicOnly
	assert.b	VBlank_MusicOnly, pl		; shouldn't underflow
	endm
