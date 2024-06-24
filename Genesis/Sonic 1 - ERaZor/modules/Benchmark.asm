
; =============================================================================
; -----------------------------------------------------------------------------
; Sonic 1 ERaZor Benchmarking program
;
; (c) 2024, vladikcomper
; -----------------------------------------------------------------------------

Benchmark:
	Console.Run @self

; -----------------------------------------------------------------------------
@self:
	Console.SetXY #1, #1
	Console.WriteLine "%<pal1>Sonic 1 ERaZor Self-Benchmark%<endl>"

	; Reset VSyncWaitTicks (64-bit integer) just in case
	moveq	#0, d0
	move.l	d0, VSyncWaitTicks
	move.l	d0, VSyncWaitTicks_64bit

	jsr	Benchmark.MeasureFreeFrameTicks		; d0 .w	- Avg ticks per free frame
	jsr	Benchmark.RunSimulations		; make sure we're sane
	;jmp	Benchmark.Run
	;fallthrough

; -----------------------------------------------------------------------------
; Runs actual benchmark
; -----------------------------------------------------------------------------

Benchmark.Run:

; -------
; INPUT
; -------
@frame_vsync_ticks:		equr	d0	; .w

; ----------------
; USED REGISTERS
; ----------------

; WARNING! DO NOT change order of these for MOVEM to work (see below)
@vsync_wait_ticks_64bit:	equr	d1	; .l
@vsync_wait_ticks:		equr	d2	; .l
@all_frames:			equr	d3	; .l
@non_lag_frames:		equr	d4	; .l
@var0:				equr	d5	;	General-purpose variable #1
@var1:				equr	d6	;	General-purpose variable #2

	move	#$2700, sr			; don't want Sonic 1 interrupts now
	move.w	@frame_vsync_ticks, -(sp)

	Console.WriteLine "%<pal1>PRESS START TO RUN BENCHMARK..."

	; -----------------------------
	; Wait until Start is pressed
	; -----------------------------

	move.w	#0, -(sp)			; allocate memory for joypad

	@WaitStartButton:
		jsr	MDDBG__VSync			; this VSync doesn't require 68K interrupts
		lea	(sp), a0			; a0 = joypad RAM
		lea	$A10003, a1			; a1 = IO port
		bsr	@ReadJoypad			; read the joy!
		tst.b	1(sp)				; are we Start?
		bpl.s	@WaitStartButton		; fuck no

	addq.w	#2, sp				; free joypad memory

	; ---------------------
	; Run the actual shit
	; ---------------------

	move.l	VBlank_NonLagFrameCounter, -(sp)
	move.l	VBlank_FrameCounter, -(sp)
	move.l	VSyncWaitTicks, -(sp)
	move.l	VSyncWaitTicks_64bit, -(sp)

	jsr	VDPSetupGame			; switch to Sonic 1 VDP settings
	move.b	#$C, $FFFFF600			; simulate "normal level" mode (because it checks game mode)
	move.w	#$002, $FFFFFE10		; set level to GHP
	jsr	Level				; PLAY IT!!!11

	bsr	@ReloadConsoleMode		; must restore MD Shell after running "sandboxed" Sonic 1 game mode

	; --------------------------
	; Report benchmark results
	; --------------------------

	Console.SetXY #1, #1
	Console.WriteLine "%<pal1>BENCHMARK RESULTS:%<endl>"

	; Report BEFORE and AFTER counters, calculate delta ...
	movem.l	(sp)+, @vsync_wait_ticks_64bit/@vsync_wait_ticks/@all_frames/@non_lag_frames
	move.w	(sp)+, @frame_vsync_ticks

	Console.WriteLine "%<pal3>Source data:"
	Console.WriteLine "%<pal2>Ticks per frame: %<pal0>%<.w @frame_vsync_ticks>"
	Console.WriteLine "%<pal2>BEFORE: %<pal0>wait=%<.l @vsync_wait_ticks_64bit>_%<.l @vsync_wait_ticks>,"
	Console.WriteLine "  frames=%<.l @all_frames>, non_lag=%<.l @non_lag_frames>"
	Console.WriteLine "%<pal2>AFTER:  %<pal0>wait=%<.l VSyncWaitTicks_64bit>_%<.l VSyncWaitTicks>,"
	Console.WriteLine "  frames=%<.l VBlank_FrameCounter>, non_lag=%<.l VBlank_NonLagFrameCounter>"

	movem.l	VSyncWaitTicks_64bit, @var0/@var1	; @var0..@var1 = VSyncWaitTicks_End (64-bit integer)
	sub.l	@vsync_wait_ticks, @var1		; @var0..@var1 = VSyncWaitTicks_End - VSyncWaitTicks_Start
	subx.l	@vsync_wait_ticks_64bit, @var0
	exg.l	@vsync_wait_ticks, @var1		; @vsync_wait_ticks_64..@vsync_wait_ticks = VSyncWaitTicks_End - VSyncWaitTicks_Start
	exg.l	@vsync_wait_ticks_64bit, @var0

	sub.l	VBlank_FrameCounter, @all_frames
	neg.l	@all_frames

	sub.l	VBlank_NonLagFrameCounter, @non_lag_frames
	neg.l	@non_lag_frames

	Console.WriteLine "%<pal2>DELTA:  %<pal0>wait=%<.l @vsync_wait_ticks_64bit>_%<.l @vsync_wait_ticks>,"
	Console.WriteLine "  frames=%<.l @all_frames>, non_lag=%<.l @non_lag_frames>"


	; Calculate actual score and other useful info
	Console.WriteLine "%<endl>%<endl>%<pal3>Calculated results:%<endl>"
	move.l	@all_frames, @var0
	mulu.w	@frame_vsync_ticks, @var0
	sub.l	@vsync_wait_ticks, @var0
	Console.WriteLine "%<pal1>SCORE: %<pal0>%<.l @var0> ticks%<endl>"

	divu.w	@non_lag_frames, @var0
	Console.WriteLine "%<pal2>Avg frame load: %<pal0>%<.w @var0>/%<.w @frame_vsync_ticks>"

	Console.WriteLine "%<pal2>Game frames: %<pal0>%<.l @non_lag_frames dec>"

	move.l	@all_frames, @var1
	sub.l	@non_lag_frames, @var1
	Console.WriteLine "%<pal2>Lagged frames: %<pal0>%<.l @var1 dec>"

	rts

