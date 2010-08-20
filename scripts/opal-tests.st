"Run Pier 2 Tests"
[ HDTestReport runPackages: #('OpalCompiler').
  HDLintReport runPackages: #('Opalcompiler') ]
	on: Deprecation
	do: [ :err | err resume ]
