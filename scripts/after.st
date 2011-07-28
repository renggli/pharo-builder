"Unload Jenkins Build Tools"
Gofer new
	package: 'HudsonBuildTools';
	unload.
!
"Clear Monticello Caches"
MCCacheRepository instVarNamed: 'default' put: nil.
MCFileBasedRepository flushAllCaches.
MCMethodDefinition shutDown.
MCDefinition clearInstances.
!
"Cleanup Smalltalk"
Author reset.
Smalltalk flushClassNameCache.
Smalltalk organization removeEmptyCategories.
Smalltalk allClassesAndTraitsDo: [ :each |
	each organization removeEmptyCategories; sortCategories.
	each class organization removeEmptyCategories; sortCategories ].
!
"Cleanup System Memory"
Smalltalk garbageCollect.
Symbol compactSymbolTable.
Deprecation raiseWarning: true.
!
"Save and Quit"
WorldState addDeferredUIMessage: [
	SmalltalkImage current snapshot: true andQuit: true ].
