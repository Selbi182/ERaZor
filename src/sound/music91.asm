Music91_Header:
	smpsHeaderVoice     Music91_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $03, $00

	smpsHeaderDAC       Music91_DAC,	$00, $09
	smpsHeaderFM        Music91_FM1,	$00, $10
	smpsHeaderFM        Music91_FM2,	$00, $1C
	smpsHeaderFM        Music91_FM3,	$00, $12
	smpsHeaderFM        Music91_FM4,	$00, $14
	smpsHeaderFM        Music91_FM5,	$0C, $16
	smpsHeaderPSG       Music91_PSG1,	$E8, $06, $07, fTone_05
	smpsHeaderPSG       Music91_PSG2,	$00, $07, $07, fTone_04
	smpsHeaderPSG       Music91_PSG3,	$00, $07, $01, fTone_03

; DAC Data
Music91_DAC:
	smpsCall            Music91_Call00
	smpsCall            Music91_Call01
	smpsCall            Music91_Call02
	smpsCall            Music91_Call03
	smpsCall            Music91_Call04
	smpsCall            Music91_Call05
	smpsCall            Music91_Call00
	smpsCall            Music91_Call01
	smpsCall            Music91_Call02
	smpsCall            Music91_Call03
	smpsCall            Music91_Call04
	smpsCall            Music91_Call05
	smpsCall            Music91_Call06
	smpsCall            Music91_Call07
	smpsJump Music91_DAC

Music91_Call00:
	dc.b	$90, $04, nRst, $02, nRst
	smpsAlterVol        $01
	dc.b	$9D, $04
	smpsAlterVol        $FF
	dc.b	nRst, $02, nRst, $90, $04, nRst, $02, nRst
	smpsAlterVol        $01
	dc.b	$9D, $04
	smpsAlterVol        $FF
	dc.b	nRst, $02, nRst
	smpsLoop            $00, $0F, Music91_Call00
	smpsReturn

Music91_Call01:
	dc.b	$90, $04, nRst, $02, nRst
	smpsAlterVol        $01
	dc.b	$9D, $04
	smpsAlterVol        $FF
	dc.b	nRst, $02, nRst, $90, $04
	smpsAlterVol        $FE
	dc.b	$9D, $9D, $9D
	smpsAlterVol        $02
	smpsReturn

Music91_Call02:
	dc.b	$90, $04, nRst, $02, nRst
	smpsAlterVol        $01
	dc.b	$9D, $04
	smpsAlterVol        $FF
	dc.b	nRst, $02, nRst, $90, $04, nRst, $02, nRst
	smpsAlterVol        $01
	dc.b	$9D, $04
	smpsAlterVol        $FF
	dc.b	nRst, $02, nRst
	smpsLoop            $02, $07, Music91_Call02
	smpsReturn

Music91_Call03:
	dc.b	$90, $04, nRst, $02, nRst
	smpsAlterVol        $01
	dc.b	$9D, $04
	smpsAlterVol        $FF
	dc.b	nRst, $02, nRst, $90, $04
	smpsAlterVol        $FE
	dc.b	$9D, $9D, $9D
	smpsAlterVol        $02
	smpsReturn

Music91_Call04:
	dc.b	$90, $04, nRst, $02, nRst
	smpsAlterVol        $01
	dc.b	$9D, $04
	smpsAlterVol        $FF
	dc.b	nRst, $02, nRst
	smpsLoop            $03, $03, Music91_Call04
	smpsReturn

Music91_Call05:
	smpsAlterVol        $FE
	dc.b	$9D, $02, $9D, nRst, $9D, $9D, nRst, $9D, $9D
	smpsAlterVol        $02
	smpsReturn

Music91_Call06:
	dc.b	$90, $04, nRst, $02, nRst
	smpsAlterVol        $01
	dc.b	$9D, $04
	smpsAlterVol        $FF
	dc.b	nRst, $02, nRst, $90, $04, nRst, $02, nRst
	smpsAlterVol        $01
	dc.b	$9D, $04
	smpsAlterVol        $FF
	dc.b	nRst, $02, nRst
	smpsLoop            $04, $13, Music91_Call06
	smpsReturn

