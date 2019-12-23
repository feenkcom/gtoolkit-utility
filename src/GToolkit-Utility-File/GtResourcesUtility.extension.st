Extension { #name : #GtResourcesUtility }

{ #category : #'*GToolkit-Utility-File' }
GtResourcesUtility >> documentsMatching: aPattern [
	<return: #Array of: #ReferenceFile>
	^ (IceRepository registry 
		select: [ :eachRepository | 
			eachRepository location notNil and: [ 
				(eachRepository location / 'doc') exists ] ])
		flatCollect: [ :eachRepository |
			(eachRepository location / 'doc') allChildrenMatching: aPattern ]
]

{ #category : #'*GToolkit-Utility-File' }
GtResourcesUtility >> pillarDocuments [
	<return: #Array of: #ReferenceFile>
	^ self documentsMatching: GtFileUtilityConstants pillarMatchingPattern
]