; -----------------------------------------------------------------------------
; Read joypad variant from MD Shell, unaffected by MD Replay
@ReadJoypad:
	move.b	#0, (a1)			; command to poll for A/Start
	nop					; wait for port (0/1)
	moveq	#$FFFFFFC0, d1			; wait for port (1/1) ... and do useful work (0/1)
	move.b	(a1), d0			; get data for A/Start
	lsl.b	#2, d0
	move.b	#$40, (a1)			; command to poll for B/C/UDLR
	nop							; wait for port (0/1)
	and.b	d1, d0				; wait for port (1/1) ... and do useful work (1/1)
	move.b	(a1), d1			; get data for B/C/UDLR
	andi.b	#$3F, d1
	or.b	d1, d0				; d0 = held buttons bitfield (negated)
	not.b	d0					; d0 = held buttons bitfield (normal)
	move.b	(a0), d1			; d1 = previously held buttons
	eor.b	d0, d1				; toggle off buttons that are being pressed
	move.b	d0, (a0)+			; put raw controller input (for held buttons)
	and.b	d0, d1
	move.b	d1, (a0)+			; put pressed controller input
	rts

; -----------------------------------------------------------------------------
@ReloadConsoleMode:
	move	#$2700, sr
	movem.l	d0-a6, -(sp)
	move.l	usp, a3				; Console RAM was already allocated
	jsr	MDDBG__ErrorHandler_SetupVDP(pc)
	jsr	MDDBG__Error_InitConsole(pc)
	movem.l	(sp)+, d0-a6
	rts


; =============================================================================
; -----------------------------------------------------------------------------
; Runs simulations to make sure we're sane
; -----------------------------------------------------------------------------

Benchmark.RunSimulations:

@Num_Simulations:	= 5

; ------
; INPUT
; ------
@frame_vsync_ticks:	equr	d0	; .w

