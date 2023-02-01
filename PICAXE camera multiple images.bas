'picaxe LDR camera by patrick leiser

'b0 used
'b1 used
symbol imgcounter=b2
'b3 used
sertxd ("starting camera")
shutter:
if pinA.5=1 then shutter   'wait for shutter to be pressed
main:
ptr=imgcounter*25'0
for b1=0 to 4   'scan column
	for b0=0 to 4  'scan rows
		gosub all_input
		on b0 gosub col1,col2,col3,col4,col5
		on b1 gosub row1,row2,row3,row4,row5
	next b0
next b1
imgout:
inc imgcounter
sertxd (#imgcounter," images", cr,lf)
dec imgcounter
for b3=0 to imgcounter
ptr=imgcounter*25'0
sertxd ("image #",#b3,":",cr,lf)
for b0=0 to 4
	for b1=0 to 4
		sertxd (#@ptrinc,cr,lf)',", ")
		if pinA.5=0 then
			sertxd ("cut!")
			goto main
		endif
	next b1
	'sertxd (cr,lf)
next b0
sertxd (cr,lf,cr,lf,cr,lf)
next b3
for b0=0 to 100
if pinA.5=0 then
	inc imgcounter
	 goto main 'if shutter pressed take photo
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



all_input:
dirsB=%00000000
dirsA=%00000000
return