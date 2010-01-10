"Refactoring"
Gofer new
	squeaksource: 'rb';
	package: 'AST-Tests';
	package: 'Refactoring-Tests';
	load.
!
"OmniBrowser"
Gofer new
	renggli: 'omnibrowser';
	package: 'BogusInfo';
	package: 'OB-Fake';
	package: 'OB-Tests-Core';
	package: 'OB-Tests-Morphic';
	package: 'OB-Tests-Standard';
	load.
!
"Run the Refactoring and OmniBrowser Tests"
HDTestReport runPackages: #('AST-Tests' 'Refactoring-Tests' 'OB-Tests-Core' 'OB-Tests-Morphic' 'OB-Tests-Standard').
