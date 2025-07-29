; this file contains everything text related throughout the entire game

; ===========================================================================
; ---------------------------------------------------------------------------
; StoryScreen texts

; Max lines per page: 15
; Max characters per line: 28
; ---------------------------------------------------------------------------

STS_Continue:	ststxt	"~PRESS~ENTER~TO~CONTINUE...~"
		dc.b	-1
		even

STS_ContPlace:	ststxt	"~~~PLACE~PLACE~TO~PLACE...~~"
		dc.b	-1
		even

; ---------------------------------------------------------------------------

StoryText_1:	; text after intro cutscene
		ststxt	"ONE DAY, THE SPIKED SUCKER"
		ststxt	"RETURNED TO THE HILLS"
		ststxt	"FOR OLD TIMES' SAKE."
		ststxt_line
		ststxt	"WHEN SUDDENLY..."
		ststxt	"EXPLOSIONS! EVERYWHERE!"
		ststxt	"A GRAY BUZZ BOMBER HAD SONIC"
		ststxt	"RUNNING FOR HIS DEAR LIFE,"
		ststxt	"BUT HE MANAGED TO ESCAPE..."
		ststxt_line
		ststxt	"...ONLY TO THEN LAUNCH"
		ststxt	"HIMSELF STRAIGHT INTO A VERY"
		ststxt	"CONVENIENTLY PLACED TRAP."
		ststxt_line
		ststxt	"SO MUCH FOR A QUICK REVISIT."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_2:	; text after beating Night Hill Place
		ststxt	"SONIC'S NOT HAVING THE"
		ststxt	"TIME OF HIS LIFE."
		ststxt_line
		ststxt	"TELEPORTING WATERFALLS,"
		ststxt	"CRABMEATS WITH EXPLODING"
		ststxt	"PROJECTILES, AND THE"
		ststxt	"ORIGINAL GREEN HILL ZONE"
		ststxt	"TURNED INTO CINEMA HELL!"
		ststxt	"EGGMAN'S BALLS OF STEEL"
		ststxt	"DIDN'T HELP MUCH EITHER."
		ststxt_line
		ststxt	"BUT HEY, I HEARD THEY'VE GOT"
		ststxt	"A BUNCH OF EMERALDS NEARBY?"
		ststxt	"IT WOULD BE A SHAME IF YOU"
		ststxt	"WERE TO MISS YOUR GOAL..."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_3:	; text after beating Special Place
		ststxt	"FOUR EMERALDS ALREADY"
		ststxt	"COLLECTED, AND SONIC DOESN'T"
		ststxt	"EVEN KNOW WHY HE NEEDS THEM."
		ststxt_line
		ststxt	"HONESTLY, NEITHER DO I,"
		ststxt	"BUT HOW ELSE SHOULD I END"
		ststxt	"THIS STAGE? WITH A PARADE?"
		ststxt	"HOW ABOUT A COOKIE TOO?"
		ststxt	"GIVE ME A BREAK HERE."
		ststxt_line
		ststxt	"ANYWAYS, LISTEN UP:"
		ststxt	"DON'T TOUCH ANY UNUSUAL"
		ststxt	"MONITORS IN THE NEXT STAGE!"
		ststxt	"WHO KNOWS WHAT INHUMANITY"
		ststxt	"LIES IN THERE..."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_4:	; text after beating Ruined Place
		ststxt	"WAS THIS LEVEL A METAPHOR"
		ststxt	"FOR CAPITALISM OR SOMETHING?"
		ststxt_line
		ststxt	"AT LEAST YOUR EFFORTS OF"
		ststxt	"SHOOTING YOURSELF THROUGH"
		ststxt	"A MAZE OF SPIKES WERE PRETTY"
		ststxt	"ENTERTAINING TO WATCH."
		ststxt	"REALLY, I THINK YOU SHOULD"
		ststxt	"LOOK INTO BEING A COMEDIAN!"
		ststxt_line
		ststxt	"WAIT A MINUTE, I JUST HAD"
		ststxt	"AN ABSOLUTELY AMAZING IDEA."
		ststxt	"LET'S SEE HOW YOU DO"
		ststxt	"WHEN THE CAMERA"
		ststxt	"GUIDES THE NARRATIVE..."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_5:	; text after beating Labyrinthy Place
		ststxt	"IF ONLY YOU COULD SEE YOUR"
		ststxt	"FACE RIGHT NOW! PRICELESS!"
		ststxt_line
		ststxt	"WELL, OUR CAMERA CREW HAS"
		ststxt	"FILMED ENOUGH MATERIAL FOR"
		ststxt	"TWO FEATURE-LENGTH FILMS"
		ststxt	"AND A SPIN-OFF SERIES."
		ststxt	"SO, NO MORE FUNKY CAMERA"
		ststxt	"BUSINESS FROM NOW ON,"
		ststxt	"PINKY PROMISE!"
		ststxt_line
		ststxt	"HOWEVER, YOU HAVE KILLED"
		ststxt	"THE MIGHTY ^JAWS^ OF DESTINY"
		ststxt	"AND THEREFORE MUST BE SERVED"
		ststxt	"THE ULTIMATE PUNISHMENT!"
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_6:	; text after beating Unreal Place
		ststxt	"IF I SEE SUCH A PATHETIC"
		ststxt	"EXCUSE FOR WHAT YOU CALL"
		ststxt	"^SKILL^ AGAIN, I WILL"
		ststxt	"DISABLE THE CHECKPOINTS"
		ststxt	"UNTIL YOU CAN DO THE ENTIRE"
		ststxt	"STAGE BLINDFOLDED!"
		ststxt_line
		ststxt	"ANYWAYS, YOU'VE GOT ALL THE"
		ststxt	"EMERALDS NOW. SUPER SONIC"
		ststxt	"AIN'T GONNA HAPPEN, THOUGH,"
		ststxt	"AS THIS GAME ONLY HAS SIX."
		ststxt_line
		ststxt	"YOU'LL GO TO SPACE, THOUGH!"
		ststxt	"IT SORTA MAKES UP FOR THAT"
		ststxt	"SEVENTH EMERALD. SORTA."
		dc.b	-1
		even

