"Load Pier 2"
Gofer new
	renggli: 'pier2';
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
"Load Pier 2 Addons"
Gofer new
	renggli: 'pier2addons';
	package: 'Pier-Setup';
	package: 'Pier-Documents';
	package: 'Pier-EditorEnh';
	package: 'Pier-LinkChecker';
	package: 'Pier-Google';
	package: 'Pier-TagCloud';
	package: 'Pier-JQuery';
	load.
!
"Setup Pier"
PRPierFrame
	registerAsApplication: 'pier'
	kernel: PRDistribution new kernel.
WADispatcher default
	defaultName: 'pier'.
