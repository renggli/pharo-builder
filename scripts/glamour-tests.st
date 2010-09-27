"Run the Glamour Tests"
HDTestReport runPackages: ((Smalltalk organization categories
	select: [ :each | each beginsWith: 'Glamour' ])
	select: [ :each | each includesSubString: 'Test' ]).
HDTestReport runPackages: ((Smalltalk organization categories
	select: [ :each | each beginsWith: 'Glamour' ]) 
	reject: [ :each | each includesSubString: 'Test' ]).
