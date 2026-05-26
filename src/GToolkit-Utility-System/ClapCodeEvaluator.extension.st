Extension { #name : #ClapCodeEvaluator }

{ #category : #'*GToolkit-Utility-System' }
ClapCodeEvaluator class >> evaluate [
	<commandline>
	<gtPharoPatch: #Pharo13>
	^ (ClapCommandSpec id: #evaluate)
		aliases: #('eval');
		commandClass: self;
		description: 'Print the result of a Pharo expression';
		addHelp;
		addGtGlobalOptions;
		addFlag: #save description: 'Save the image after evaluation';
		addFlag: #keepAlive description: 'Keep image running';
		addPositional: #EXPR spec: [ :positional |
			positional
				description: 'The expression to evaluate, joining successive arguments with spaces (if omitted, read the expression from stdin)';
				multiple: true;
				defaultValue: [ :match | "in the absence of an explicit argument, read from standard input"
					Array with: match context stdin upToEnd ] ];
		yourself
]
