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
	url: 'http://smalltalkhub.com/mc/Seaside/Seaside30LGPL/main';
	package: 'Seaside-Swazoo';
	load.
!
Gofer new
	url: 'http://smalltalkhub.com/mc/Seaside/Seaside30/main';
	package: 'Seaside-Adaptors-Swazoo';
	load.
!
"Start Swazoo"
(WASwazooAdaptor port: 8080)
	codec: GRPharoUtf8Codec new;
	start.
