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
UIThemeWatery2 beCurrent.
World color: Color white.
World submorphs do: [ :each |
        (#(SketchMorph ImageMorph) includes: each class name)
                ifTrue: [ each delete ] ].
WorldState showUpdateOptionInWorldMenu: false.
!
"Set decent Preferences"
Preferences enable: #menuColorFromWorld.
Preferences disable: #useNewDiffToolsForMC.
Preferences disable: #fadedBackgroundWindows.
Preferences disable: #windowAnimation.
Preferences enable: #noWindowAnimationForClosing.
