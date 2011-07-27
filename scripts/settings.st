"Select Fonts"
StrikeFont installDejaVu.
StandardFonts setFontsFromSpec: #(
    (balloonFont: 'BitmapDejaVu' 7)
    (buttonFont: 'BitmapDejaVu' 9)
    (codeFont: 'BitmapDejaVu' 9)
    (defaultFont: 'BitmapDejaVu' 9)
    (haloFont: 'BitmapDejaVu' 7)
    (listFont: 'BitmapDejaVu' 9)
    (menuFont: 'BitmapDejaVu' 9)
    (windowTitleFont: 'BitmapDejaVuBold' 12)).
!
"Cleanup Environment"
UIThemeWatery2 beCurrent.
World color: Color white.
World submorphs do: [ :each |
	(#(SketchMorph ImageMorph) includes: each class name)
		ifTrue: [ each delete ] ].
SystemWindow fullScreenMargin: 0.
WorldState showUpdateOptionInWorldMenu: false.
PSMCPatchMorph usedByDefault: false.
UITheme currentAnimationSettings
	useAnimation: false;
	animateClosing: false.
