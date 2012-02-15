"Load Pier 3"
Gofer new
	renggli: 'pier3';
	package: 'Pier-Model';
	package: 'Pier-Pharo-Model';
	package: 'Pier-Tests-Model';
	package: 'Pier-Seaside';
	package: 'Pier-Pharo-Seaside';
	package: 'Pier-Security';
	package: 'Pier-Tests-Security';
	package: 'Pier-Pharo-Persistency';
	package: 'Pier-Tests-Pharo-Persistency';
	package: 'Pier-Blog';
	package: 'Pier-Book';
	load.
!
"Load Pier 3 Addons"
Gofer new
	renggli: 'pier3addons';
	package: 'Pier-Setup';
	package: 'Pier-Design';
	package: 'Pier-Documents';
	package: 'Pier-EditorEnh';
	package: 'Pier-LinkChecker';
	package: 'Pier-Google';
	package: 'Pier-TagCloud';
	package: 'Pier-JQuery';
	package: 'Pier-Randomizer';
	load.
!
"Setup Pier"
PRPierFrame
	registerAsApplication: 'pier'
	kernel: PRDistribution new kernel.
WADispatcher default
	defaultName: 'pier'.
