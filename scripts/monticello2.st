"Monticello 2"
[ Gofer new
	wiresong: 'mc';
	package: 'Grease-Core';
	package: 'Grease-Pharo-Core';
	package: 'Grease-Tests-Core';
	package: 'Grease-Tests-Pharo-Core';
	package: 'MC2-Umbrella';
	load ]
		on: Warning
		do: [ :warning | 
			(warning isKindOf: UndeclaredVariableWarning)
				ifTrue: [ warning pass ]
				ifFalse: [ warning resume ] ]
