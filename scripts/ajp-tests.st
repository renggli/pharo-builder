"Run the Zinc Tests"
HDTestReport runPackages: #(
	'YBuffer-Tests-Core'
	'YBuffer-Tests-Seaside'
	'AJP-Tests-Core'
	'AJP-Tests-Pharo'
).
HDLintReport runPackages: #(
	'YBuffer-Core'
	'YBuffer-Pharo-Core'
	'AJP-Core'
	'AJP-Pharo-Core'
).
