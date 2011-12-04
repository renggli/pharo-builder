"Run the Seaside 3.0 Lint"
HDLintReport runPackages: ((WADevelopment allPackages
    reject: [ :each | each name includesSubString: '-Tests-' ])
    collect: [ :each | each name ]).
