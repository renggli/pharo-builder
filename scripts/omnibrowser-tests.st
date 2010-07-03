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
	package: 'OB-Tests-Refactory';
	load.
!
"Tools"
Gofer new
	renggli: 'unsorted';
    package: 'ShoutTests';
	load.
!
"Run the Refactoring and OmniBrowser Tests"
HDTestReport runPackages: #('AST-Tests-Core' 'Refactoring-Tests-Core' 'Refactoring-Tests-Spelling' 'OB-Tests-Core' 'OB-Tests-Morphic' 'OB-Tests-Standard' 'OB-Tests-Refactory' 'RoelTyper' 'ECompletion' 'ShoutTests').
"HDLintReport runPackages: #('AST-Core' 'AST-Semantics' 'Refactoring-Core' 'Refactoring-Spelling' 'OmniBrowser' 'OB-Standard' 'OB-Morphic' 'OB-Shout' 'OB-Refactory' 'OB-Regex' 'OB-SUnitIntegration').
"
