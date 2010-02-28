"Load Pier 2 Tests"
Gofer new
	renggli: 'pier2';
	package: 'Pier-Tests-Model';
	package: 'Pier-Tests-Pharo-Persistency';
	package: 'Pier-Tests-Security';
	load.
!
"Run Pier 2 Tests"
HDTestReport runPackages: #(
	'Pier-Tests-Model'
	'Pier-Tests-Pharo-Persistency'
	'Pier-Tests-Security'
).

