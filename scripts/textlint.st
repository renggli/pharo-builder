"TextLint Prerequisites"
Gofer new
	squeaksource: 'Glamour';
	package: 'Glamour-Announcements';
	package: 'Glamour-Browsers';
	package: 'Glamour-Core';
	package: 'Glamour-Helpers';
	package: 'Glamour-Morphic-Renderer';
	package: 'Glamour-Morphic-Theme';
	package: 'Glamour-Morphic-Widgets';
	package: 'Glamour-Presentations';
	load.
Gofer new
        renggli: 'petit';
        package: 'PetitParser';
        load.
!
"TextLint"
Gofer new
        squeaksource: 'textlint';
        package: 'TextLint-Model';
        package: 'TextLint-View';
	package: 'TextLint-Tests';
        load.
!
"TextLint GUI"
| stream image button |
World submorphs do: [ :each | 
	each class = TaskbarMorph
		ifFalse: [ each delete ] ].
stream := HTTPSocket httpGet: 'http://textlint.lukas-renggli.ch/images/logo.png'.
stream binary; reset.
image := (PNGReadWriter on: stream) nextImage asMorph.
image left: 10; top: 10; lock: true; sticky: true.
image openInWorld.
button := PluggableButtonMorph new.
button model: TLWizardGUI; actionSelector: #open; label: 'Open TextLint'.
button top: image bottom + 10; left: 10; sticky: true.
button openInWorld.
