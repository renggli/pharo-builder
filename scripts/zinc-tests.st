"Run the Zinc Tests"
HDTestReport runPackages: #(
	'Zinc-Character-Encoding-Tests'
	'Zinc-Resource-Meta-Tests'
	'Zinc-Tests'
	'Zodiac-Tests'
	'Zinc-Zodiac'
).
HDLintReport runPackages: #(
	'Zinc-Character-Encoding-Core'
	'Zinc-Resource-Meta-Core'
	'Zinc-HTTP'
	'Zodiac-Core'
	'Zodiac-Extra'
	'Zinc-Zodiac'
).
