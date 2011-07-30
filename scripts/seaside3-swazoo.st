"Swazoo Server"
Gofer new
	squeaksource: 'SPort';
	package: 'Sport';
	load.
!
Gofer new
	squeaksource: 'Swazoo';
	package: 'Swazoo';
	load.
!
Gofer new
	squeaksource: 'Seaside30LGPL';
	package: 'Seaside-Swazoo';
	load.
!
Gofer new
	squeaksource: 'Seaside30';
	package: 'Seaside-Adaptors-Swazoo';
	load.
!
"Start Swazoo"
(WASwazooAdaptor port: 8080)
	codec: GRPharoUtf8Codec new;
	start.