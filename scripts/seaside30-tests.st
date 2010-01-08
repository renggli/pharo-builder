"Run the Seaside 3.0 Tests"
HudsonTestReport reportTestsInPackages: ((WADevelopment packages 
    select: [ :each | each packageName includesSubString: '-Tests-' ])
    collect: [ :each | each packageName ]).