StoryText_6X:	; ($A) text after beating Unreal Place without touching any checkpoints
		ststxt	"IF I SEE SUCH A PATHETIC"
		ststxt	"EXCUSE FOR WHAT YOU CALL"
		ststxt	"^SKILL^ AGAIN-"
		ststxt_line
		ststxt	"WAIT A MINUTE, WHAT?!"
		ststxt	"YOU BEAT THE ENTIRE STAGE"
		ststxt	"WITHOUT TOUCHING EVEN"
		ststxt	"A SINGLE GOAL BLOCK???"
		ststxt	"UHH... I DON'T KNOW WHAT"
		ststxt	"TO SAY, OTHER THAN WOW."
		ststxt	"THIS MUST HAVE TAKEN A LONG"
		ststxt	"TIME TO GET RIGHT!"
		ststxt_line
		ststxt	"BUT THIS CHANGES NOTHING,"
		ststxt	"YOU'LL STILL GO TO SPACE."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_7:	; text after beating Scar Night Place
		ststxt	"LOOK, I REALLY DO GET IT."
		ststxt	"WHEN I PLAY BUZZ WIRE GAMES,"
		ststxt	"I ALSO SCREAM IN EXCITEMENT!"
		ststxt	"BUT I'M REALLY STARTING"
		ststxt	"TO GET CONCERNED ABOUT"
		ststxt	"YOUR VOCAL CORDS."
		ststxt_line
		ststxt	"AFTER ALL, THE FINALE IS"
		ststxt	"UP AHEAD AND I WAS REALLY"
		ststxt	"HOPING WE WOULD BE BLESSED"
		ststxt	"BY YOUR ANGELIC VOICE"
		ststxt	"ONE LAST TIME!"
		ststxt_line
		ststxt	"AFTER ALL, YOU'VE GOT EVERY"
		ststxt	"TROPHY NOW... RIGHT?"
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_Unter: ; text after beating Unterhub Place
		ststxt	"THE PROPHECIES COULDN'T"
		ststxt	"HAVE PREPARED ME FOR THE"
		ststxt	"ABSOLUTE TERRORS THIS"
		ststxt	"UNHOLY REALM BENEATH OUR"
		ststxt	"COZY HUB WORLD HAD IN"
		ststxt	"STORE FOR HUMANITY."
		ststxt	"IT'S A MIRACLE YOU EVEN"
		ststxt	"MADE IT OUT ALIVE."
		ststxt_line
		ststxt	"EGGMAN WAS THERE, TOO."
		ststxt_line
		ststxt	"YOU'RE SO CLOSE TO THE END,"
		ststxt	"YOU MUSTN'T GIVE UP NOW!"
		ststxt	"I HOPE YOU'VE MASTERED"
		ststxt	"THE TUTORIAL..."
		dc.b	-1
		even

StoryText_UnterP: ; text after beating Unterhub Place without destroying the last Roller
		ststxt	"PACIFIST BONUS FUN FACT"
		ststxt_line
		ststxt	"I'M SICK AND TIRED OF"
		ststxt	"PEOPLE COMPLAINING ABOUT"
		ststxt	"THE LABYRINTH ZONE BOSS,"
		ststxt	"EVEN THOUGH THE REAL"
		ststxt	"HORRORS ALREADY CAME IN"
		ststxt	"SPRING YARD ZONE."
		ststxt	"SO, THIS STAGE WAS MY WAY"
		ststxt	"OF VISUALIZING WHAT FIGHTING"
		ststxt	"THAT BOSS FELT LIKE WHEN"
		ststxt	"I WAS LIKE SEVEN YEARS OLD."
		ststxt_line
		ststxt	"BUT ENOUGH TRAUMA TALK,"
		ststxt	"THE FINALE AWAITS..."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_8:	; text after jumping in the ring for the Ending Sequence
		ststxt	"THE WORLD IS RESCUED!"
		ststxt	"ANIMALS JUMP AROUND AND"
		ststxt	"SPREAD THEIR HAPPINESS BY"
		ststxt	"JUMPING OFF CLIFFS!"
		ststxt_line
		ststxt	"AFTER ESCAPING THE STRANGE"
		ststxt	"PARALLEL DIMENSION, SONIC"
		ststxt	"DECIDED TO TAKE ONE FINAL"
		ststxt	"RUN THROUGH THE HILLS,"
		ststxt	"WHERE IT ALL STARTED."
		ststxt	"WITHOUT YOU, THIS WOULD"
		ststxt	"HAVE NEVER HAPPENED!"
		ststxt_line
		ststxt	"NOW WATCH YOURS AND SONIC'S"
		ststxt	"WELL-DESERVED PARTY..."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_9:	; text after beating the blackout challenge special stage
		ststxt	"HOLY CRAP... YOU DID IT!"
		ststxt	"YOU'VE CONQUERED THE"
		ststxt	"BLACKOUT CHALLENGE."
		ststxt_line
		ststxt	"WHEN I MOCKED YOU BACK IN"
		ststxt	"UNREAL PLACE AND SAID YOU'D"
		ststxt	"HAVE TO DO THE ENTIRE STAGE"
		ststxt	"BLINDFOLDED, I DIDN'T THINK"
		ststxt	"YOU'D ACTUALLY DO IT."
		ststxt_line
		ststxt	"THANK YOU FOR STICKING WITH"
		ststxt	"MY GAME TO THE BITTER END!"
		ststxt	"IT MEANS THE WORLD TO ME."
		ststxt_line
		ststxt	"- SELBI -"
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_Place: ; text when PLACE PLACE PLACE
		ststxt	"PLACE PLACE! PLACE,"
		ststxt	"PLACE, PLACE PLACE PLACE?"
		ststxt	"PLACE PLACE PLACE... PLACE."
		ststxt_line
		ststxt	"PLACE PLACE PLACE"
		ststxt	"PLACE, PLACE! PLACE?"
		ststxt	"PLACE PLACE PLACE, PLACE,"
		ststxt	"PLACE PLACE, PLACE... PLACE."
		ststxt	"PLACE! PLACE! PLACE! PLACE!"
		ststxt	"PLACE, PLACE PLACE!"
		ststxt	"PLACE PLACE."
		ststxt_line
		ststxt	"PLACE... PLACE PLACE."
		ststxt	"PLACE, PLACE PLACE... PLACE?"
		ststxt	"PLACE PLACE PLACE. PLACE."
		dc.b	-1
		even

; ---------------------------------------------------------------------------

StoryText_9X:	; text after beating the blackout challenge in true-BS mode
		ststxt	"HOLY PLACE... YOU PLACED IT!"
		ststxt	"YOU'VE PLACED THE"
		ststxt	"PLACE PLACE PLACE CHALLENGE!"
		ststxt_line
		ststxt	"WHEN I PLACED YOU BACK IN"
		ststxt	"PLACE PLACE AND SAID YOU'D"
		ststxt	"HAVE TO PLACE THE ENTIRE"
		ststxt	"PLACE, I DIDN'T THINK"
		ststxt	"YOU'D ACTUALLY PLACE IT."
		ststxt_line
		ststxt	"THANK YOU FOR PLACING MY"
		ststxt	"PLACE TO THE BITTER PLACE!"
		ststxt	"IT MEANS THE PLACE TO ME."
		ststxt_line
		ststxt	"- PLACE -"
		dc.b	-1
		even

