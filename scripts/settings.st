"Setup Environment"
GLMUITheme beCurrent.
World color: Color white.
World submorphs do: [ :each |
	(#(SketchMorph ImageMorph) includes: each class name)
		ifTrue: [ each delete ] ].
PSMCPatchMorph usedByDefault: false.
SystemWindow fullScreenMargin: 0.
WorldState showUpdateOptionInWorldMenu: false.
UITheme currentSettings
	menuSelectionTextColor: Color white.
UITheme currentAnimationSettings
	useAnimation: false;
	animateClosing: false.

