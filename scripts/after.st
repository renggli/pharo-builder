"Cleanup, Snapshot and Quit"
Author reset.

MCCacheRepository instVarNamed: 'default' put: nil.
MCFileBasedRepository flushAllCaches.
MCMethodDefinition shutDown.
MCDefinition clearInstances.

Smalltalk flushClassNameCache.
Smalltalk organization removeEmptyCategories.
Smalltalk allClassesAndTraitsDo: [ :each |
	each organization removeEmptyCategories; sortCategories.
	each class organization removeEmptyCategories; sortCategories ].

3 timesRepeat: [
	Smalltalk garbageCollect.
	Symbol compactSymbolTable ].

SmalltalkImage current snapshot: true andQuit: true.