; ---------------
; USED REGISTERS
; ---------------
@var0:			equr	d1
@var1:			equr	d2
@simulation_cnt:	equr	d5
@frame_cnt:		equr	d6
@scanline_cnt:		equr	d7
@simulation_stats:	equr	a0
@simulation_record:	equr	a1


	swap	@frame_vsync_ticks	; extend .w to .l (unsigned)
	clr.w	@frame_vsync_ticks	; ''
	swap	@frame_vsync_ticks	; ''

	VBlank_SetMusicOnly
	Console.WriteLine "%<pal3>Benchmark.RunSimulations():"
	Console.WriteLine "%<pal2>Simulations:%<pal0>"
	jsr	Benchmark.SynchronizeToVBlank

	lea	-@Num_Simulations*6(sp), sp
	lea	(sp), @simulation_stats
	lea	@Simulations, @simulation_record
	moveq	#@Num_Simulations-1, @simulation_cnt

	@RunSimulations:
		move.l	VBlank_FrameCounter, -(sp)
		move.l	VSyncWaitTicks, -(sp)
		move.w	(@simulation_record), @frame_cnt

		@RunSimulationFrames:
			move.w	2(@simulation_record), @scanline_cnt
			@DoScanline:
				bsr	@wasteScanline
				dbf	@scanline_cnt, @DoScanline
			st.b	VBlankRoutine			; routine = $FF (dummy), this only works if `VBlank_MusicOnly` is set
			jsr	DelayProgram			; ''
			dbf	@frame_cnt, @RunSimulationFrames

		; Collect simulation stats
		move.l	VSyncWaitTicks, @var0
		sub.l	(sp)+, @var0				; @var0 = End_ticks - Start_ticks
		move.l	@var0, (@simulation_stats)+		; STATS => Total VSync ticks (non-lag frames)
		move.l	VBlank_FrameCounter, @frame_cnt
		sub.l	(sp)+, @frame_cnt			; @frame_cnt = End_VBlankFrames - Start_VBlankFrames
		move.b	@frame_cnt, (@simulation_stats)+	; STATS => Total frames
		sub.w	(@simulation_record), @frame_cnt	; (VBlankFrames_End - VBlankFrames_Start) - frames + 1
		subq.w	#1, @frame_cnt				; (VBlankFrames_End - VBlankFrames_Start) - frames
		move.b	@frame_cnt, (@simulation_stats)+	; STATS => Lag frames

		addq.w	#4, @simulation_record			; next simulation record
		dbf	@simulation_cnt, @RunSimulations

	lea	(sp), @simulation_stats
	moveq	#@Num_Simulations-1, @simulation_cnt

	@CollectSimulationStats:
		Console.WriteLine "frames=%<.b 4(@simulation_stats)>, lagged=%<.b 5(@simulation_stats)>, wait=%<.l (@simulation_stats)>"

		moveq	#0, @var0
		move.b	4(@simulation_stats), @var0		; @var0	= total_frames
		mulu.w	@frame_vsync_ticks, @var0		; @var0 = total_frames * @frame_vsync_ticks
		move.l	@var0, @var1				; @var1 = Full load ticks
		sub.l	(@simulation_stats), @var0		; @var0 = Total in-game ticks
		Console.WriteLine "all=%<.l @var1>, busy=%<.l @var0>"

		addq.w	#6, @simulation_stats			; next simulation stat
		dbf	@simulation_cnt, @CollectSimulationStats

	Console.BreakLine

	lea	@Num_Simulations*6(sp), sp
	VBlank_UnsetMusicOnly
	rts

; -----------------------------------------------------------------------------
@Simulations:
	;	num frames-1,	load in scanlines-1
	dc.w	20-1,		1-1
	dc.w	20-1,		224-1
	dc.w	20-1,		262-1
	dc.w	10-1,		1000-1
	dc.w	20-1,		1000-1
@Simulations_End:

	if (@Simulations_End-@Simulations)/4<>@Num_Simulations
		inform 2, "Wrong number of simulations is list: \#@Num_Simulations\ expected"
	endif

; -----------------------------------------------------------------------------
@wasteScanline:
	move.w	d0, -(sp)
	move	#44, d0
	dbf	d0, *		; waste ~440 cycles
	move.w	(sp)+, d0
	rts


; =============================================================================
; -----------------------------------------------------------------------------
; Synchonizes to start of VBlank
; -----------------------------------------------------------------------------

