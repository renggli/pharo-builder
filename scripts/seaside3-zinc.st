"Zinc Server"
Gofer new
	url: 'http://mc.stfx.eu/ZincHTTPComponents';
	package: 'Zinc-Character-Encoding-Core';
	package: 'Zinc-Resource-Meta-Core';
	package: 'Zinc-FileSystem-Legacy';
	package: 'Zinc-Pharo-Forward-Compatibility';
	package: 'Zinc-HTTP';
	package: 'Zinc-Seaside';
	load.
!
"Start Zinc"
(ZnZincServerAdaptor port: 8080)
	codec: GRPharoUtf8Codec new;
	start.
