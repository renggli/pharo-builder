"Load Magritte 2 Tests"
Gofer new
	renggli: 'magritte2';
	package: 'Magritte-Tests-Model';
	package: 'Magritte-Tests-Pharo-Model';
	load.
!
"Run Magritte 2 Tests"
HDTestReport runPackages: #(
	'Magritte-Tests-Model'
	'Magritte-Tests-Pharo-Model'
).