; ---------------------------------------------------------------------------
; ===========================================================================

; ===========================================================================
; ---------------------------------------------------------------------------
; TutorialBox texts

; Max lines per page: 8
; Max characters per line: 20
; ---------------------------------------------------------------------------

Hint_Null:
		boxtxt	"you shouldn#t be"
		boxtxt	"able to read this"
		boxtxt	"lol"
		boxtxt_end

;		 --------------------
Hint_Pre:
		boxtxt	"HELLO AND WELCOME TO"
		boxtxt_line
		boxtxt	"    sonic erazor"
		boxtxt_line
		dc.b	_delay,10
		boxtxt	"THE WILDEST JOURNEY"
		
		boxtxt	"YOU'LL EVER TAKE"
		boxtxt	"WITH YOUR FAVORITE"
		boxtxt	"BLUE HEDGEHOG!"
		boxtxt_next
		
		boxtxt	"YOU WILL REVISIT"
		boxtxt	"THE FIRST SONIC GAME"
		boxtxt	"THROUGH THE LENS OF"
		boxtxt	"AN ACTION MOVIE..."
		boxtxt_line
		boxtxt	"WICKED CHALLENGES,"
		boxtxt	"SPEEDY MOVEMENT,"
		boxtxt	"AND explosions!"
		boxtxt_next

		boxtxt	"THE FOLLOWING STAGE"
		boxtxt	"EXPLAINS SOME OF"
		boxtxt	"THIS HACK'S UNIQUE"
		boxtxt	"GAME MECHANICS."
		boxtxt_line
		boxtxt	"PRESS a TO ACTIVATE"
		boxtxt	"AN INFO MONITOR."
		boxtxt	"read them all!"
		boxtxt_next

		boxtxt_line
		boxtxt_line
		boxtxt	"   ALRIGHT THEN,"
		dc.b	_delay,10
		boxtxt_line
		boxtxt_line
		boxtxt	"     let#s go1"
		boxtxt_end

;		 --------------------
Hint_1:
		boxtxt	"HI, AND WELCOME TO"
		boxtxt	"THE tutorial!"
		boxtxt_pause
		boxtxt	"WE'LL TAKE IT EASY,"
		boxtxt	"SINCE THERE IS"
		boxtxt	"ABSOLUTELY"
		boxtxt	"NO RUSH AT ALL."
		boxtxt_next

		boxtxt	"CONTROLS - standing"
		boxtxt_pause
		boxtxt	" ~ + a/b/c"
		boxtxt	" SPIN DASH"
		boxtxt_line
		boxtxt	" ^ + a"
		boxtxt	" A SUPER PEEL-OUT"
		boxtxt	" THAT DOESN'T SUCK"
		boxtxt_next

		boxtxt	"AND TO JUMP, YOU"
		boxtxt	"HAVE TO PRESS-"
		boxtxt_pause
		boxtxt	"...UHH..."
		boxtxt_pause
		boxtxt	"...I FORGOT."
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"    UNRELATED TO"
		boxtxt	"  CONTROLS, BUT AS"
		boxtxt	" YOU ARE PLAYING IN"
		boxtxt	"  FRANTIC, ALL THE"
		boxtxt	" MONITORS WILL TELL"
		boxtxt	"    BONUS HINTS!"
		boxtxt_next
		
		boxtxt	"   FOR EXAMPLE..."
		boxtxt_pause
		boxtxt	" AFTER YOU FINISH A"
		boxtxt	"   FRANTIC STAGE,"
		boxtxt	" YOUR RINGS WILL BE"
		boxtxt	"   RESET TO zero!"
		boxtxt_end

;		 --------------------
Hint_2:
		boxtxt	"CONTROLS - airborne"
		boxtxt_pause
		boxtxt	" c - JUMP DASH"
		boxtxt_line
		boxtxt	" b - DOUBLE JUMP"
		boxtxt_pause
		boxtxt	"THESE WILL BE YOUR"
		boxtxt	"BREAD AND BUTTER!"
		boxtxt_next

		boxtxt	"HITTING AN OBJECT"
		boxtxt	"WILL ALSO reset THE"
		boxtxt	"COOLDOWN, SO YOU CAN"
		boxtxt	"CHAIN MULTIPLE JUMPS"
		boxtxt	"BEFORE YOU HIT THE"
		boxtxt	"FLOOR AGAIN!"
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"     TIME TICKS"
		boxtxt	"   TWICE AS FAST!"
		boxtxt_pause
		boxtxt	"   THAT'S ROUGHLY"
		boxtxt	"   eight  minutes"
		boxtxt	"  UNTIL TIME OVER."
		boxtxt_end

;		 --------------------
Hint_3:
		boxtxt	"inhuman mode"
		boxtxt_pause
		boxtxt	"PRESS a TO FIRE AN"
		boxtxt	"EXPLODING BULLET"
		boxtxt	"YOU CAN PROPEL"
		boxtxt	"YOURSELF IN THE AIR"
		boxtxt	"WITH!"
		boxtxt_next

		boxtxt	"ALSO, YOU ARE FULLY"
		boxtxt	"INVINCIBLE TO"
		boxtxt	"EVERYTHING!"
		boxtxt_pause
		boxtxt	"...EXCEPT SPIKES."
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	" THE FLOOR IS LAVA!"
		dc.b	_pause
		boxtxt	"  WELL, SOMETIMES."
		boxtxt_pause
		boxtxt	" IN CERTAIN LEVELS,"
		boxtxt	" DON'T STAND ON THE"
		boxtxt	"  GROUND TOO MUCH!"
		boxtxt_end