Music91_Call07:
	dc.b	$90, $04, nRst, $02, nRst
	smpsAlterVol        $01
	dc.b	$9D, $04
	smpsAlterVol        $FF
	dc.b	nRst, $02, nRst, $90, $02
	smpsAlterVol        $FF
	dc.b	nRst, nRst, nRst
	smpsAlterVol        $FF
	dc.b	$9D, $04, $9D, nRst, $9D, $9D
	smpsReturn

; FM1 Data
Music91_FM1:
	smpsModSet          $1E, $01, $05, $05
	smpsFMvoice         $02
	smpsCall            Music91_Call19
	smpsCall            Music91_Call1A
	smpsCall            Music91_Call1B
	smpsCall            Music91_Call1C
	smpsCall            Music91_Call19
	smpsCall            Music91_Call1A
	smpsCall            Music91_Call1B
	smpsCall            Music91_Call1C
	smpsCall            Music91_Call19
	smpsCall            Music91_Call1A
	smpsCall            Music91_Call1D
	smpsJump Music91_FM1

Music91_Call19:
	dc.b	nFs3, $0C, nB3, $04, nB3, $20, nB3, $04, nCs4, nEb4, nE4, nCs4
	dc.b	$0C, nA4, $04, nA4, $20, nB3, $08, nCs4, nEb4, $0C, nAb4, $04
	dc.b	nB3, $20, nAb3, $04, nBb3, nB3, nCs4, nB3, $10, nRst, $04, nFs4
	dc.b	$08, nE4, $04, nEb4, $0C, nCs4, $04, smpsNoAttack, $10
	smpsReturn

Music91_Call1A:
	dc.b	nFs4, $0C, nB4, $04, nB4, $20, nB3, $04, nCs4, nEb4, nE4, nCs4
	dc.b	$0C, nA4, $04, nA4, $20, nB4, $08, nCs5, nB4, $0C, nEb4, $04
	dc.b	nEb4, $20, nAb4, $04, nEb4, nBb4, nB4, nEb5, $10, nRst, $04, nE5
	dc.b	$08, nCs5, $04, smpsNoAttack, $20
	smpsReturn

Music91_Call1B:
	dc.b	nFs5, $08, nFs5, $04, nFs5, nRst, nFs5, $08, nB5, $0C, nCs6, $08
	dc.b	nA5, nE5, nFs5, $08, nFs5, $04, nE5, nRst, nD5, $08, nE5, $04
	dc.b	nCs5, $08, nA5, $04, nA5, $04, smpsNoAttack, $10
	smpsReturn

Music91_Call1C:
	dc.b	nFs5, $08, nFs5, $04, nFs5, nRst, nFs5, $08, nB5, $0C, nCs6, $08
	dc.b	nA5, nE5, nFs5, $10, nRst, $04, nFs6, $08, nE6, $04, nD6, $08
	dc.b	nE6, $04, nCs6, $08, nB5, nEb6, $04, smpsNoAttack, $20, smpsNoAttack, $20
	smpsReturn

Music91_Call1D:
	dc.b	nD5, $08, nE5, $04, nCs5, nRst, nB4, $08, nD5, $0C, nE5, $04
	dc.b	nCs5, $08, nB4, nEb5, $04, smpsNoAttack, $20, nRst, $18, nB4, $04, nB4
	dc.b	nRst, nB4, nB4, $08, nRst, $10
	smpsReturn

; FM2 Data
Music91_FM2:
	smpsAlterNote          $03
	smpsModSet          $1E, $01, $05, $05
	smpsFMvoice        $02
	dc.b	nRst, $04
	smpsCall            Music91_Call14
	smpsCall            Music91_Call15
	smpsCall            Music91_Call16
	smpsCall            Music91_Call17
	smpsCall            Music91_Call14
	smpsCall            Music91_Call15
	smpsCall            Music91_Call16
	smpsCall            Music91_Call17
	smpsCall            Music91_Call14
	smpsCall            Music91_Call15
	smpsCall            Music91_Call18
	smpsJump Music91_FM2

