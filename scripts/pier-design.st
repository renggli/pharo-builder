"Background"
World color: Color white.
!
"Logo"
| stream morph |
World submorphs do: [ :each | 
	each class = ImageMorph
		ifTrue: [ each delete ] ].
stream := HTTPSocket httpGet: 'http://www.piercms.com/files/d9/c0o7j748kn0oi311va11k6yy079jki/pier-logo.png'.
stream binary; reset.
morph := (PNGReadWriter on: stream) nextImage asMorph.
morph left: 10; top: 10; lock: true; sticky: true.
morph extent: morph extent // 2.
World addMorph: morph.

