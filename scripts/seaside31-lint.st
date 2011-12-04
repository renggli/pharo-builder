"Run the Seaside 3.1 Lint Report"
HDLintReport runPackages: ((WADevelopment allPackages
    reject: [ :each | each name includesSubString: '-Tests-' ])
    collect: [ :each | each name ]).