;		 --------------------
Hint_UberhubEasterEgg:
		boxtxt	"0Adw193q4HG5!'%q)/%4"
		boxtxt	"8ETRqZ91/D')we03()a)"
		boxtxt	"8%4mh/vq%cio!7e$cr/("
		boxtxt	"()B)f=)A=2h3401)?!G("
		boxtxt	"#x))2)aEd0a..oh mY g"
		boxtxt	"Od wHat HavE yOu Don"
		boxtxt	"e eVERythIng iS rUin"
		boxtxt	"ED Now::.2938)295)34"
		boxtxt_next

		boxtxt	"BUT HEY, YOU'VE MADE"
		boxtxt	"IT THIS FAR, SO YOU"
		boxtxt	"CLEARLY CAN'T GET"
		boxtxt	"ENOUGH OF ERAZOR!"
		boxtxt_pause
		boxtxt	"WELL, LUCKY FOR YOU,"
		boxtxt	"YOU'VE COME TO"
		boxtxt	"THE RIGHT PLACE!"
		boxtxt_next

		boxtxt	"FIRST OF ALL, HERE'S"
		boxtxt	"A LINK FOR THE FULL"
		boxtxt	"SOURCE CODE!"
		boxtxt_line
		boxtxt	"erazor:selbi:club"
		boxtxt_line
		boxtxt	"THIS IS A REDIRECT"
		boxtxt	"TO THE GITHUB REPO."
		boxtxt_next

		boxtxt	"ALSO, DID YOU KNOW"
		boxtxt	"THERE'S A SPECIAL" 
		boxtxt	"widescreen_optimized"
		boxtxt	"MODIFICATION MADE" 
		boxtxt	"FOR SONIC ERAZOR?" 
		boxtxt_line
		boxtxt	"GO TO THE SAME URL"
		boxtxt	"FOR THE DOWNLOAD!"
		boxtxt_next
	if def(__WIDESCREEN__)
		boxtxt	"...ALTHOUGH IT LOOKS"
		boxtxt	"LIKE I DON'T NEED TO" 
		boxtxt	"TELL YOU THAT."
		boxtxt_next
	endif

		boxtxt	"AND NOW... HELLO AND"
		boxtxt	"WELCOME TO THE"
		boxtxt	"easter egg infodump!"
		boxtxt_line
		boxtxt	"A BUNCH OF HIDDEN"
		boxtxt	"BUTTON COMBINATIONS,"
		boxtxt	"RANGING FROM HANDY"
		boxtxt	"TO VERY RANDOM."
		boxtxt_next

		boxtxt	"level select"
		boxtxt_line
		boxtxt	"AT THE TITLE SCREEN,"
		boxtxt	"CIRCLE THE d_pad"
		boxtxt	"A FEW TIMES, THEN"
		boxtxt	"HOLD a + start!"
		boxtxt	"PRESS a TO TOGGLE"
		boxtxt	"CASUAL/FRANTIC."
		boxtxt_next

		boxtxt	"debug mode"
		boxtxt_line
		boxtxt	"WHEN YOU'RE IN THE"
		boxtxt	"FINAL PHASE OF THE"
		boxtxt	"SELBI SCREEN, MASH"
		boxtxt	"THE abc BUTTONS"
		boxtxt	"TWENTY TIMES!"
		boxtxt_next

		boxtxt	"unlock everything"
		boxtxt	"in save slot three"
		boxtxt_line
		boxtxt	"ENTER THE DEBUG MODE"
		boxtxt	"CHEAT A SECOND TIME,"
		boxtxt	"VIA pause + a WHILE"
		boxtxt	"IN 0BERHUB PLACE."
		boxtxt	"CANNOT BE UNDONE!"
		boxtxt_next

		boxtxt	"quick new game"
		boxtxt_line
		boxtxt	"WHILE STARTING A NEW"
		boxtxt	"GAME, HOLD a + start"
		boxtxt	"IN THE OPTIONS MENU"
		boxtxt	"TO SKIP THE INTRO"
		boxtxt	"AND START RIGHT IN"
		boxtxt	"night hill place!"
		boxtxt_next

		boxtxt	"skip mini-cutscenes"
		boxtxt_line
		boxtxt	"YOU CAN SKIP MANY OF"
		boxtxt	"THE SHORT CUTSCENES"
		boxtxt	"BY HOLDING a + b + c"
		boxtxt	"AT ONCE! THIS ALSO"
		boxtxt	"INCLUDES GIANT RING"
		boxtxt	"ANIMATIONS."
		boxtxt_next

		boxtxt	"skip special stages"
		boxtxt_line
		boxtxt	"IN CASUAL MODE, YOU"
		boxtxt	"CAN INSTANTLY SKIP"
		boxtxt	"A SPECIAL STAGE"
		boxtxt	"BY HOLDING a + b + c"
		boxtxt	"AT ONCE! IN FRANTIC,"
		boxtxt	"ONCE BEATEN."
		boxtxt_next

		boxtxt	"drunk special stages"
		boxtxt_line
		boxtxt	"ENABLE motion blur"
		boxtxt	"AND HOLD a + up/down"
		boxtxt	"TO ROTATE A SPECIAL"
		boxtxt	"STAGE AROUND WITHOUT"
		boxtxt	"AFFECTING GRAVITY."
		boxtxt	"RIVETING VERTIGO!"
		boxtxt_next

		boxtxt	"dude, just shut up"
		boxtxt_line
		boxtxt	"YOU'RE GETTING"
		boxtxt	"TIRED OF ME? FINE."
		boxtxt	"YOU CAN SKIP THESE"
		boxtxt	"SMALL ON-SCREEN"
		boxtxt	"TEXTBOXES IF YOU"
		boxtxt	"HOLD a + b + c!"
		boxtxt_next


		boxtxt	"AND THAT WRAPS UP"
		boxtxt	"THE INFODUMP."
		boxtxt_line
		boxtxt	"ENJOY THESE RANDOM"
		boxtxt	"BONUS FEATURES!"
		boxtxt_pause
		boxtxt	"THERE IS JUST"
		boxtxt	"ONE LAST THING..."
		boxtxt_next

		boxtxt	" THE LEVEL IS STILL"
		boxtxt	"  A COMPLETE MESS."
		boxtxt_pause
		boxtxt	"     YES, I WAS"
		boxtxt	"      TOO LAZY"
		boxtxt	"     TO FIX IT."
		boxtxt_pause
		boxtxt	"      bite me:"
		boxtxt_end

;		 --------------------
Hint_FZEscape:
		boxtxt	"HI, AND WELCOME TO"
		boxtxt	"THE tutorial!"
		boxtxt_pause
		boxtxt	"WE'LL TAKE IT EASY,"
		boxtxt	"SINCE THERE IS"
		boxtxt	"ABSOLUTELY-"
		boxtxt_next

		boxtxt	"..."
		boxtxt_pause
		boxtxt	"UHH..."
		boxtxt_pause
		boxtxt	"YOU BETTER GET OUT"
		boxtxt	"OF HERE BEFORE THIS"
		boxtxt	"WHOLE PLACE BLOWS"
		boxtxt	"THE HELL UP."
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"   ...THIS GOES"
		boxtxt	"       double"
		boxtxt	"      FOR YOU."
		boxtxt_pause
		boxtxt	" REMEMBER, YOU HAVE"
		boxtxt	"    A JUMP DASH!"
		boxtxt_end	
