"Run the Zinc Tests"
HDTestReport runPackages: #(
	'Zinc-Tests'
	'Zodiac-Tests'
).
HDLintReport runPackages: #(
	'Zinc-HTTP'
	'Zodiac-Core'
	'Zodiac-Extra'
	'Zinc-Zodiac'
).
