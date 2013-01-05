"Zinc Server"
Gofer new
	squeaksource: 'ZincHTTPComponents';
	package: 'Zinc-HTTP';
	package: 'Zinc-Seaside';
	load.
!
"Start Zinc"
(ZnZincServerAdaptor port: 8080)
	codec: GRPharoUtf8Codec new;
	start.