Music91_Call14:
	dc.b	nFs3, $0C, nB3, $04, nB3, $20, nB3, $04, nCs4, nEb4, nE4, nCs4
	dc.b	$0C, nA4, $04, nA4, $20, nB3, $08, nCs4, nEb4, $0C, nAb4, $04
	dc.b	nB3, $20, nAb3, $04, nBb3, nB3, nCs4, nB3, $10, nRst, $04, nFs4
	dc.b	$08, nE4, $04, nEb4, $0C, nCs4, $04, smpsNoAttack, $10
	smpsReturn

Music91_Call15:
	dc.b	nFs4, $0C, nB4, $04, nB4, $20, nB3, $04, nCs4, nEb4, nE4, nCs4
	dc.b	$0C, nA4, $04, nA4, $20, nB4, $08, nCs5, nB4, $0C, nEb4, $04
	dc.b	nEb4, $20, nAb4, $04, nEb4, nBb4, nB4, nEb5, $10, nRst, $04, nE5
	dc.b	$08, nCs5, $04, smpsNoAttack, $20
	smpsReturn

Music91_Call16:
	dc.b	nFs5, $08, nFs5, $04, nFs5, nRst, nFs5, $08, nB5, $0C, nCs6, $08
	dc.b	nA5, nE5, nFs5, $08, nFs5, $04, nE5, nRst, nD5, $08, nE5, $04
	dc.b	nCs5, $08, nA5, $04, nA5, $04, smpsNoAttack, $10
	smpsReturn

Music91_Call17:
	dc.b	nFs5, $08, nFs5, $04, nFs5, nRst, nFs5, $08, nB5, $0C, nCs6, $08
	dc.b	nA5, nE5, nFs5, $10, nRst, $04, nFs6, $08, nE6, $04, nD6, $08
	dc.b	nE6, $04, nCs6, $08, nB5, nEb6, $04, smpsNoAttack, $20, smpsNoAttack, $20
	smpsReturn

Music91_Call18:
	dc.b	nD5, $08, nE5, $04, nCs5, nRst, nB4, $08, nD5, $0C, nE5, $04
	dc.b	nCs5, $08, nB4, nEb5, $04, smpsNoAttack, $20, nRst, $10, smpsNoAttack, $04
	smpsAlterVol        $FD
	dc.b	nFs4, $04, nFs4, nRst, nFs4, nFs4, $08, nRst, $10
	smpsReturn

; FM3 Data
Music91_FM3:
	smpsPan             panRight, $00
	smpsFMvoice        $01
	smpsCall            Music91_Call10
	smpsCall            Music91_Call11
	smpsCall            Music91_Call12
	smpsCall            Music91_Call10
	smpsCall            Music91_Call11
	smpsCall            Music91_Call12
	smpsCall            Music91_Call10
	smpsCall            Music91_Call13
	smpsJump Music91_FM3

Music91_Call10:
	dc.b	nFs3, $02, nB3, nEb4, nFs4, nB3, nEb4, nFs4, nB4, nEb4, $02, nFs4
	dc.b	nB4, nEb5, nFs4, nB4, nEb5, nFs5, nB5, $02, nFs5, nEb5, nB4, nFs5
	dc.b	nEb5, nB4, nFs4, nEb5, $02, nB4, nFs4, nEb4, nB4, nFs4, nEb4, nB3
	dc.b	nE3, $02, nA3, nCs4, nE4, nA3, nCs4, nE4, nA4, nCs4, $02, nE4
	dc.b	nA4, nCs5, nE4, nA4, nCs5, nE5, nA5, $02, nE5, nCs5, nA4, nE5
	dc.b	nCs5, nA4, nE4, nCs5, $02, nA4, nE4, nCs3, nA4, nE4, nCs3, nA3
	dc.b	nEb3, $02, nAb3, nB3, nEb4, nAb3, nB3, nEb4, nAb4, nB3, $02, nEb4
	dc.b	nAb4, nB4, nEb4, nAb4, nB4, nEb5, nAb5, $02, nEb5, nB4, nAb4, nEb5
	dc.b	nB4, nAb4, nEb4, nB4, $02, nAb4, nEb4, nB3, nAb4, nEb4, nB3, nAb3
	dc.b	nB2, $02, nE3, nAb3, nB3, nE3, nAb3, nB3, nE4, nAb3, $02, nB3
	dc.b	nE4, nAb4, nB3, nE4, nAb4, nB4, nCs3, $02, nFs3, nBb3, nCs4, nFs3
	dc.b	nBb3, nCs4, nFs4, nBb3, $02, nCs4, nFs4, nBb4, nCs4, nFs4, nBb4, nCs5
	smpsLoop            $00, $02, Music91_Call10
	smpsReturn

