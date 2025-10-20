Class {
	#name : #GtGarbageCollectEventsGroup,
	#superclass : #GtBasicGroup,
	#category : #'GToolkit-Utility-GarbageCollectAnalysis'
}

{ #category : #serialization }
GtGarbageCollectEventsGroup class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary."

	^ self withAll: (aDictionary at: #items)
]

{ #category : #serialization }
GtGarbageCollectEventsGroup class >> leJsonV4MappingFor: aNeoJSONMapper [

	aNeoJSONMapper for: self do: [ :mapping | 
		mapping
			mapProperty: #'__type' 
			getter: [ :object | object class leJsonV4Name ] 
			setter: [ :um | self error: 'Objects should not be read here' ].
		mapping 
			mapProperty: #items
			getter: [ :object | object items ]
			setter: [ :aCollection | self error: 'Do not set values here' ] ].
]

{ #category : #serialization }
GtGarbageCollectEventsGroup class >> leJsonV4Name [
	^ #gtGarbageCollectEventsGroup
]

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
