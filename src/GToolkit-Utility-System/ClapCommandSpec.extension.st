Extension { #name : #ClapCommandSpec }

{ #category : #'*GToolkit-Utility-System' }
ClapCommandSpec >> addGtGlobalOptions [
	"Add global GT flags to the receiver.
	These flags aren't processed using Clap, however beginning with Pharo 13 Clap doesn't ignore additional flags"

	self class methods
		select: [ :method | method hasPragmaNamed: #gtClapGlobalOptions ]
		thenDo: [ :method | 
			method valueWithReceiver: self ]
]

{ #category : #'*GToolkit-Utility-System' }
ClapCommandSpec >> gtGlobalOptions [
	"Add global GT flags to the receiver.
	These flags aren't processed using Clap, however beginning with Pharo 13 Clap doesn't ignore additional flags"
	<gtClapGlobalOptions>

	self
		add: ((ClapFlag id: #detachChanges) description: 'Close the default changes file for write and create a detached changes file');
		add: ((ClapFlag id: #detachChangesDir) 
				description: 'Close the default changes file for write and create a detached changes file in the specified directory';
				add: (ClapPositional id: #directory)
				yourself);
		add: ((ClapFlag id: #detachChangesFromFileSystem) description: 'Close the default changes file for write and save changes in-memory');
		add: ((ClapFlag id: #epiceaMemoryStore) description: 'Switch Epicea to an in-memory store');
		add: ((ClapFlag id: #noGtImageUpdate) description: 'Don''t process image version preferences');
		add: ((ClapFlag id: #noLepiterReload) description: 'Don''t reload lepiter on startup').
	(parameters includesKey: #pharoDebugLog) ifFalse:
		[ self add: ((ClapFlag id: #pharoDebugLog) 
				description: 'PharoDebug.log location, see GtPharoDebugLogCli';
				add: (ClapPositional id: #path);
				yourself) ].
]
