"AJP Server"
Gofer new
	squeaksource: 'ajp';
	package: 'YBuffer-Core';
	package: 'YBuffer-Pharo-Core';
	package: 'AJP-Core';
	package: 'AJP-Pharo-Core';
	load.
!
"Start AJP"
(AJPPharoAdaptor port: 8003)
	codec: GRPharoUtf8Codec new;
	start.
