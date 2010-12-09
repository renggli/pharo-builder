"Unload Test Packages"
(MCWorkingCopy allManagers 
	inject: Gofer new
	into: [ :gofer :each |
		((each packageName endsWith: 'Test') or: [ each packageName endsWith: 'Tests' ])
			ifTrue: [ gofer package: each packageName ].
		gofer ])
	unload.
!
"Unload Useless Packages (Pharo 1.2)"
"Gofer new
        package: 'Finder';
        package: 'FixUnderscores';
        package: 'Glamour-Morphic-Theme';
        package: 'HelpSystem-Core';
        package: 'Announcements-Help';
        package: 'Regex-Help';
        unload."

