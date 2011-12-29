"Refactoring"
Gofer new
	squeaksource: 'rb';
	package: 'AST-Core';
	package: 'AST-Semantic';
	package: 'Refactoring-Core';
	package: 'Refactoring-Changes';
	package: 'Refactoring-Critics';
	package: 'Refactoring-Environment';
	package: 'Refactoring-Spelling';
	package: 'Refactoring-Pharo-Platform';
	load.
!
"OmniBrowser"
Gofer new
	renggli: 'omnibrowser';
	package: 'OmniBrowser';
	package: 'OB-Pharo-Platform';
	package: 'OB-Polymorph';
	package: 'OB-Standard';
	package: 'OB-Shout';
	package: 'OB-Refactory';
	package: 'OB-Regex';
	package: 'OB-SUnitIntegration';
	load.
!
"Tools"
Gofer new
	renggli: 'unsorted';
	package: 'Shout';
	package: 'ECompletion';
	package: 'ECompletionOmniBrowser';
	load.
!
"Select Tools"
SystemBrowser default: (Smalltalk at: #OBSystemBrowserAdaptor).
