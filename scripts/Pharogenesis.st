"Pharogenesis"
Gofer new
	squeaksource: 'GitFS';
	package: 'Filesystem';
	package: 'FS-Git';
	package: 'Pharogenesis';
	package: 'PharogenesisOB'
	load.
!

Preferences enable: #mercuryPanel.
!

shout := SHWorkspace new.
shoutMorph := shout openAsMorphLabel: 'Pharogenesis'.
shoutMorph bounds: (50@50 extent: 500@600).
shout setContent:
'"
#############
Pharogenesis
#############

put interesting instructions here.
"'.
