"Load Zinc"
Gofer new
	squeaksource: 'ZincHTTPComponents';
	package: 'Zinc-Character-Encoding-Core';
	package: 'Zinc-Resource-Meta-Core';
	package: 'Zinc-HTTP';
        package: 'Zinc-FileSystem-Legacy';
	package: 'Zinc-Character-Encoding-Tests';
	package: 'Zinc-Resource-Meta-Tests';
	package: 'Zinc-Tests';
	load.
!
"Load Zodiac"
Gofer new
	squeaksource: 'Zodiac';
	package: 'Zodiac-Core';
	package: 'Zodiac-Tests';
	package: 'Zodiac-Extra';
	load.
!
"Load Zinc support for Zodiac"
Gofer it
	squeaksource: 'ZincHTTPComponents';
	package: 'Zinc-Zodiac';
	load.
