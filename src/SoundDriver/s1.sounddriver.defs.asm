
ym2612_a0:		equ	$A04000
ym2612_d0:		equ	$A04001
ym2612_a1:		equ	$A04002
ym2612_d1:		equ	$A04003

psg_input:		equ	$C00011

; Sound driver constants
TrackPlaybackControl:	equ	0		; All tracks
TrackVoiceControl:	equ	1		; All tracks
TrackTempoDivider:	equ	2		; All tracks
TrackDataPointer:	equ	4		; All tracks (4 bytes)
TrackTranspose:		equ	8		; FM/PSG only (sometimes written to as a word, to include TrackVolume)
TrackVolume:		equ	9		; FM/PSG only
TrackAMSFMSPan:		equ	$A		; FM/DAC only
TrackVoiceIndex:	equ	$B		; FM/PSG only
TrackVolEnvIndex:	equ	$C		; PSG only
TrackStackPointer:	equ	$D		; All tracks
TrackDurationTimeout:	equ	$E		; All tracks
TrackSavedDuration:	equ	$F		; All tracks
TrackSavedDAC:		equ	$10		; DAC only
TrackFreq:		equ	$10		; FM/PSG only (2 bytes)
TrackNoteTimeout:	equ	$12		; FM/PSG only
TrackNoteTimeoutMaster:	equ	$13		; FM/PSG only
TrackModulationPtr:	equ	$14		; FM/PSG only (4 bytes)
TrackModulationWait:	equ	$18		; FM/PSG only
TrackModulationSpeed:	equ	$19		; FM/PSG only
TrackModulationDelta:	equ	$1A		; FM/PSG only
TrackModulationSteps:	equ	$1B		; FM/PSG only
TrackModulationVal:	equ	$1C		; FM/PSG only (2 bytes)
TrackDetune:		equ	$1E		; FM/PSG only
TrackPSGNoise:		equ	$1F		; PSG only
TrackFeedbackAlgo:	equ	$1F		; FM only
TrackNoteOutput:	equ	$20		; Currently played note output for Sound test, can be modified by outside of SMPS.
						; $00 = rest, $01..5F = note pressed, $81..DF = note press acknowledged by Sound test (if active)
						; NOTE: Sound test adds $80 to this byte once it registers note change; this trick allows re-register pressing of the same note
						; WARNING! Overwrites MSB of voice pointer below; no side effects and unused in BGM tracks)
