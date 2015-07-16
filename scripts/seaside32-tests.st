"Run the Seaside 3.2 Test Report"
HDTestReport runPackages: ((WADevelopment allPackages
	select: [ :each | each name includesSubString: '-Tests-' ])
	collect: [ :each | each name ]).
