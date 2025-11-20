Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Utility-File' }
AbstractFileReference >> asGtFileReferenceWithRanges [
	| fr |

	fr := self resolve.
	^ GtFileReferenceWithRanges fileSystem: fr fileSystem path: fr path
]

{ #category : #'*GToolkit-Utility-File' }
AbstractFileReference >> binaryContents [
	self binaryReadStreamDo: [ :stream |
		^ stream contents ]
]

{ #category : #'*GToolkit-Utility-File' }
AbstractFileReference >> gtViewPharoDebugLogFor: aView [
	<gtView>

	((self extension ~= 'log' and:
	[ (self basename includesSubstring: 'PharoDebug') not ]) or: 
		[ self exists not ]) ifTrue:
			[ ^ aView empty ].
	
	^ aView forward
		title: 'Entries';
		priority: 10;
		object: [ GtPharoDebugLogInspector new file: self ];
		view: #gtViewEntriesFor:
]

{ #category : #'*GToolkit-Utility-File' }
AbstractFileReference >> isFileLocator [

	^ false
]

{ #category : #'*GToolkit-Utility-File' }
AbstractFileReference >> isFileReference [

	^ false
]

{ #category : #'*GToolkit-Utility-File' }
AbstractFileReference >> withParents [
	<return: #Array of: #FileReference>
	| withParents |
	withParents := Array streamContents: [ :aStream | 
		| aCurrentFile |
		aCurrentFile := self asAbsolute canonicalize.
		[ aCurrentFile isRoot ] whileFalse: [
			aStream nextPut: aCurrentFile.
			aCurrentFile := aCurrentFile parent ].
		aStream nextPut: aCurrentFile.
	].
	
	^ withParents reversed
]
