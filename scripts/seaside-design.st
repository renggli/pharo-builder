"Background"
| gradient |
gradient := GradientFillStyle colors: (Array 
	with: (Color gray: 0.05) 
	with: (Color gray: 0.33)).
gradient direction: 0 @ World height.
gradient origin: 0 @ 0.
gradient radial: false.
World fillStyle: gradient.
!
"Logo"
| stream morph |
World submorphs do: [ :each | 
	each class = ImageMorph
		ifTrue: [ each delete ] ].
stream := HTTPSocket httpGet: 'http://www.seaside.st/files/3d/7g2rn53ickp4mxkfjn32kwgx8xpgmm/seaside-s.png'.
stream binary; reset.
morph := (PNGReadWriter on: stream) nextImage asMorph.
morph left: 10; top: 10; lock: true; sticky: true.
World addMorph: morph.
!
"Management Browser"
Smalltalk
	at: #WAServerAdaptorBrowser
	ifPresent: [ :class | class open position: 10 @ 120 ]