;		 --------------------
Hint_6:
		boxtxt	"hard part skipper"
		boxtxt_pause
		boxtxt	"THIS IS A HARD PART"
		boxtxt	"SKIPPER."
		boxtxt_pause
		boxtxt	"IT SKIPS PARTS THAT"
		boxtxt	"ARE HARD."
		boxtxt_next

		boxtxt	"IF A CHALLENGE IS"
		boxtxt	"ASKING TOO MUCH FROM"
		boxtxt	"YOU, SIMPLY PRESS"
		boxtxt_line
		boxtxt	"~ + a"
		boxtxt_line
		boxtxt	"IN FRONT OF THIS"
		boxtxt	"DEVICE TO SKIP IT!"
		boxtxt_next

		boxtxt	" but remember this1"
		boxtxt_pause
		boxtxt	"     IN CASUAL,"
		boxtxt	" HARD PART SKIPPERS"
		boxtxt	"    ARE FRIENDS."
		boxtxt_pause
		boxtxt	"  IN FRANTIC, THEY"
		boxtxt	"   WANT YOU DEAD."
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"    PSSSST, HEY,"
		boxtxt	"     PRO-TIP..."
		boxtxt_line
		boxtxt	"DID YOU KNOW YOU CAN"
		boxtxt	" jumpdash downwards"
		boxtxt	"  AS WELL?! CRAZY!"
		boxtxt_end

;		 --------------------
Hint_7:
		boxtxt	"dying sucks"
		boxtxt_pause
		boxtxt	"SOME TRIAL AND ERROR"
		boxtxt	"MIGHT BE NECESSARY."
		boxtxt_line
		boxtxt	"HOWEVER, THERE ARE"
		boxtxt	"no lives ANYWHERE"
		boxtxt	"IN THIS GAME!"
		boxtxt_next

		boxtxt	"YOU WILL ALSO ONLY"
		boxtxt	"LOSE twenty rings"
		boxtxt	"ON HIT INSTEAD OF"
		boxtxt	"THE WHOLE BUNCH!"
		boxtxt_next

		boxtxt	"FURTHERMORE, TO NOT"
		boxtxt	"WASTE YOUR TIME,"
		boxtxt	"MOST CHALLENGES"	
		boxtxt	"WILL INSTANTLY"
		boxtxt	"TELEPORT YOU BACK,"
		boxtxt	"RATHER THAN OUTRIGHT"
		boxtxt	"KILLING YOU!"
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"   WE ADDED TAXES"
		boxtxt	"  FOR TELEPORTING!"
		boxtxt_pause
		boxtxt	" GETTING TELEPORTED"
		boxtxt	" WILL MAKE YOU LOSE"
		boxtxt	"    A FEW RINGS."
		boxtxt_next

		boxtxt_line
		boxtxt_line
		boxtxt	"     CAN'T PAY?"
		boxtxt_pause
		boxtxt_line
		boxtxt	"      YOU DIE."
		boxtxt_end

;		 --------------------
Hint_8:
		boxtxt	"hedgehog space golf"
		boxtxt_pause
		boxtxt	"HOLD A DIRECTION"
		boxtxt	"WITH THE d_pad AND"
		boxtxt	"MASH THE c BUTTON"
		boxtxt	"TO PRECISELY DASH"
		boxtxt	"IN MID-AIR LIKE"
		boxtxt	"A GOLF BALL!"
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"  THIS IS AWKWARD."
		boxtxt	" I RAN OUT OF BONUS"
		boxtxt	"    TIPS. UHM..."
		boxtxt_pause
		boxtxt	"DID YOU KNOW THAT..."
		dc.b	_pause
		boxtxt	"   SONIC IS BLUE?"
		boxtxt_end

;		 --------------------
Hint_9:
		boxtxt	"classic anti-grav"
		boxtxt_pause
		boxtxt	"HEDGEHOG SPACE GOLF"
		boxtxt	"ALSO COMES WITH THE"
		boxtxt	"BONUS ABILITY TO"
		boxtxt	"INVERT GRAVITY"
		boxtxt	"BY HOLDING a!"
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"  YUP, STILL BLUE."
		boxtxt_end

Hint_9SequenceBreak:
		boxtxt	"AH. YEAH. COOL."
		boxtxt_pause
		boxtxt	"WALTZ RIGHT PAST THE"
		boxtxt	"HEDGEHOG SPACE GOLF"
		boxtxt	"BUTTON AND RUIN"
		boxtxt	"THE WHOLE TUTORIAL."
		boxtxt_pause
		boxtxt	"POOPYHEAD."
		boxtxt_end

;		 --------------------
Hint_Easter_Tutorial:
		boxtxt	"YOU THINK YOU'RE"
		boxtxt	"PRETTY CLEVER, HUH?"
		boxtxt_pause
		boxtxt	"GET IN THE RING,"
		boxtxt	"LOSER!"
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"   YES, EVEN YOU."
		boxtxt_end

;		 --------------------
Hint_Easter_SLZ:
		boxtxt	"  AREN'T THE TRUE"
		boxtxt_line
		boxtxt	"    EASTER EGGS"
		boxtxt_line
		boxtxt	"    THE FRIENDS"
		boxtxt	"      WE MADE"
		boxtxt	"   ALONG THE WAY?"
		boxtxt_next

		boxtxt	"..."
		boxtxt_pause
		boxtxt_line
		boxtxt	"..."
		boxtxt_pause
		boxtxt_line
		boxtxt	"..."
		boxtxt_next

		boxtxt	"WHAT?"
		boxtxt_pause
		boxtxt_line
		boxtxt	"WERE YOU EXPECTING"
		boxtxt_line
		boxtxt	"ANYTHING NAUGHTY"
		boxtxt_line
		boxtxt	"UP HERE?"
		boxtxt_next

		boxtxt	"YOU ARE"
		boxtxt_line
		boxtxt_pause
		boxtxt	"CATEGORICALLY"
		boxtxt_line
		boxtxt_pause
		boxtxt	"DISGUSTING."
		boxtxt_end

