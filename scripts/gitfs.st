"GitFS"
Gofer new
	squeaksource: 'GitFS';
	package: 'Filesystem';
	package: 'Git';
	package: 'GitFS';
	load.
!
Preferences enable: #mercuryPanel.
!

"Create initial environment"
TestRunner open.

width := World width // 2.
height := World height // 1.5.

OBSystemBrowser open bounds: (3@0 extent: (width-3)@height).
OBSystemBrowser open bounds: (width+3@0 extent: (width-6) @ height).

(Workspace new openAsMorphLabel: 'Workspace') bounds: (3@(height+3) extent: (width-3)@(World height - height-30))
