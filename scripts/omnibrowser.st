"Refactoring"
Gofer new
	squeaksource: 'rb';
	package: 'AST-Core';
	package: 'Refactoring-Core';
	package: 'Refactoring-Spelling';
	load.
!
"OmniBrowser"
Gofer new
	renggli: 'omnibrowser';
	package: 'OmniBrowser';
	package: 'OB-Standard';
	package: 'OB-Morphic';
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
	package: 'ShoutWorkspace';
	package: 'RoelTyper';
	package: 'ECompletion';
	package: 'ECompletionOmniBrowser';
	load.
!
"Select Tools"
SystemBrowser default: (Smalltalk at: #OBSystemBrowserAdaptor).

