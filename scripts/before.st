"Initialize Image Building"
MCCacheRepository instVarNamed: 'default' put: nil.
Deprecation raiseWarning: false.
!
"Load Jenkins Build Tools"
Gofer new
	renggli: 'hudson';
	package: 'HudsonBuildTools';
	load.
