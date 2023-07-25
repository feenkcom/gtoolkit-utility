"
I exemplify {{gtExample:GtTemporaryDirectory}}.

"
Class {
	#name : #GtTemporaryDirectoryExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-File'
}

{ #category : #examples }
GtTemporaryDirectoryExamples >> explicitDirectory [
	<gtExample>
	| directory reference |
	reference := FileReference
			newTempFilePrefix: 'gt-temporary-'
			suffix: '-example-directory'.
	reference ensureCreateDirectory.
	
	directory := GtTemporaryDirectory new.
	directory reference: reference.

	self assert: directory reference == reference.
	self assert: directory reference == directory reference.
	self assert: directory reference exists.
	self assert: directory reference isDirectory.

	^ directory
]

{ #category : #examples }
GtTemporaryDirectoryExamples >> explicitDirectoryIsGarbageCollected [
	<gtExample>
	| directory reference |
	directory := self explicitDirectory.
	reference := directory reference.
	
	self assert: reference exists.
	directory := nil.
	
	2 timesRepeat: [ Smalltalk garbageCollect ].
	
	self assert: reference exists not.

	^ reference
]

{ #category : #examples }
GtTemporaryDirectoryExamples >> implicitDirectory [
	<gtExample>
	| directory reference |
	directory := GtTemporaryDirectory new.

	reference := directory reference.

	self assert: reference == directory reference.
	self assert: reference exists.
	self assert: reference isDirectory.

	^ directory
]

{ #category : #examples }
GtTemporaryDirectoryExamples >> implicitDirectoryIsGarbageCollected [
	<gtExample>
	| directory reference |
	directory := self implicitDirectory.
	reference := directory reference.
	
	self assert: reference exists.
	directory := nil.
	
	2 timesRepeat: [ Smalltalk garbageCollect ].
	
	self assert: reference exists not.

	^ reference
]
