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
!
| stream image label |
World submorphs do: [ :each | each delete ].
stream := HTTPSocket httpGet: 'http://textlint.lukas-renggli.ch/images/logo.png'.
stream binary; reset.
image := (PNGReadWriter on: stream) nextImage asMorph.
image left: 10; top: 10; lock: true; sticky: true.
image openInWorld.
label := LabelMorph contents: 'Please wait ...'.
label left: 10; top: image bottom + 10; lock: true; sticky: true.
label openInWorld.
