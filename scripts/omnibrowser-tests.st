"Refactoring"
Gofer new
	squeaksource: 'rb';
	package: 'AST-Tests-Core';
	package: 'Refactoring-Tests-Core';
	package: 'Refactoring-Tests-Spelling';
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
HDTestReport runPackages: #('AST-Tests-Core' 'Refactoring-Tests-Core' 'Refactoring-Tests-Spelling' 'OB-Tests-Core' 'OB-Tests-Morphic' 'OB-Tests-Standard').