Music91_Call11:
	dc.b	nD3, $02, nFs3, nA3, nD4, nFs3, nA3, nD4, nFs4, nA3, $02, nD4
	dc.b	nFs4, nA4, nD4, nFs4, nA4, nD5, nFs5, $02, nD5, nA4, nFs4, nD5
	dc.b	nA4, nFs4, nD4, nA4, $02, nFs4, nD4, nA3, nFs4, nD4, nA3, nFs3
	dc.b	nD3, $02, nG3, nB3, nD4, nG3, nB3, nD4, nG4, nB3, $02, nD4
	dc.b	nG4, nB4, nD4, nG4, nB4, nD5, nE5, $02, nCs5, nA4, nE4, nCs5
	dc.b	nA4, nE4, nCs4, nA4, $02, nE4, nCs4, nA3, nE4, nCs4, nA3, nE3
	smpsLoop            $01, $02, Music91_Call11
	smpsReturn

Music91_Call12:
	dc.b	nFs3, $02, nB3, nEb4, nFs4, nB3, nEb4, nFs4, nB4, nEb4, $02, nFs4
	dc.b	nB4, nEb5, nFs4, nB4, nEb5, nFs5, nB5, $02, nFs5, nEb5, nB4, nFs5
	dc.b	nEb5, nB4, nFs4, nEb5, $02, nB4, nFs4, nEb4, nB4, nFs4, nEb4, nB3
	smpsReturn

Music91_Call13:
	dc.b	nD3, $02, nG3, nB3, nD4, nG3, nB3, nD4, nG4, nB3, $02, nD4
	dc.b	nG4, nB4, nD4, nG4, nB4, nD5, nE3, $02, nA3, nCs4, nE4, nA3
	dc.b	nCs4, nE4, nA4, nCs4, $02, nE4, nA4, nCs5, nE4, nA4, nCs5, nE5
	dc.b	nB2, $02, nEb3, nFs3, nB3, nEb3, nFs3, nB3, nEb4, nFs3, $02, nB3
	dc.b	nEb4, nFs4, nB3, nEb4, nFs4, nB4, nB2, $02, nEb3, nFs3, nB3, nEb3
	dc.b	nFs3, nB3, nEb4, nFs3, $02, nB3, nEb4, nFs4, nFs4, $04, nFs4, nRst
	dc.b	nFs4, nFs4, $08, nRst, $10
	smpsReturn

; FM4 Data
Music91_FM4:
	smpsPan             panLeft, $00
	smpsFMvoice        $01
	smpsCall            Music91_Call0C
	smpsCall            Music91_Call0D
	smpsCall            Music91_Call0E
	smpsCall            Music91_Call0C
	smpsCall            Music91_Call0D
	smpsCall            Music91_Call0E
	smpsCall            Music91_Call0C
	smpsCall            Music91_Call0F
	smpsJump Music91_FM4

Music91_Call0C:
	dc.b	nRst, $02, nFs3, $02, nB3, nEb4, nFs4, nB3, nEb4, nFs4, nB4, nEb4
	dc.b	$02, nFs4, nB4, nEb5, nFs4, nB4, nEb5, nFs5, nB5, $02, nFs5, nEb5
	dc.b	nB4, nFs5, nEb5, nB4, nFs4, nEb5, $02, nB4, nFs4, nEb4, nB4, nFs4
	dc.b	nEb4, nB3, nE3, $02, nA3, nCs4, nE4, nA3, nCs4, nE4, nA4, nCs4
	dc.b	$02, nE4, nA4, nCs5, nE4, nA4, nCs5, nE5, nA5, $02, nE5, nCs5
	dc.b	nA4, nE5, nCs5, nA4, nE4, nCs5, $02, nA4, nE4, nCs3, nA4, nE4
	dc.b	nCs3, nA3, nEb3, $02, nAb3, nB3, nEb4, nAb3, nB3, nEb4, nAb4, nB3
	dc.b	$02, nEb4, nAb4, nB4, nEb4, nAb4, nB4, nEb5, nAb5, $02, nEb5, nB4
	dc.b	nAb4, nEb5, nB4, nAb4, nEb4, nB4, $02, nAb4, nEb4, nB3, nAb4, nEb4
	dc.b	nB3, nAb3, nB2, $02, nE3, nAb3, nB3, nE3, nAb3, nB3, nE4, nAb3
	dc.b	$02, nB3, nE4, nAb4, nB3, nE4, nAb4, nB4, nCs3, $02, nFs3, nBb3
	dc.b	nCs4, nFs3, nBb3, nCs4, nFs4, nBb3, $02, nCs4, nFs4, nBb4, nCs4, nFs4
	dc.b	nBb4
	smpsLoop            $00, $02, Music91_Call0C
	smpsReturn

