"Update Gofer"
"[ Gofer gofer load ]
	on: Error
	do: [ :err | err retry ].
Gofer upgrade; upgrade."
!
"Remove empty categories"
Smalltalk organization removeEmptyCategories.
