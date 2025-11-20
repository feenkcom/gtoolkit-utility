Extension { #name : #Context }

{ #category : #'*GToolkit-Utility-System' }
Context >> errorReportOn: stream [
	<gtPharoPatch: #Pharo>
	
	"Write a detailed error report on the stack (above me) on a
	stream.  For both the error file, and emailing a bug report.
	Suppress any errors while getting printStrings.  Limit the length."
	| stackDepth aContext maxDetailedStackDepth maxFullStackDepth|

	stream nextPutAll: DateAndTime now asIso8601; cr.
	stream cr.
	stream nextPutAll: 'VM: ';
		nextPutAll: Smalltalk os name asString;
		nextPutAll: ' - ';
		nextPutAll: Smalltalk os subtype asString;
		nextPutAll: ' - ';
		nextPutAll: Smalltalk os version asString;
		nextPutAll: ' - ';
		nextPutAll: Smalltalk vm version asString;
		cr.
	
	#GtImage asClassIfPresent: [ :aClass |
		stream nextPutAll: 'GT Image: ';
			nextPutAll: (aClass version 
				ifNil: [ 'missing version']
				ifNotNil: [ :aVersion | aVersion versionString]);
			cr. ] .
	
	stream nextPutAll: 'Pharo Image: ';
		nextPutAll:  SystemVersion current version asString;
		nextPutAll: ' [';
		nextPutAll: Smalltalk lastUpdateString asString;
		nextPutAll: ']';
		cr.
	stream cr.
	"Note: The following is an open-coded version of  Context>>stackOfSize: since this method may be called during a  low space condition and we might run out of space for allocating the  full stack."
	stackDepth := 0.
	aContext := self.
	maxDetailedStackDepth := 80.
	maxFullStackDepth := 400.
	[ aContext notNil and: [ (stackDepth := stackDepth + 1) < maxDetailedStackDepth ]]
		whileTrue: [
			"variable values"
			aContext printDetails: stream.
			stream cr.
			aContext := aContext sender ].
	stream cr; nextPutAll: '--- The full stack ---'; cr.
	aContext := self.
	stackDepth := 0.
	[ aContext == nil ] whileFalse:	[
		stackDepth := stackDepth + 1.
		stackDepth = maxDetailedStackDepth ifTrue: [ stream nextPutAll: ' - - - - - - - - - - - - - - -
			- - - - - - - - - - - - - - - - - -'; cr ].
		"just class>>selector"
		stream print: aContext; cr.
		stackDepth > maxFullStackDepth ifTrue: [
			stream nextPutAll: '-- and more not shown --'.
			^  self ].
		aContext := aContext sender ]
]

{ #category : #'*GToolkit-Utility-System' }
Context >> message [
	"Answer the receiver's selector and arguments as a Message"

	^ Message
		selector: self selector 
		arguments: self arguments
]

{ #category : #'*GToolkit-Utility-System' }
Context >> stackString [

	^ String streamContents: [ :stream | 
		self stack do: [ :stackItem | 
			stream
				print: stackItem;
				cr ] ]
]