Music91_Call0D:
	dc.b	nRst, $02, nD3, $02, nFs3, nA3, nD4, nFs3, nA3, nD4, nFs4, nA3
	dc.b	$02, nD4, nFs4, nA4, nD4, nFs4, nA4, nD5, nFs5, $02, nD5, nA4
	dc.b	nFs4, nD5, nA4, nFs4, nD4, nA4, $02, nFs4, nD4, nA3, nFs4, nD4
	dc.b	nA3, nFs3, nD3, $02, nG3, nB3, nD4, nG3, nB3, nD4, nG4, nB3
	dc.b	$02, nD4, nG4, nB4, nD4, nG4, nB4, nD5, nE5, $02, nCs5, nA4
	dc.b	nE4, nCs5, nA4, nE4, nCs4, nA4, $02, nE4, nCs4, nA3, nE4, nCs4
	dc.b	nA3
	smpsLoop            $01, $02, Music91_Call0D
	smpsReturn

Music91_Call0E:
	dc.b	nRst, $02, nFs3, $02, nB3, nEb4, nFs4, nB3, nEb4, nFs4, nB4, nEb4
	dc.b	$02, nFs4, nB4, nEb5, nFs4, nB4, nEb5, nFs5, nB5, $02, nFs5, nEb5
	dc.b	nB4, nFs5, nEb5, nB4, nFs4, nEb5, $02, nB4, nFs4, nEb4, nB4, nFs4
	dc.b	nEb4
	smpsReturn

Music91_Call0F:
	dc.b	nRst, $02, nD3, $02, nG3, nB3, nD4, nG3, nB3, nD4, nG4, nB3
	dc.b	$02, nD4, nG4, nB4, nD4, nG4, nB4, nD5, nE3, $02, nA3, nCs4
	dc.b	nE4, nA3, nCs4, nE4, nA4, nCs4, $02, nE4, nA4, nCs5, nE4, nA4
	dc.b	nCs5, nE5, nB2, $02, nEb3, nFs3, nB3, nEb3, nFs3, nB3, nEb4, nFs3
	dc.b	$02, nB3, nEb4, nFs4, nB3, nEb4, nFs4, nB4, nB2, $02, nEb3, nFs3
	dc.b	nB3, nEb3, nFs3, nB3, nEb4, nFs3, $02, nB3, nEb4, nFs4, $04, nFs4
	dc.b	nRst, nFs4, nFs4, $08, nRst, $10
	smpsReturn

; FM5 Data
Music91_FM5:
	smpsFMvoice        $00
	smpsCall            Music91_Call08
	smpsCall            Music91_Call09
	smpsCall            Music91_Call0A
	smpsCall            Music91_Call08
	smpsCall            Music91_Call09
	smpsCall            Music91_Call0A
	smpsCall            Music91_Call08
	smpsCall            Music91_Call0B
	smpsJump Music91_FM5

Music91_Call08:
	dc.b	nB1, $04, nB1, nB1, nB1, nB1, nB1, nB1, nB1, nB1, nB1, nB1
	dc.b	nB1, nB1, nB1, nB1, nB1, nA1, $04, nA1, nA1, nA1, nA1, nA1
	dc.b	nA1, nA1, nA1, nA1, nA1, nA1, nA1, nA1, nA1, nA1, nAb1, $04
	dc.b	nAb1, nAb1, nAb1, nAb1, nAb1, nAb1, nAb1, nAb1, nAb1, nAb1, nAb1, nAb1
	dc.b	$04, nAb1, nAb1, nAb1, nE1, $04, nE1, nE1, nE1, nE1, nE1, nE1
	dc.b	nE1, nFs1, $04, nFs1, nFs1, nFs1, nFs1, nFs1, nFs1, nFs1
	smpsLoop            $00, $02, Music91_Call08
	smpsReturn

