"Komanche Server"
Gofer new
	squeaksource: 'KomHttpServer';
	package: 'KomHttpServerLight';
	load.
Gofer new
	squeaksource: 'Seaside30';
	package: 'Seaside-Adaptors-Comanche';
	package: 'Seaside-Tests-Adaptors-Comanche';
	load.
!
"Start Komanche"
(WAComancheAdaptor port: 8080)
	codec: GRPharoUtf8Codec new;
	start
