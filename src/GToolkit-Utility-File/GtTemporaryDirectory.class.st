"
I am a simple utility object that holds a directory {{gtClass:FileReference}} object.
The referenced directory is removed on the object finalization.
I am not supposed to be polymorphic to {{gtClass:FileReference}}.
I should rather be used in examples (and similar code).

"
Class {
	#name : #GtTemporaryDirectory,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'reference'
	],
	#category : #'GToolkit-Utility-File'
}

{ #category : #'private - initialization' }
GtTemporaryDirectory >> ensureCreateTemporaryReference [
	^ mutex critical: [
		reference ifNil: [
			
			reference := FileReference
					newTempFilePrefix: 'gt-temporary-'
					suffix: '-directory'.
			
			reference ensureCreateDirectory.
			
			"Remove the directory when the object is not used."
			self class finalizationRegistry add: self ].
		
		reference ]
]

{ #category : #finalization }
GtTemporaryDirectory >> finalize [
	reference
		ifNotNil: [ :aDirectory | 
			reference := nil.
			[ aDirectory ensureDeleteAll. ]
				on: Error
				do: [ :anException | 
					"silently ignore errors"
					anException emit ] ].
	super finalize
]

{ #category : #initialization }
GtTemporaryDirectory >> initialize [
	super initialize.
	
	mutex := Mutex new.
	reference := nil.
]

{ #category : #printing }
GtTemporaryDirectory >> printOn: aStream [
	super printOn: aStream.

	reference ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self reference fullName;
		nextPut: $)
]

{ #category : #'api - accessing' }
GtTemporaryDirectory >> reference [
	<return: #FileReference>
	reference ifNil: [ self ensureCreateTemporaryReference ].
	^ reference
]

{ #category : #'api - initialization' }
GtTemporaryDirectory >> reference: aDirectory [
	self 
		assert: [ aDirectory isNotNil ] 
		description: [ 'Directory must be non-nil' ].
	
	self
		assert: [ (aDirectory exists and: [ aDirectory isDirectory ]) ]
		description: [ 'Directory must be an existing directory' ].

	mutex critical: [
		self
			assert: [ reference isNil ]
			description: [ 'Directory can be set only once' ].
	
		reference := aDirectory.
		
		"Remove the directory when the object is not used."
		self class finalizationRegistry add: self ]
]
