Class {
	#name : #GtGarbageCollectEventsGroup,
	#superclass : #GtBasicGroup,
	#category : #'GToolkit-Utility-GarbageCollectAnalysis'
}

{ #category : #views }
GtGarbageCollectEventsGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Items';
		priority: 10;
		items: [ self ];
		column: 'Time' text: [ :each | each startTime asTime print24 ] width: 70;
		column: 'Source' text: [ :each | each sourceDescription ];
		column: 'Duration' text: [ :each | each duration gtShortPrintString ];
		column: 'Removed Space' text: [ :each | each reducedOldSpaceSizeDescription ];
		column: 'Largest Free Chunk' text: [ :each | 
			each largestFreeChunkSizeDescription];
		column: 'Final Old Space' text: [ :each | 
			each parametersDiffReport targetReport oldSpaceSizeParameter formattedParameterValue  ]
]

{ #category : #accessing }
GtGarbageCollectEventsGroup >> numberOfEventsWithBasicNewSource [
	^ items count: [:anEvent |
		anEvent hasBasicNewSource]
]