TrackVoicePtr:		equ	$20		; FM SFX only (4 bytes)
TrackLoopCounters:	equ	$24		; All tracks (multiple bytes)
TrackGoSubStack:	equ	TrackSz	; All tracks (multiple bytes. This constant won't get to be used because of an optimisation that just uses TrackSz)

TrackSz:		equ	$30


; Sound driver RAM
v_startofvariables:	equ	$000
v_sndprio:		equ	$000	; sound priority (priority of new music/SFX must be higher or equal to this value or it won't play; bit 7 of priority being set prevents this value from changing)
v_main_tempo_timeout:	equ	$001	; Counts down to zero; when zero, resets to next value and delays song by 1 frame
v_main_tempo:		equ	$002	; Used for music only
f_pausemusic:		equ	$003	; flag set to stop music when paused
v_fadeout_counter:	equ	$004
v_last_bgm:		equ	$005	; ++ last played BGM id
v_fadeout_delay:	equ	$006
v_communication_byte:	equ	$007	; used in Ristar to sync with a boss' attacks; unused here
f_updating_dac:		equ	$008	; $80 if updating DAC, $00 otherwise
v_sound_id:		equ	$009	; sound or music copied from below
v_soundqueue_start:	equ	$00A
v_soundqueue0:		equ	v_soundqueue_start+0	; sound or music to play
v_soundqueue1:		equ	v_soundqueue_start+1	; special sound to play
v_soundqueue2:		equ	v_soundqueue_start+2	; unused sound to play
v_soundqueue_end:	equ	v_soundqueue_start+3

f_voice_selector:	equ	$00E	; $00 = use music voice pointer; $40 = use special voice pointer; $80 = use track voice pointer
v_revsound:             equ	$00F  ; ++ revving sound effect

v_voice_ptr:		equ	$018	; voice data pointer (4 bytes)

v_special_voice_ptr:	equ	$020	; voice data pointer for special SFX ($D0-$DF) (4 bytes)

f_fadein_flag:		equ	$024	; Flag for fade in
v_fadein_delay:		equ	$025
v_fadein_counter:	equ	$026	; Timer for fade in/out
f_1up_playing:		equ	$027	; flag indicating 1-up song is playing
v_tempo_mod:		equ	$028	; music - tempo modifier
v_speeduptempo:		equ	$029	; music - tempo modifier with speed shoes
f_speedup:		equ	$02A	; flag indicating whether speed shoes tempo is on ($80) or off ($00)
v_ring_speaker:		equ	$02B	; which speaker the "ring" sound is played in (00 = right; 01 = left)
f_push_playing:		equ	$02C	; if set, prevents further push sounds from playing

v_music_track_ram:	equ	$040	; Start of music RAM

v_music_fmdac_tracks:	equ	v_music_track_ram+TrackSz*0
v_music_dac_track:	equ	v_music_fmdac_tracks+TrackSz*0
v_music_fm_tracks:	equ	v_music_fmdac_tracks+TrackSz*1
v_music_fm1_track:	equ	v_music_fm_tracks+TrackSz*0
v_music_fm2_track:	equ	v_music_fm_tracks+TrackSz*1
v_music_fm3_track:	equ	v_music_fm_tracks+TrackSz*2
v_music_fm4_track:	equ	v_music_fm_tracks+TrackSz*3
v_music_fm5_track:	equ	v_music_fm_tracks+TrackSz*4
v_music_fm6_track:	equ	v_music_fm_tracks+TrackSz*5
v_music_fm_tracks_end:	equ	v_music_fm_tracks+TrackSz*6
v_music_fmdac_tracks_end:	equ	v_music_fm_tracks_end
v_music_psg_tracks:	equ	v_music_fmdac_tracks_end
v_music_psg1_track:	equ	v_music_psg_tracks+TrackSz*0
v_music_psg2_track:	equ	v_music_psg_tracks+TrackSz*1
v_music_psg3_track:	equ	v_music_psg_tracks+TrackSz*2
v_music_psg_tracks_end:	equ	v_music_psg_tracks+TrackSz*3
v_music_track_ram_end:	equ	v_music_psg_tracks_end

v_sfx_track_ram:	equ	v_music_track_ram_end	; Start of SFX RAM, straight after the end of music RAM

v_sfx_fm_tracks:	equ	v_sfx_track_ram+TrackSz*0
v_sfx_fm3_track:	equ	v_sfx_fm_tracks+TrackSz*0
v_sfx_fm4_track:	equ	v_sfx_fm_tracks+TrackSz*1
v_sfx_fm5_track:	equ	v_sfx_fm_tracks+TrackSz*2
v_sfx_fm_tracks_end:	equ	v_sfx_fm_tracks+TrackSz*3
v_sfx_psg_tracks:	equ	v_sfx_fm_tracks_end
v_sfx_psg1_track:	equ	v_sfx_psg_tracks+TrackSz*0
v_sfx_psg2_track:	equ	v_sfx_psg_tracks+TrackSz*1
v_sfx_psg3_track:	equ	v_sfx_psg_tracks+TrackSz*2
v_sfx_psg_tracks_end:	equ	v_sfx_psg_tracks+TrackSz*3
v_sfx_track_ram_end:	equ	v_sfx_psg_tracks_end

v_spcsfx_track_ram:	equ	v_sfx_track_ram_end	; Start of special SFX RAM, straight after the end of SFX RAM

v_spcsfx_fm4_track:	equ	v_spcsfx_track_ram+TrackSz*0
v_spcsfx_psg3_track:	equ	v_spcsfx_track_ram+TrackSz*1
v_spcsfx_track_ram_end:	equ	v_spcsfx_track_ram+TrackSz*2

v_1up_ram_copy:		equ	v_spcsfx_track_ram_end
