"Pier"
[ Gofer new
	renggli: 'pier';
	package: 'Pier-Model';
	package: 'Pier-Tests';
	package: 'Pier-Seaside';
	package: 'Pier-Blog';
	package: 'Pier-Security';
	package: 'Pier-Squeak-Persistency';
	load ]
	valueSupplyingAnswers: { 
		{ 'would you like'. true }.
		{ 'pier kernel'. 'Pier' }.
		{ 'entry point'. 'pier' }.
		{ 'port number'. '8080' }.
		{ 'is running on'. nil }.
	}.
!
"Pier Addons"
Gofer new
	renggli: 'pieraddons';
	package: 'Pier-Design';
	package: 'Pier-Documents';
	package: 'Pier-EditorEnh';
	package: 'Pier-Google';
	package: 'Pier-Design';
	package: 'Pier-Links';
	package: 'Pier-Randomizer';
	package: 'Pier-TagCloud';
	package: 'Pier-Slideshow';
	package: 'Pier-Twitter';
	package: 'Pier-Book';
	package: 'Pier-DesignChooser';
	package: 'Pier-Setup';
	load.
!
"Install Setup"
PRLoader setupPier.