;		 --------------------
Hint_TutorialConclusion:
		boxtxt	"AND THAT CONCLUDES"
		boxtxt	"THE TUTORIAL!"
		boxtxt_line
		boxtxt	"YOU SHOULD BE ABLE"
		boxtxt	"TO FIGURE OUT THE"
		boxtxt	"REST ON YOUR OWN."
		boxtxt_next

		boxtxt	"ONE FINAL TIP..."
		boxtxt_line
		boxtxt	"YOU CAN RETURN TO"
		boxtxt	"0BERHUB PLACE"
		boxtxt	"AT ANY TIME BY"
		boxtxt	"PRESSING a WHILE"
		boxtxt	"THE GAME IS paused!"
		boxtxt_next

		boxtxt	"NOW GO OUT THERE AND"
		boxtxt	"HAVE FUN WITH"
		boxtxt_line
		boxtxt	"    SONIC erAzOR"
		boxtxt_line
		boxtxt	"I HOPE YOU'LL HAVE"
		boxtxt	"AS MUCH FUN AS I HAD"
		boxtxt	"CREATING IT!"
		boxtxt_next

		boxtxt	"  CREATED BY selbi"
		boxtxt_pause
		boxtxt	"  THEY CALL ME THE"
		boxtxt	"    michael  bay"
		boxtxt	"   OF SONIC GAMES."
		boxtxt_pause
		boxtxt	"    AND IN A BIT"
		boxtxt	"  YOU'LL KNOW WHY."
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"REMEMBER, YOU AREN'T"
		boxtxt	"  LOCKED INTO THIS"
		boxtxt	"MODE. YOU CAN SWITCH"
		boxtxt	"   BACK TO casual"
		boxtxt	"   AT ANY TIME IN"
		boxtxt	"    THE options!"
		boxtxt_end

;		 --------------------
Hint_Easter_Tutorial_Escape:
		boxtxt	"IF IT SAVES YOU THE"
		boxtxt	"TROUBLE OF COMING"
		boxtxt	"UP HERE AGAIN"
		boxtxt_pause
		boxtxt	"YOU ARE STILL"
		boxtxt	"A LOSER."
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"        ...."
		boxtxt_pause
		boxtxt	"    THIS DOESN'T"
		boxtxt	"  CHANGE ANYTHING!"
		boxtxt_end

;		 --------------------
Hint_End_AfterCasual:
		boxtxt	"CONGRATULATIONS FOR"
		boxtxt	"BEATING THE GAME IN"
		boxtxt	"casual mode!"
		boxtxt_pause
		boxtxt	"MAYBE YOU'D LIKE TO"
		boxtxt	"TRY frantic NEXT?"
		boxtxt_pause
		boxtxt	"SPEAKING OF..."
		boxtxt_NEXT

		boxtxt	"IF YOU SAW ANYTHING"
		boxtxt	"WEIRD NEAR THE END"
		boxtxt	"OF 9berhub place..."
		boxtxt_pause
		boxtxt	"IGNORE IT."
		boxtxt_next

		boxtxt	"THE HORRORS BEHIND"
		boxtxt	"THAT DOOR HAVE BEEN"
		boxtxt	"SEALED AWAY FOR"
		boxtxt	"casual PLAYERS."
		boxtxt_pause
		boxtxt	"YOU MUST PROVE"
		boxtxt	"YOURSELF worthy IF"
		boxtxt	"YOU WISH TO ENTER."
		boxtxt_end

;		 --------------------
Hint_End_AfterFrantic:
		boxtxt	"CONGRATULATIONS FOR"
		boxtxt	"BEATING THE GAME IN"
		boxtxt	"frantic mode!"
		boxtxt_next

		boxtxt	"IF YOU MADE IT HERE,"
		boxtxt	"YOU'VE GOT MY"
		boxtxt	"UTMOST RESPECT."
		boxtxt_line
		boxtxt	"I'M SORRY FOR ANY"
		boxtxt	"BRAIN CELLS YOU"
		boxtxt	"MIGHT HAVE LOST"
		boxtxt	"ALONG THE WAY."
		boxtxt_end

;		 --------------------
Hint_End_BlackoutTeaser:
		boxtxt	"THE HORRORS OF"
		boxtxt	"9berhub#s end"
		boxtxt	"HAVE BEEN UNSEALED."
		boxtxt_pause
		boxtxt	"THERE IS NO ONE TO"
		boxtxt	"HELP YOU ANYMORE."
		boxtxt_pause
		boxtxt	"GOOD LUCK."
		boxtxt_end

;		 --------------------
Hint_Options_Autoskip:
		boxtxt	"arcade mode"
		boxtxt_line
		boxtxt	"WHEN ENABLED, YOU'LL"
		boxtxt	"GO STRAIGHT TO THE"
		boxtxt	"NEXT LEVEL AFTER"
		boxtxt	"BEATING ONE, INSTEAD"
		boxtxt	"OF RETURNING TO"
		boxtxt	"0BERHUB PLACE!"
		boxtxt_next

		boxtxt	"YOU CAN ALSO CHOOSE"
		boxtxt	"TO SKIP ALL STORY"
		boxtxt	"AND CHAPTER SCREENS."
		boxtxt_line
		boxtxt	"GREAT FOR REPLAYS,"
		boxtxt	"AND VERY HIGHLY"
		boxtxt	"RECOMMENDED FOR"
		boxtxt	"speedruns!"
		boxtxt_end

Hint_Options_AlternateHUD:
		boxtxt	"alternate hud"
		boxtxt_line
		boxtxt	"REPLACE SPECIFIC"
		boxtxt	"HUD ELEMENTS WITH"
		boxtxt	"ALTERNATE VERSIONS"
		boxtxt	"THAT MIGHT BE MORE"
		boxtxt	"INTERESTING FOR"
		boxtxt	"YOUR PLAYSTYLE!"
		boxtxt_next

		boxtxt	"total seconds"
		boxtxt_line
		boxtxt	"REPLACES THE SCORE"
		boxtxt	"IN THE TOP LEFT WITH"
		boxtxt	"THE total seconds"
		boxtxt	"ACQUIRED THROUGHOUT"
		boxtxt	"YOUR JOURNEY!"
		boxtxt_next

		boxtxt	"total mistakes"
		boxtxt_line
		boxtxt	"GETTING TELEPORTED"
		boxtxt	"OR HURT WILL GET"
		boxtxt	"TRACKED IN THE DEATH"
		boxtxt	"COUNTER AS WELL."
		boxtxt	"DON'T WORRY, YOU"
		boxtxt	"WON'T ACTUALLY DIE!"
		boxtxt_next

		boxtxt	"BOTH OPTIONS ARE AS"
		boxtxt	"USEFUL AS YOU CAN"
		boxtxt	"PROBABLY IMAGINE,"
		boxtxt	"PRIMARILY MADE FOR"
		boxtxt	"SPEEDRUNNING."
		boxtxt_line
		boxtxt	"BUT THERE'S ONE"
		boxtxt	"MORE CHOICE..."
		boxtxt_next

		boxtxt	"disable all hud"
		boxtxt_line
		boxtxt	"YOU CAN ALSO DISABLE"
		boxtxt	"THE TITLE CARDS AND"
		boxtxt	"HUD ENTIRELY FOR A"
		boxtxt	"CINEMATIC VIBE!"
		boxtxt	"BUT THIS WILL MAKE"
		boxtxt	"THE GAME HARDER."
		boxtxt_end


	if def(__WIDESCREEN__)
