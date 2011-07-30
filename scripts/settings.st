"Setup Environment"
UIThemeWatery2 beCurrent.
World color: Color white.
World submorphs do: [ :each |
	(#(SketchMorph ImageMorph) includes: each class name)
		ifTrue: [ each delete ] ].
SystemWindow fullScreenMargin: 0.
WorldState showUpdateOptionInWorldMenu: false.
UITheme currentSettings
	selectionTextColor: Color black;
	menuSelectionTextColor: Color white.
UITheme currentAnimationSettings
	useAnimation: false;
	animateClosing: false.