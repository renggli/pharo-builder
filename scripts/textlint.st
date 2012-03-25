"TextLint Prerequisites"
Gofer new
        squeaksource: 'Glamour';
        version: 'Glamour-Announcements-TudorGirba.6';
        version: 'Glamour-Browsers-TudorGirba.90';
        version: 'Glamour-Core-TudorGirba.221';
        version: 'Glamour-Helpers-TudorGirba.32';
        version: 'Glamour-Morphic-Renderer-TudorGirba.139';
        version: 'Glamour-Morphic-Theme-TudorGirba.55';
        version: 'Glamour-Morphic-Widgets-TudorGirba.31';
        version: 'Glamour-Presentations-TudorGirba.109';
        version: 'Glamour-Tools-TudorGirba.50';
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
