"Run the Seaside 3.0 Tests"
HDTestReport runPackages: ((WADevelopment allPackages 
    select: [ :each | each name includesSubString: '-Tests-' ])
    collect: [ :each | each name ]).
HDLintReport runPackages: ((WADevelopment allPackages
    reject: [ :each | each name includesSubString: '-Tests-' ])
    collect: [ :each | each name ]).