Benchmark.SynchronizeToVBlank:
	VBlank_SetMusicOnly
	rept 2
		st.b	VBlankRoutine			; routine = $FF (dummy), this only works if `VBlank_MusicOnly` is set
		jsr	DelayProgram			; ''
	endr
	VBlank_UnsetMusicOnly
	rts


; =============================================================================
; -----------------------------------------------------------------------------
; Subroutine to measure avg VSync ticks for "free frames"
; -----------------------------------------------------------------------------

Benchmark.MeasureFreeFrameTicks:

@NumMeasures:	= 6

; ---------------
; USED REGISTERS
; ---------------
@var0:		equr	d0	; .l	Generic variables
@max_ticks:	equr	d1	; .l
@min_ticks:	equr	d2	; .l
@sum_ticks:	equr	d3	; .l
@measure_cnt:	equr	d7	; .w	Measure counter for DBF
@ticks_array:	equr	a0	;	Ticks array (reloaded from stack)

; -------
; OUTPUT
; -------
@return:	equr	d0	; .w	Average ticks pre "free frame"


	VBlank_SetMusicOnly			; don't do shit in VBlank
	jsr	Benchmark.SynchronizeToVBlank	; to make measurements stable

	Console.WriteLine "%<pal3>Benchmark.MeasureFreeFrameTicks():"

	; We want to see how many ticks a "free" frame takes
	lea	-@NumMeasures*4(sp), sp		; allocate `ticks_array` (@NumMeasures * 4 bytes on stack)
	lea	(sp), @ticks_array
	moveq	#@NumMeasures-1, @measure_cnt

	@MeasureFreeFrameTicks:
		move.l	VSyncWaitTicks, @var0		; @var0 = Start_ticks
		st.b	VBlankRoutine			; routine = $FF (dummy), this only works if `VBlank_MusicOnly` is set
		jsr	DelayProgram			; 
		sub.l	VSyncWaitTicks, @var0		; @var0 = Start_ticks - End_ticks
		neg.l	@var0				; @var0 = End_ticks - Start_ticks
		move.l	@var0, (@ticks_array)+		; write down ticks
		dbf	@measure_cnt, @MeasureFreeFrameTicks


	; Dump measurements
	lea	(sp), @ticks_array
	moveq	#@NumMeasures-1, @measure_cnt
	Console.WriteLine "%<pal2>Measured free frame ticks:%<pal0,setw,36>"
	
	@DisplayMeasures:
		Console.Write "%<.l (@ticks_array)+> "
		dbf	@measure_cnt, @DisplayMeasures
		Console.Write "%<setw,38,endl>"

	; Collect statitics: SUM, MIN, MAX
	lea	(sp), @ticks_array
	moveq	#@NumMeasures-1, @measure_cnt
	moveq	#$FFFFFFFF, @min_ticks
	moveq	#0, @max_ticks
	moveq	#0, @sum_ticks

	@CollectStatisticsLoop:
		move.l	(@ticks_array)+, @var0

		cmp.l	@var0, @min_ticks
		bls.s	@min_done
		move.l	@var0, @min_ticks
	@min_done:

		cmp.l	@var0, @max_ticks
		bhs.s	@max_done
		move.l	@var0, @max_ticks
	@max_done:

		add.l	@var0, @sum_ticks
		dbf	@measure_cnt, @CollectStatisticsLoop


	; Calculate average (MIN and MAX excluded)
	move.l	@sum_ticks, @return
	sub.l	@max_ticks, @return
	sub.l	@min_ticks, @return
	divu.w	#@NumMeasures-2, @return	; @return = corrected average ticks from @NumMeasures measurements

	Console.WriteLine "%<pal2>Statistics:%<pal0>"
	Console.WriteLine "MIN = %<.l @min_ticks>"
	Console.WriteLine "MAX = %<.l @max_ticks>"
	Console.WriteLine "SUM = %<.l @sum_ticks>"
	Console.WriteLine "AVG = %<.w @return>"

	Console.BreakLine

	lea	@NumMeasures*4(sp), sp		; de-allocate `ticks_array`
	VBlank_UnsetMusicOnly			; doing srs shit in VBlank now
	rts
