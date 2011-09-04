"TextLint Prerequisites"
Gofer new
	renggli: 'petit';
	package: 'PetitParser';
	load.
!
"TextLint"
Gofer new
	squeaksource: 'textlint';
	package: 'TextLint-Model';
	package: 'TextLint-Console';
	load.
!
SmalltalkImage checkChangesFileAvailability: false.
SmalltalkImage checkSourcesFileAvailability: false.
!
MCAncestry allSubInstancesDo: #initialize.
SmalltalkImage cleanUp: true.
