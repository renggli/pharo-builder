"Unload Test Packages"
(MCWorkingCopy allManagers 
	inject: Gofer new
	into: [ :gofer :each |
		(each packageName includesSubString: 'Test')
			ifTrue: [ gofer package: each packageName ].
		gofer ])
	unload.
!
"Unload Help Packages"
(MCWorkingCopy allManagers 
	inject: Gofer new
	into: [ :gofer :each |
		(each packageName includesSubString: 'Help')
			ifTrue: [ gofer package: each packageName ].
		gofer ])
	unload.
!
"Unload Cruft Packages"
Gofer new
	package: 'FixUnderscores';
	package: 'StratifiedProxy';
	package: 'ScriptLoader13';
	package: 'HostMenus';
	unload.