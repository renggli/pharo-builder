"Kom"
Gofer new
	squeaksource: 'KomHttpServer';
	package: 'DynamicBindings';
	package: 'KomServices';
	package: 'KomHttpServer';
	load.
!
"Seaside"
[ Gofer new
	squeaksource: 'Seaside';
	package: 'Seaside2.8a1';
	load ]
		valueSupplyingAnswers: { 
			{ 'username'. 'admin' }.
			{ 'password'. 'seaside' }.
		}.
!
"Seaside Addons"
Gofer new
	squeaksource: 'Seaside';
	squeaksource: 'rsrss';
	package: 'Scriptaculous';
	package: 'Comet';
	package: 'RSRSS2';
	load.