Music91_Call09:
	dc.b	nD1, $04, nD1, nD1, nD1, nD1, nD1, nD1, nD1, nD1, nD1, nD1
	dc.b	nD1, nD1, nD1, nD1, nD1, nG1, $04, nG1, nG1, nG1, nG1, nG1
	dc.b	nG1, nG1, nA1, $04, nA1, nA1, nA1, nA1, nA1, nA1, nA1
	smpsLoop            $01, $02, Music91_Call09
	smpsReturn

Music91_Call0A:
	dc.b	nB1, $04, nB1, nB1, nB1, nB1, nB1, nB1, nB1, nB1, nB1, nB1
	dc.b	nB1, nB1, nB1, nB1, nB1
	smpsReturn

Music91_Call0B:
	dc.b	nG1, $04, nG1, nG1, nG1, nG1, nG1, nG1, nG1, nA1, $04, nA1
	dc.b	nA1, nA1, nA1, nA1, nA1, nA1, nB1, $04, nB1, nB1, nB1, nB1
	dc.b	nB1, nB1, nB1, nB1, nB1, nB1, nB1, nB1, nB1
	smpsAlterVol        $FD
	dc.b	nB1, $04, nB1, nRst, nB1, nB1, $08, nRst, $10
	smpsReturn

; PSG1 Data
Music91_PSG1:
	smpsCall            Music91_Call1E
	smpsCall            Music91_Call1F
	smpsCall            Music91_Call20
	smpsCall            Music91_Call21
	smpsCall            Music91_Call22
	smpsCall            Music91_Call1F
	smpsCall            Music91_Call20
	smpsCall            Music91_Call21
	smpsJump            Music91_PSG1

Music91_Call1E:
	dc.b	nEb4, $20, smpsNoAttack, $10, nEb4, $08, nEb4, nE4, $20, smpsNoAttack, $20
	smpsReturn

Music91_Call1F:
	dc.b	nEb4, $20, smpsNoAttack, $20, nEb4, $20, nCs4, $10, nFs4, $08, nE4, nEb4
	dc.b	$20, smpsNoAttack, $20, nE4, $20, smpsNoAttack, $20, nEb4, $20, smpsNoAttack, $20, nB3
	dc.b	$20, nCs4, $10, nFs4, $08, nE4
	smpsReturn

Music91_Call20:
	dc.b	nD4, $20, nCs4, $10, nFs4, $08, nE4, nB3, $20, nCs4, $10, nFs4
	dc.b	$08, nE4
	smpsLoop            $00, $02, Music91_Call20
	smpsReturn

Music91_Call21:
	dc.b	nEb4, $20, nE4, $08, nFs4, nAb4, nBb4
	smpsReturn

Music91_Call22:
	dc.b	nB4, $20, smpsNoAttack, $10, nFs4, $08, nEb4, nE4, $20, smpsNoAttack, $20
	smpsReturn

; PSG2 Data
Music91_PSG2:
; PSG3 Data
Music91_PSG3:
	smpsStop

Music91_Voices:
;	Voice $00
	dc.b	$3A
	dc.b	$31, $20, $41, $61, 	$8F, $8F, $8E, $54, 	$0E, $03, $0E, $03
	dc.b	$00, $00, $00, $00, 	$13, $F3, $13, $0A, 	$17, $21, $19, $80
;	Voice $01
	dc.b	$3D
	dc.b	$01, $02, $02, $02, 	$10, $50, $50, $50, 	$07, $08, $08, $08
	dc.b	$01, $00, $00, $00, 	$20, $17, $17, $17, 	$1C, $88, $88, $88
;	Voice $02
	dc.b	$38
	dc.b	$33, $01, $51, $01, 	$10, $13, $1A, $1B, 	$0F, $1F, $1F, $1F
	dc.b	$01, $01, $01, $01, 	$33, $03, $03, $08, 	$16, $1A, $19, $80
