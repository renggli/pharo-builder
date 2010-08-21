"Run Pier 2 Tests"
[ HDCoverageReport runPackages: #('OpalCompiler-Tests').
  HDLintReport runPackages: #('OpalCompiler-Core') ]
	on: Deprecation
	do: [ :err | err resume ]
