Extension { #name : #DiskDirectoryEntry }

{ #category : #'*GToolkit-Utility-File' }
DiskDirectoryEntry >> gtPathFor: aView [
	<gtView>

	reference ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Path';
		priority: 20;
		object: [ reference ];
		view: #gtPathFor:
]
