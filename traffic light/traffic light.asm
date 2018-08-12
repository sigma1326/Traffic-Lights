ORG   00h
	;defining time slots
	red equ 99
	green equ 90
	yellow equ 9
	
	;r3 : light change counter
	
	;r4 : traffic light1 counter
	;r5 : traffic light2 counter
	;r6 : traffic light3 counter
	
	
	MAIN_LOOP:
	;;;;;;;;;;;;;;;;;;;;; state 1
	mov r4,#green
	mov r5,#red
	mov r6,#red
	;G:1 - Y: - R:2,3
	clr p1.0  ;setting decoder for traffic light 1
	setb p1.1 ;setting decoder for traffic light 1
	clr p1.2  ;setting decoder for traffic light 2
	clr p1.3  ;setting decoder for traffic light 2
	clr p1.4  ;setting decoder for traffic light 3
	clr p1.5  ;setting decoder for traffic light 3
	mov r3,#green
	lcall delay
	mov r4,#yellow
	;G: - Y:1 - R:2,3
	setb p1.0
	clr p1.1
	clr p1.2
	clr p1.3
	clr p1.4
	clr p1.5
	mov r3,#yellow
	lcall delay
	;;;;;;;;;;;;;;;;;;;;; state 2
	mov r4,#red
	mov r5,#green
	mov r6,#red
	;G:2 - Y: - R:1,3
	clr p1.2
	setb p1.3
	clr p1.0
	clr p1.1
	clr p1.4
	clr p1.5
	mov r3,#green
	lcall delay
	mov r5,#yellow
	;G: - Y:2 - R:1,3
	setb p1.2
	clr p1.3
	clr p1.0
	clr p1.1
	clr p1.4
	clr p1.5
	mov r3,#yellow
	lcall delay
	;;;;;;;;;;;;;;;;;;;;; state 3
	mov r4,#red
	mov r5,#red
	mov r6,#green
	;G:3 - Y: - R:2,1
	clr p1.4
	setb p1.5
	clr p1.0
	clr p1.1
	clr p1.2
	clr p1.3
	mov r3,#green
	lcall delay
	mov r6,#yellow
	;G: - Y:3 - R:2,1
	setb p1.4
	clr p1.5
	clr p1.0
	clr p1.1
	clr p1.2
	clr p1.3
	mov r3,#yellow
	lcall delay
	
	ljmp MAIN_LOOP
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; display the number in 7segment
	seg_display:
	;divide the number in 2 parts for each 7segment
	clr a
	mov a,r4
	mov b,#10
	div ab
	rl a
	rl a
	rl a
	rl a
	add a,b
	mov p3,a ;display the final result on 7segment for traffic light 1
	;;;;;;;;;
	clr a
	mov a,r5
	mov b,#10
	div ab
	rl a
	rl a
	rl a
	rl a
	add a,b
	mov p2,a ;display the final result on 7segment for traffic light 2
	;;;;;;;;;;
	clr a
	mov a,r6
	mov b,#10
	div ab
	rl a
	rl a
	rl a
	rl a
	add a,b
	mov p0,a ;display the final result on 7segment for traffic light 3
	ret
	
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; making delay for time counting
	;Delay
	delay:
	loop3:
	lcall seg_display
	dec r3
	dec r4
	dec r5
	dec r6
	mov r2,#8
	loop2:
	mov r1,#250
	loop1:
	mov r0,#250
	loop0:
	djnz r0,loop0
	djnz r1,loop1
	djnz r2,loop2
	cjne r3,#-1,loop3
	ret

END

