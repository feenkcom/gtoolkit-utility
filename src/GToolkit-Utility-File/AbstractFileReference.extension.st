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
		aCurrentFile := self asAbsolute.
		[ aCurrentFile isNotNil ] whileTrue: [
			| aParent |
			(aCurrentFile basename = '..') 
				ifTrue: [
					"let's skip the `..` path segment"
					| pathSegments newReversedSegments newPath |
					pathSegments := aCurrentFile asAbsolute path segments.
					newReversedSegments := Array streamContents: [ :aSegmentStream | 
						| hasSkipped |
						hasSkipped := false.
						pathSegments size - 1 to: 1 by: -1 do: [ :anIndex | 
							| aSegment |
							aSegment := pathSegments at: anIndex.
							hasSkipped 
								ifTrue: [ aSegmentStream nextPut: aSegment ]
								ifFalse: [
									aSegment = '..' 
										ifTrue: [ aSegmentStream nextPut: aSegment ]
										ifFalse: [ hasSkipped := true ] ]
						]
					].
					
					newReversedSegments
						ifNotEmpty: [
							"Create a real absolute parent"
							newPath := AbsolutePath withAll: newReversedSegments reversed.
							aParent := aCurrentFile resolve: newPath ]
						ifEmpty: [
							"We are at a root directory"
							aParent := aCurrentFile ] ]
				ifFalse: [
					aStream nextPut: aCurrentFile.
					aParent := aCurrentFile parent.
				].
				
			aParent = aCurrentFile 
				ifTrue: [ aCurrentFile := nil ]
				ifFalse: [ aCurrentFile := aParent ]
		]
	].
	
	^ withParents reversed
]
