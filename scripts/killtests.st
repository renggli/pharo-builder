"Unload Test Packages"
(MCWorkingCopy allManagers 
	inject: Gofer new
	into: [ :gofer :each |
		((each packageName endsWith: 'Test') or: [ each packageName endsWith: 'Tests' ])
			ifTrue: [ gofer package: each packageName ].
		gofer ])
	unload.
