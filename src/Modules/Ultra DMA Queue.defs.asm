; ---------------------------------------------------------------------------
; Ultra DMA Queue
;
; (c) flamewing
; ASM68K port by Vladikcomper
; ---------------------------------------------------------------------------

; This option makes the function work as a drop-in replacement of the original
; functions. If you modify all callers to supply a position in words instead of
; bytes (i.e., divide source address by 2) you can set this to 0 to gain 10(1/0)
AssumeSourceAddressInBytes = 1

; This option (which is disabled by default) makes the DMA queue assume that the
; source address is given to the function in a way that makes them safe to use
; with RAM sources. You need to edit all callers to ensure this.
; Enabling this option turns off UseRAMSourceSafeDMA, and saves 14(2/0).
AssumeSourceAddressIsRAMSafe = 0

; This option (which is enabled by default) makes source addresses in RAM safe
; at the cost of 14(2/0). If you modify all callers so as to clear the top byte
; of source addresses (i.e., by ANDing them with $FFFFFF).
UseRAMSourceSafeDMA = 1&(AssumeSourceAddressIsRAMSafe=0)

; This option breaks DMA transfers that crosses a 128kB block into two. It is
; disabled by default because you can simply align the art in ROM and avoid the
; issue altogether. It is here so that you have a high-performance routine to do
; the job in situations where you can't align it in ROM.
Use128kbSafeDMA = 0

; This option forces the game to report an exception if DMA crosses a 128kb
; boundary. Only available in DEBUG builds and if `Use128kbSafeDMA` isn't used.
FailOn128kbBoundaryCross = 1&(Use128kbSafeDMA=0)&def(__DEBUG__)

; Option to mask interrupts while updating the DMA queue. This fixes many race
; conditions in the DMA funcion, but it costs 46(6/1) cycles. The better way to
; handle these race conditions would be to make unsafe callers (such as S3&K's
; KosM decoder) prevent these by masking off interrupts before calling and then
; restore interrupts after.
UseVIntSafeDMA = 0

; ---------------------------------------------------------------------------
; DMA Queue entry structure
; ---------------------------------------------------------------------------

DMAEntry:		equ	__rs
DMAEntry.Reg94:		rs.b	1
DMAEntry.Size:		equ	__rs
DMAEntry.SizeH:		rs.b	1
DMAEntry.Reg93:		rs.b	1
DMAEntry.Source:	equ	__rs
DMAEntry.SizeL:		rs.b	1
DMAEntry.Reg97:		rs.b	1
DMAEntry.SrcH:		rs.b	1
DMAEntry.Reg96:		rs.b	1
DMAEntry.SrcM:		rs.b	1
DMAEntry.Reg95:		rs.b	1
DMAEntry.SrcL:		rs.b	1
DMAEntry.Command:	rs.l	1
DMAEntry.len:		equ	__rs

; ---------------------------------------------------------------------------
	if DMAQueuePos<=DMAQueue
		inform 3, "DMAQueuePos must be located at the end of DMAQueue"
	endif

QueueSlotCount: equ (DMAQueuePos-DMAQueue)/DMAEntry.len

; ---------------------------------------------------------------------------
setDmaSource:	macro *,addr
		\*: equ ((addr>>1)&$7FFFFF)
		endm
setDmaLength:	macro *,len
		\*: equ ((len>>1)&$7FFF)
		endm

; ---------------------------------------------------------------------------
cDMA:	equ	%100111
cVRAM:	equ	%100001

vdpCommReg macro reg,type,rwd,clear
	lsl.l	#2,\reg					; Move high bits into (word-swapped) position, accidentally moving everything else
	@upperbits: = (type&rwd)&3
	if @upperbits<>0
		addq.w	#@upperbits,\reg		; Add upper access type bits
	endif
	ror.w	#2, \reg				; Put upper access type bits into place, also moving all other bits into their correct (word-swapped) places
	swap	\reg					; Put all bits in proper places
	if \clear<>0
		andi.w	#3, \reg			; Strip whatever junk was in upper word of reg
	endif
	@lowerbits:= (type&rwd)&$FC
	if @lowerbits=$20
		tas.b	\reg				; Add in the DMA flag -- tas fails on memory, but works on registers
	elseif @lowerbits<>0
		ori.w	#(@lowerbits<<2), \reg		; Add in missing access type bits
	endif
	endm

; ---------------------------------------------------------------------------
; Expects source address and DMA length in bytes. Also, expects source, size, and dest to be known
; at assembly time. Gives errors if DMA starts at an odd address, transfers
; crosses a 128kB boundary, or has size 0.
QueueStaticDMA macro src,length,dest
	if ((\length)&1)<>0
		inform 3,"DMA an odd number of bytes $\length!"
	endif
	if (\length)=0
		inform 3,"DMA transferring 0 bytes (becomes a 128kB transfer). If you really mean it, pass 128kB instead."
	endif
	if UseVIntSafeDMA=1
		ints_push
	endif ; UseVIntSafeDMA=1
	movea.w	DMAQueuePos, a1
	cmpa.w	#DMAQueuePos, a1
	beq.s	@done\@					; Return if there's no more room in the buffer
	@len\@: setDmaLength \length
	@src\@: setDmaSource \src
	move.b	#(@len\@>>8)&$FF, DMAEntry.SizeH(a1)	; Write top byte of size/2
	move.l	#((@len\@&$FF)<<24)|@src\@, d0		; Set d0 to bottom byte of size/2 and the low 3 bytes of source/2
	movep.l	d0, DMAEntry.SizeL(a1)			; Write it all to the queue
	lea	DMAEntry.Command(a1),a1			; Seek to correct RAM address to store VDP DMA command
	if type(\dest)&(1<<14)				; is `dest` a register?
		move.l	\dest, (a1)+
	else
		move.l	#$40000000+(((\dest)&$3FFF)<<16)+(((\dest)&$C000)>>14)+$80, (a1)+	; Write VDP DMA command for destination address
	endif
	move.w	a1, DMAQueuePos				; Write next queue slot
@done\@:
	if UseVIntSafeDMA=1
		ints_pop
	endif ;UseVIntSafeDMA=1
	endm

; ---------------------------------------------------------------------------
; MACRO ResetDMAQueue
; Clears the DMA queue, discarding all previously-queued DMAs.
; ---------------------------------------------------------------------------

ResetDMAQueue macro
	move.w	#DMAQueue, DMAQueuePos
	endm