Hint_Options_WidescreenExtCam:
		boxtxt	"widescreen-optimized"
		boxtxt	"extended camera"
		boxtxt_line
		boxtxt	"DUE TO THE INCREASED"
		boxtxt	"SCREEN SIZE, THIS"
		boxtxt	"CAMERA MOVES A LOT"
		boxtxt	"FASTER AND MAY CAUSE"
		boxtxt	"MOTION SICKNESS!"
		boxtxt_end
	endif

Hint_Options_PaletteStyle:
		boxtxt	"palette style"
		boxtxt_line
		boxtxt	"CHOOSE BETWEEN THE"
		boxtxt	"old-school PALETTES"
		boxtxt	"USED IN ERAZOR FOR"
		boxtxt	"FIFTEEN YEARS OR THE"
		boxtxt	"BEAUTIFUL remasters"
		boxtxt	"MADE BY JAVESIKE!"
		boxtxt_end

;		 --------------------
Hint_Options_FranticTutorial:
		boxtxt	"RESPECT FOR GOING"
		boxtxt	"WITH frantic mode!"
		boxtxt_line
		boxtxt	"SOME STUFF DIFFERS"
		boxtxt	"IN HERE, SO YOU MAY"
		boxtxt	"WANT TO REVISIT"
		boxtxt	"THE TUTORIAL."
		boxtxt_end

;		 --------------------
Hint_LP_BlackBars:
		boxtxt	"HI. SO, UH..."
		boxtxt_line
		boxtxt	"THE BLACK BARS"
		boxtxt	"DO not WORK IN"
		boxtxt	"LABYRINTHY PLACE"
		boxtxt	"FOR WATER REASONS."
		boxtxt_line
		boxtxt	"SORRY 'BOUT THAT."
		boxtxt_end

;		 --------------------
Hint_Place:
		boxtxt	"PLACE PLACE PLACE."
		boxtxt_pause
		boxtxt	"PLACE? PLACE!"
		boxtxt	"PLACE, PLACE PLACE"
		boxtxt	"PLACE PLACE PLACE?"
		boxtxt	"PLACE... PLACE!"
		boxtxt_pause
		boxtxt	"PLACE? PLACE."
		boxtxt_end

;		 --------------------
Hint_End_CinematicUnlock:
		boxtxt	"e FOR EPIC"
		boxtxt_line
		boxtxt	"YOU HAVE UNLOCKED"
		boxtxt	"cinematic mode!"
		boxtxt_pause
		boxtxt	"THE ULTIMATE FUN"
		boxtxt	"WITH A THIRD OF THE"
		boxtxt	"SCREEN IN BLACK!"
		boxtxt_next

		boxtxt	"IT ALSO COMES WITH"
		boxtxt	"visual fx OPTIONS,"
		boxtxt	"LIKE MOTION BLUR!"
		boxtxt_pause
		boxtxt	"OR, AS THE MOVIE"
		boxtxt	"INDUSTRY WOULD SAY,"
		boxtxt	"DEFINITELY HD!"
		boxtxt_end

Hint_Options_CinematicMode:
		boxtxt	"cinematic effects"
		boxtxt_line
		boxtxt	"MIX AND MATCH THE"
		boxtxt	"VARIOUS EFFECTS AND"
		boxtxt	"FILTERS YOU SAW"
		boxtxt	"DURING YOUR JOURNEY!"
		boxtxt	"NOW YOU CAN ALSO BE"
		boxtxt	"MICHAEL BAY!"
	boxtxt_end

		boxtxt_next

		boxtxt	"black bars BONUS TIP"
		boxtxt_line
		boxtxt	"GO TO THE BLACK BARS"
		boxtxt	"SETUP SCREEN AND"
		boxtxt	"HOLD b + up/down TO"
		boxtxt	"ADJUST THE HEIGHT!"
		boxtxt	"TO RESET, HOLD b AND"
		boxtxt	"THEN PRESS start."
		boxtxt_end

;		 --------------------
Hint_End_ErazorPowersUnlock:
		boxtxt	"r FOR RADICAL"
		boxtxt_line
		boxtxt	"YOU HAVE UNLOCKED"
		boxtxt	"erAzOR powers!"
		boxtxt_pause
		boxtxt	"ALL HAIL OUR NEW"
		boxtxt	"OVERLORD! MAY THE"
		boxtxt	"GODS HAVE MERCY."
		boxtxt_next

		boxtxt	"hard part skippers"
		boxtxt	"CAN NOW ALSO BE USED"
		boxtxt	"IN frantic mode!"
		boxtxt_end

Hint_Options_ErazorPowers:
		boxtxt	"true inhuman mode"
		boxtxt_line
		boxtxt	"INHUMAN MODE WITHOUT"
		boxtxt	"THE ANNOYING BURDEN"
		boxtxt	"OF BEING ALLERGIC TO"
		boxtxt	"SPIKES AND FEELING"
		boxtxt	"YOUR RINGS VANISHING"
		boxtxt	"FROM YOUR POCKET!"
		boxtxt_next

		boxtxt	"IT'S BASICALLY JUST"
		boxtxt	"AN actual GODMODE."
		boxtxt_line
		boxtxt	"NOTHING, NOT EVEN"
		boxtxt	"BOTTOMLESS PITS OR"
		boxtxt	"GETTING CRUSHED,"
		boxtxt	"CAN KILL YOU!"
		boxtxt_next

		boxtxt	"space golf mode"
		boxtxt_line
		boxtxt	"THE UNIQUE FLYING"
		boxtxt	"ABILITY SEEN IN"
		boxtxt	"EVERYONE'S FAVORITE"
		boxtxt	"ERAZOR LEVEL,"
		boxtxt_line
		boxtxt	"STAR AGONY PLACE!"
		boxtxt_next

		boxtxt	"UNFORTUNATELY, NO"
		boxtxt	"BLUE PALETTE CYCLE"
		boxtxt	"DUE TO LIMITATIONS."
		boxtxt_line
		boxtxt	"DEFINITELY MUCH LESS"
		boxtxt	"USEFUL THAN INHUMAN,"
		boxtxt	"BUT IT MIGHT BE FUN"
		boxtxt	"IN A CHALLENGE RUN!"
		boxtxt_next

		boxtxt	"both"
		boxtxt_pause
		boxtxt	"...WHAT?"
		boxtxt_end

