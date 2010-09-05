"Refactoring Tests"
Gofer new
	squeaksource: 'rb';
	package: 'AST-Tests-Core';
	package: 'AST-Tests-Semantic';
	package: 'Refactoring-Tests-Core';
	package: 'Refactoring-Tests-Environment';
	package: 'Refactoring-Tests-Changes';
	package: 'Refactoring-Tests-Critics';
	package: 'Refactoring-Tests-Spelling';
	load.
!
"OmniBrowser Tests"
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
"Tool Tests"
Gofer new
	renggli: 'unsorted';
    package: 'ShoutTests';
	load.
!
"Run the Refactoring and OmniBrowser Tests"
HDTestReport runPackages: #('AST-Tests-Core' 'AST-Tests-Semantic' 'Refactoring-Tests-Core' 'Refactoring-Tests-Environment' 'Refactoring-Tests-Changes' 'Refactoring-Tests-Critics' 'Refactoring-Tests-Spelling' 'OB-Tests-Core' 'OB-Tests-Morphic' 'OB-Tests-Standard' 'OB-Tests-Refactory' 'RoelTyper' 'ECompletion' 'ShoutTests').
HDLintReport runPackages: #('AST-Core' 'AST-Semantic' 'Refactoring-Core' 'Refactoring-Changes' 'Refactoring-Critics' 'Refactoring-Environment' 'Refactoring-Spelling' 'OmniBrowser' 'OB-Standard' 'OB-Morphic' 'OB-Shout' 'OB-Refactory' 'OB-Regex' 'OB-SUnitIntegration').
