"Unload Test Packages"
(MCWorkingCopy allManagers 
	inject: Gofer new
	into: [ :gofer :each |
		(each packageName includesSubString: 'Test')
			ifTrue: [ gofer package: each packageName ].
		gofer ])
	unload.
!
"Unload Cruft Packages"
Gofer new
        package: 'FixUnderscores';
        package: 'HelpSystem-Core';
	package: 'SimpleMorphic';
	package: 'Glamour-Morphic-Theme';
	package: 'Announcements-Help';
	package: 'Regex-Help';
	package: 'Finder';
	package: 'DialogItemsChooser';
        unload.
