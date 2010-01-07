"Select Fonts"
StrikeFont installDejaVu.
Preferences setDefaultFonts: #(
        (setBalloonHelpFontTo: 'BitmapDejaVu' 9)
        (setButtonFontTo: 'BitmapDejaVu' 9)
        (setCodeFontTo: 'BitmapDejaVu' 9)
        (setHaloLabelFontTo: 'BitmapDejaVu' 9)
        (setListFontTo: 'BitmapDejaVu' 9)
        (setMenuFontTo: 'BitmapDejaVu' 9)
        (setSystemFontTo: 'BitmapDejaVu' 9)
        (setWindowTitleFontTo: 'BitmapDejaVuBold' 12)).
!
"Cleanup Environment"
UIThemeStandardSqueak beCurrent.
World submorphs do: [ :each |
        (each isKindOf: SketchMorph)
                ifTrue: [ each delete ] ].
!
"Set decent Preferences"
Preferences enable: #scrollBarsNarrow.
Preferences enable: #menuColorFromWorld.
Preferences disable: #scrollBarsWithoutMenuButton.
Preferences disable: #useNewDiffToolsForMC.
Preferences disable: #duplicateAllControlAndAltKeys.
Preferences disable: #fadedBackgroundWindows.
Preferences disable: #windowAnimation.
Preferences disable: #noWindowAnimationForClosing.