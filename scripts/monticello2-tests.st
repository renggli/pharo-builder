"Run the Monticello Tests"
HDTestReport runPackages: (PackageOrganizer default packages
	select: [ :each | each packageName beginsWith: 'MC2-Tests' ])