;		 --------------------
Hint_End_TrueBSUnlock:
		boxtxt	"z FOR ZENITH"
		boxtxt_line
		boxtxt	"YOU HAVE UNLOCKED"
		boxtxt	"true_bs mode!"
		boxtxt_pause
		boxtxt	"DYING WON'T BE A"
		boxtxt	"CHOICE ANYMORE, IT'S"
		boxtxt	"THE NEW NORMAL!"
		boxtxt_end

Hint_Options_TrueBS:
		boxtxt	"true_bs mode"
		boxtxt_line
		boxtxt	"- NO RINGS"
		boxtxt	"- NO CHECKPOINTS"
		boxtxt	"- NO GOOD MONITORS,"
		boxtxt	"  EXCEPT SHIELDS"
		boxtxt	"- NO IMMUNITY WHEN"
		boxtxt	"  RUNNING FAST"
		boxtxt_next

		boxtxt	"NO SPECIAL REWARD"
		boxtxt	"AWAITS YOU AT THE"
		boxtxt	"END EITHER. AND NO,"
		boxtxt	"THIS ISN'T REVERSE"
		boxtxt	"PSYCHOLOGY, THIS"
		boxtxt	"MODE REALLY IS JUST"
		boxtxt	"FOR BRAGGING RIGHTS"
		boxtxt	"AND NOTHING ELSE!"
		boxtxt_next

		boxtxt	"THAT SAID, IT HAS"
		boxtxt	"BEEN PLAYTESTED AND"
		boxtxt	"IS FULLY BEATABLE!"
		boxtxt_pause
		boxtxt	"...IF YOU GOT THE"
		boxtxt	"ENDURANCE."
		boxtxt_pause
		boxtxt	"AND BRAIN CELLS."
		boxtxt_end

;		 --------------------
Hint_Options_DMCAMode:
		boxtxt	"dmca-friendly mode"
		boxtxt_line
		boxtxt	"ENABLING THIS MODE"
		boxtxt	"REPLACES A FEW SONGS"
		boxtxt	"THAT TEND TO GET"
		boxtxt	"COPYRIGHT-CLAIMED"
		boxtxt	"ON YOUTUBE WITH"
		boxtxt	"SAFE VERSIONS!"
		boxtxt_end

; ---------------------------------------------------------------------------
; ===========================================================================

; ===========================================================================
; ---------------------------------------------------------------------------
; BlackBarsConfigScreen texts
;
; Max lines per page: 24
; Max characters per line: 40
; ---------------------------------------------------------------------------

BlackBarsConfigScreen_WriteText_WidescreenInfo:
	BBCS_EnterConsole a0

	Console.SetXY #0, #2
	Console.Write "              SONIC ERAZOR"
	Console.Write "%<endl>%<endl>"
	Console.Write "      Z E N I T H    E D I T I O N"

	Console.SetXY #0, #6
	Console.Write "%<pal2>----------------------------------------%<pal0>"
	Console.Write "%<endl>%<endl>"
	Console.Write "%<endl>"
	Console.Write "     SONIC ERAZOR IS A ROM HACK OF%<endl>"
	Console.Write "    SONIC 1 FOR THE SEGA MEGA DRIVE.%<endl>"
	Console.Write "%<endl>"
	Console.Write "  THIS IS SPECIAL WIDESCREEN-OPTIMIZED%<endl>"
	Console.Write "    VERSION OF THIS HACK, POWERED BY%<endl>"
	Console.Write "  HEYJOEWAY'S  ""SONIC 2 COMMUNITY CUT""  %<endl>"
	Console.Write " EMULATOR, FORKED FROM GENESIS PLUS GX.%<endl>"
	Console.Write "%<endl>"
	Console.Write "THIS ISN'T JUST A CUSTOM SONIC FAN GAME,%<endl>"
	Console.Write "   IT'S A TURBO-CHARGED RETRO CONSOLE!%<endl>"
	Console.Write "%<endl>"
	Console.Write "%<endl>"
	Console.Write "%<pal2>----------------------------------------%<pal0>"

	Console.SetXY #0, #24

	Console.Write "       PRESS ENTER TO CONTINUE...%<endl>"
	
	BBCS_LeaveConsole a0
	rts


BlackBarsConfigScreen_WriteText_Controls:
	BBCS_EnterConsole a0

	Console.SetXY #0, #2
	Console.Write "              SONIC ERAZOR"
	Console.Write "%<endl>%<endl>"
	Console.Write "    D E F A U L T    C O N T R O L S"

	Console.SetXY #0, #6
	Console.Write "%<pal2>----------------------------------------%<pal0>"
	Console.Write "%<endl>%<endl>"
	Console.Write "      KEYBOARD KEY -> IN-GAME BUTTON%<endl>"
	Console.Write "%<endl>"
	Console.Write "                 A -> A%<endl>"
	Console.Write "                 S -> B%<endl>"
	Console.Write "                 D -> C%<endl>"
	Console.Write "             ENTER -> START%<endl>"
	Console.Write "        ARROW KEYS -> D-PAD%<endl>"
	Console.Write "%<endl>"
	Console.Write "               F11 -> TOGGLE FULLSCREEN%<endl>"
	Console.Write "               TAB -> RESTART GAME%<endl>"
	Console.Write "               ESC -> QUIT GAME%<endl>"
	Console.Write "%<endl>"
	Console.Write "%<pal2>----------------------------------------%<pal0>"

	Console.SetXY #0, #22

	Console.Write "      PRESS ""START"" TO CONTINUE...%<endl>"
	Console.Write "%<endl>"
	Console.Write "       PRESS ""B"" TO NOT SHOW THIS%<endl>"
	Console.Write "          INFORMATION AGAIN...%<endl>"
	
	BBCS_LeaveConsole a0
	rts

; ---------------------------------------------------------------------------
; ===========================================================================

; ===========================================================================
; ---------------------------------------------------------------------------
; TODO the others
; ---------------------------------------------------------------------------

; TODO ChapterScreeen (though probably not gonna happen because it's all art)
; TODO CreditsScreen (not really necessary though)
; TODO GameplayStyleScreen (important but it's plane mappings so fffff)
; TODO OptionsScreen (this one's gonna suck ass to do with how spread-out it is)
; TODO SaveSelectScreen (perhaps not necessary though)
; TODO SoundTestScreen (nice to have, but not important)
; TODO level select text (probably not necessary)

; ---------------------------------------------------------------------------
; ===========================================================================
