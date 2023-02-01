'picaxe LDR camera by patrick leiser
#picaxe 40x2
'b0 used
'b1 used
symbol imgcounter=b2
symbol configbits=b3
	symbol useeeprom=bit23
'b4 used
'b5 used
symbol rowsize=6   '5 pixels, 1 to 5
symbol colsize=6     '5 pixels, 1 to 5
symbol imagesize=rowsize*colsize'5x5 pixels=25
symbol rowloops=rowsize-1    'rowsize for use in 0 to row loops
symbol colloops=colsize-1      'colsize for use in 0 to col loops
symbol ptrmax=1024/imagesize
symbol datamax=255/imagesize

sertxd ("starting camera")

shutter:
if pinA.5=1 then shutter   'wait for shutter to be pressed

main:
'if useeeprom =1 then
'	read 0,b4
'	inc b4
'	write 0,b4
'endif
ptr=imgcounter*imagesize'0
for b1=0 to rowloops  'scan column
	for b0=colloops to 0 step -1  'scan rows
		gosub all_input
		on b0 gosub col1,col2,col3,col4,col5,col6
		on b1 gosub row1,row2,row3,row4,row5,row6
'		if useeeprom=1 then
'			b4=ptr+1
'			write b4,@ptr
'		endif
	next b0
next b1
imgout:
inc imgcounter
sertxd (#imgcounter," images", cr,lf)
dec imgcounter
for b4=0 to imgcounter
ptr=imgcounter*imagesize'0
sertxd ("image #",#b4,":",cr,lf)
for b0=0 to colloops
	for b1=0 to rowloops
		sertxd (#@ptrinc,cr,lf)',", ")
		if pinA.5=0 then
			sertxd ("cut!")
			goto main
		endif
	next b1
	'sertxd (cr,lf)
next b0
sertxd (cr,lf,cr,lf,cr,lf)
next b4
'read 0, b4
'if b4>0 then
'	gosub eepromimgout
'endif
for b0=0 to 100
if pinA.5=0 then
	if imgcounter<=ptrmax then
		inc imgcounter

		goto main 'if shutter pressed take photo
	endif
endif
pause 10
next b0
goto imgout    'output photo


col1:
high B.0
'sertxd ("col1")
return

col2:
high B.1
'sertxd ("col2")
return

col3:
high B.2
'sertxd ("col3")
return

col4:
high B.3
'sertxd ("col4")
return

col5:
high B.4
'sertxd ("col5")
return

col6:
high B.5
return

row1:
readadc 27,@ptrinc
'sertxd ("row1")
return

row2:
readadc 26,@ptrinc
'sertxd ("row2")
return

row3:
readadc 25,@ptrinc
'sertxd ("row3")
return

row4:
readadc 24,@ptrinc
'sertxd ("row4")
return

row5:
readadc 19,@ptrinc
'sertxd ("row5")
return

row6:
readadc 18,@ptrinc
return

all_input:
dirsB=%00000000
dirsA=%00000000
return
format:
'	#error ("not implemented")
goto main


formattimer:
	pause 20
	inc b4
	if b4>=200 then format
	if pinA.5=0 then formattimer
	goto eeprommain

eeprommain:

	read 0,b4
	inc b4
	write 0,b4
ptr=b4*imagesize+1'imgcounter*imagesize'0
for b1=0 to colloops   'scan column
	for b0=0 to rowloops  'scan rows
		gosub all_input
		on b0 gosub col1,col2,col3,col4,col5
		on b1 gosub row1,row2,row3,row4,row5

			'b4=ptr+1
			write ptr,@ptr

	next b0
next b1
#rem
eepromimgout:
read 0, b5
inc b5
sertxd (#imgcounter," saved images", cr,lf)

for b4=0 to b5
ptr=imgcounter*imagesize'0
sertxd ("image #",#b4,":",cr,lf)
for b0=0 to colloops
	for b1=0 to rowloops
		sertxd (#@ptrinc,cr,lf)',", ")
		if pinA.5=0 then
			sertxd ("cut!")
			goto main
		endif
	next b1
	'sertxd (cr,lf)
next b0
sertxd (cr,lf,cr,lf,cr,lf)
next b4
for b0=0 to 100
if pinA.5=0 then
	if imgcounter<=ptrmax then
		inc imgcounter

		goto main 'if shutter pressed take photo
	endif
endif
pause 10
next b0
goto imgout
#endrem