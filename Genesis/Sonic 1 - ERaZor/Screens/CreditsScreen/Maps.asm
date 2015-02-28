; ===========================================================================
; ---------------------------------------------------------------------------
; Scrolling
; ---------------------------------------------------------------------------
;	dc.b	$0D						; Number of lines
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
;	dc.b	"                    ",$FF
; ---------------------------------------------------------------------------

CreditsMaps:

	dc.w	$0100						; time for each section to scroll
	dc.w	$0001						; current timer
	dc.l	$00FF000C					; start address
	dc.l	EndText-StartText				; number of sections

StartText:
	; 1
	dc.b	$0D						; Number of lines
	dc.b	"                    ",$FF
	dc.b	"  CREATED AND MAIN  ",$FF
	dc.b	"                    ",$FF
	dc.b	"   PROGRAMMING BY   ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"       SELBI        ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF

	; 2
	dc.b	$0D						; Number of lines
	dc.b	"                    ",$FF
	dc.b	" WITH GRAPHICS AND  ",$FF
	dc.b	"                    ",$FF
	dc.b	" SPECIAL HELP FROM  ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"    MARKEYJESTER    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF

	; 3
	dc.b	$0D						; Number of lines
	dc.b	"                    ",$FF
	dc.b	"   AND ADDITIONAL   ",$FF
	dc.b	"                    ",$FF
	dc.b	"   PROGRAMMING BY   ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"    VLADIKCOMPER    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF

	; 4
	dc.b	$0D						; Number of lines
	dc.b	"                    ",$FF
	dc.b	"   MUSIC CREATED    ",$FF
	dc.b	"                    ",$FF
	dc.b	"         BY         ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"      DALEKSAM      ",$FF
	dc.b	"                    ",$FF
	dc.b	"      SPANNER       ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF

	; 5
	dc.b	$0D						; Number of lines
	dc.b	"                    ",$FF
	dc.b	"  SOUND DRIVER AND  ",$FF
	dc.b	"                    ",$FF
	dc.b	"      MUSIC BY      ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"      EDUARDO       ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF

	; 6
	dc.b	$0D						; Number of lines
	dc.b	"                    ",$FF
	dc.b	" MAIN BETA TESTING  ",$FF
	dc.b	"                    ",$FF
	dc.b	"         BY         ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"     SONICVAAN      ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF

	; 7
	dc.b	$0D						; Number of lines
	dc.b	"                    ",$FF
	dc.b	"   SPECIAL THANKS   ",$FF
	dc.b	"                    ",$FF
	dc.b	"         TO         ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"     MAINMEMORY     ",$FF
	dc.b	"                    ",$FF
	dc.b	"       JORGE        ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF

	; 8
	dc.b	$0D						; Number of lines
	dc.b	"                    ",$FF
	dc.b	"  ADDITIONAL TEXT   ",$FF
	dc.b	"                    ",$FF
	dc.b	"      HELP BY       ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"       KAIDAN       ",$FF
	dc.b	"                    ",$FF
	dc.b	"       ABCRON       ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF

	; 9
	dc.b	$0D						; Number of lines
	dc.b	"                    ",$FF
	dc.b	"     EASTER EGG     ",$FF
	dc.b	"                    ",$FF
	dc.b	"      STORY BY      ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"      TONGARA       ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF

	; 10
	dc.b	$0D						; Number of lines
	dc.b	"                    ",$FF
	dc.b	"   ORIGINAL GAME    ",$FF
	dc.b	"                    ",$FF
	dc.b	"         BY         ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"     SONIC TEAM     ",$FF
	dc.b	"                    ",$FF
	dc.b	"        SEGA        ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF

	; 11
	dc.b	$0D						; Number of lines
	dc.b	"                    ",$FF
	dc.b	"     THANKS FOR     ",$FF
	dc.b	"                    ",$FF
	dc.b	"      PLAYING       ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"    PRESS START     ",$FF
	dc.b	"                    ",$FF
	dc.b	"     TO RETURN      ",$FF
	dc.b	"                    ",$FF
	dc.b	"   TO SEGA SCREEN   ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF
	dc.b	"                    ",$FF

EndText:

; ---------------------------------------------------------------------------
; ===========================================================================