Extension { #name : #SpaceTallyItem }

{ #category : #'*GToolkit-Utility-SpaceTally' }
SpaceTallyItem >> gtDescriptionOn: aStream [

	analyzedClassName ifNotNil: [ 
		aStream print: analyzedClassName ].
	
	aStream nextPutAll: '('.
	codeSize ifNotNil: [ aStream
		nextPutAll: 'code size: ';
		print: codeSize ].
	instanceCount ifNotNil: [ aStream
		nextPutAll: ' instance count: ';
		print: instanceCount ].
	spaceForInstances ifNotNil: [ aStream
		nextPutAll: ' space for instances: ';
		print: spaceForInstances ].
	aStream nextPutAll: ')'
]
