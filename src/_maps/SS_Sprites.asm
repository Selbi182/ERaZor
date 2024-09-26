Map_SSBumper:
	dc.w	(SS_Sprites_Bank+0)-Map_SSBumper
	dc.w	(SS_Sprites_Bank+8)-Map_SSBumper
	dc.w	(SS_Sprites_Bank+16)-Map_SSBumper

Map_SSRings:
	dc.w	(SS_Sprites_Bank+24)-Map_SSRings
	dc.w	(SS_Sprites_Bank+32)-Map_SSRings
	dc.w	(SS_Sprites_Bank+40)-Map_SSRings
	dc.w	(SS_Sprites_Bank+48)-Map_SSRings
	dc.w	(SS_Sprites_Bank+56)-Map_SSRings
	dc.w	(SS_Sprites_Bank+64)-Map_SSRings
	dc.w	(SS_Sprites_Bank+72)-Map_SSRings
	dc.w	(SS_Sprites_Bank+80)-Map_SSRings
	dc.w	0

Map_SSWalls:
	dc.w	(SS_Sprites_Bank+88)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls
	dc.w	(SS_Sprites_Bank+0)-Map_SSWalls

Map_SS_Chaos1:
	dc.w	(SS_Sprites_Bank+24)-Map_SS_Chaos1
	dc.w	(SS_Sprites_Bank+96)-Map_SS_Chaos1

Map_SS_Chaos2:
	dc.w	(SS_Sprites_Bank+32)-Map_SS_Chaos2
	dc.w	(SS_Sprites_Bank+96)-Map_SS_Chaos2

Map_SS_Chaos3:
	dc.w	(SS_Sprites_Bank+104)-Map_SS_Chaos3
	dc.w	(SS_Sprites_Bank+96)-Map_SS_Chaos3

Map_SS_Down:
	dc.w	(SS_Sprites_Bank+112)-Map_SS_Down
	dc.w	(SS_Sprites_Bank+120)-Map_SS_Down

Map_SS_Glass:
	dc.w	(SS_Sprites_Bank+88)-Map_SS_Glass
	dc.w	(SS_Sprites_Bank+128)-Map_SS_Glass
	dc.w	(SS_Sprites_Bank+136)-Map_SS_Glass
	dc.w	(SS_Sprites_Bank+144)-Map_SS_Glass

Map_SS_R:
	dc.w	(SS_Sprites_Bank+88)-Map_SS_R
	dc.w	(SS_Sprites_Bank+112)-Map_SS_R
	dc.w	0

Map_SS_Up:
	dc.w	(SS_Sprites_Bank+88)-Map_SS_Up
	dc.w	(SS_Sprites_Bank+120)-Map_SS_Up

SS_Sprites_Bank:
	dc.w	$FFF0, $0FFF, $0000, $FFF0
	dc.w	$FFF4, $0AFF, $0010, $FFF4
	dc.w	$FFF0, $0FFF, $0019, $FFF0
	dc.w	$FFF8, $05FF, $0000, $FFF8
	dc.w	$FFF8, $05FF, $0004, $FFF8
	dc.w	$FFF8, $01FF, $0008, $FFFC
	dc.w	$FFF8, $05FF, $0804, $FFF8
	dc.w	$FFF8, $05FF, $000A, $FFF8
	dc.w	$FFF8, $05FF, $180A, $FFF8
	dc.w	$FFF8, $05FF, $080A, $FFF8
	dc.w	$FFF8, $05FF, $100A, $FFF8
	dc.w	$FFF4, $0AFF, $0000, $FFF4
	dc.w	$FFF8, $05FF, $000C, $FFF8
	dc.w	$FFF8, $05FF, $0008, $FFF8
	dc.w	$FFF4, $0AFF, $0009, $FFF4
	dc.w	$FFF4, $0AFF, $0012, $FFF4
	dc.w	$FFF4, $0AFF, $0800, $FFF4
	dc.w	$FFF4, $0AFF, $1800, $FFF4
	dc.w	$FFF4, $0AFF, $1000, $FFF4
