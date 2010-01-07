"Update Gofer"
[ Gofer gofer load ]
	on: Error
	do: [ :err | err retry ].
Gofer upgrade; upgrade.
!
Smalltalk organization removeEmptyCategories.