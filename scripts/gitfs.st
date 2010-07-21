"GitFS"
Gofer new
	squeaksource: 'GitFS';
	package: 'Filesystem';
	package: 'FS-Git';
	load.
!

Preferences enable: #mercuryPanel.
!

"Create initial environment"
TestRunner open bounds: (1152@520 corner: 1792@1000).

width := 1920 // 2.
height := 1032 // 1.5.

OBSystemBrowser open bounds: (3@0 extent: (width-3)@height).
OBSystemBrowser open bounds: (width+3@0 extent: (width-6) @ height).

(SHWorkspace new openAsMorphLabel: 'Shout') bounds: (3@(height+3) extent: (width-3)@(1032-height-30)).
