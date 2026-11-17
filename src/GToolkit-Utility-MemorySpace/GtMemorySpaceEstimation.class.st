"
I estimate the memory space of a subject as declared by a {{gtClass:GtMemorySpaceDefinition}}: I walk its roots with their attributions, using a {{gtClass:GtMemorySpaceEstimator}}, and keep the resulting {{gtClass:GtMemorySpaceEstimate}}.

After running, I keep the estimator for inspecting its class traversals, but release its set of visited objects.
"
Class {
	#name : #GtMemorySpaceEstimation,
	#superclass : #Object,
	#instVars : [
		'definition',
		'subject',
		'estimate',
		'estimator',
		'computationTime'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceEstimation class >> definition: aDefinition subject: aSubject [
	^ self new
		definition: aDefinition;
		subject: aSubject;
		yourself
]

{ #category : #accessing }
GtMemorySpaceEstimation >> computationTime [
	^ computationTime
]

{ #category : #accessing }
GtMemorySpaceEstimation >> definition [
	^ definition
]

{ #category : #accessing }
GtMemorySpaceEstimation >> definition: aDefinition [
	definition := aDefinition
]

{ #category : #accessing }
GtMemorySpaceEstimation >> estimate [
	^ estimate
]

{ #category : #accessing }
GtMemorySpaceEstimation >> estimator [
	^ estimator
]

{ #category : #'gt - extensions' }
GtMemorySpaceEstimation >> gtViewCategoriesFor: aView [
	<gtView>
	self hasRun ifFalse: [ ^ aView empty ].

	^ aView forward
		title: 'Categories';
		priority: 10;
		object: [ estimate ];
		view: #gtViewCategoriesFor:
]

{ #category : #'gt - extensions' }
GtMemorySpaceEstimation >> gtViewOverviewFor: aView [
	<gtView>
	self hasRun ifFalse: [ ^ aView empty ].

	^ aView columnedList
		title: 'Overview';
		priority: 5;
		items: [ {{'Subject'.
					subject printString.
					subject}.
				{'Total size'.
					self totalBytes humanReadableIsqByteSize.
					estimate}.
				{'Objects counted'.
					self objectsCount.
					estimator}.
				{'Computation time'.
					computationTime printString.
					computationTime}.
				{'Definition'.
					definition printString.
					definition}} ];
		column: 'Property'
			text: [ :each | each first ]
			width: 150;
		column: 'Value' text: [ :each | each second ];
		send: [ :each | each third ]
]

{ #category : #testing }
GtMemorySpaceEstimation >> hasRun [
	^ estimate notNil
]

{ #category : #accessing }
GtMemorySpaceEstimation >> objectsCount [
	^ estimator objectsCount
]

{ #category : #printing }
GtMemorySpaceEstimation >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: subject.
	self hasRun
		ifTrue: [ aStream
				nextPutAll: ': ';
				nextPutAll: self totalBytes humanReadableIsqByteSize ].
	aStream nextPut: $)
]

{ #category : #running }
GtMemorySpaceEstimation >> run [
	"Walk the roots of the subject with their attributions.
	The results are only set once the walk is complete."

	| anEstimate anEstimator aTime |
	anEstimate := GtMemorySpaceEstimate forCategories: definition categories.
	anEstimator := GtMemorySpaceEstimator new
			boundary: definition newBoundary;
			expectedObjects: (definition expectedObjectsFor: subject);
			yourself.
	[ aTime := [ definition
			rootsOf: subject
			do: [ :aRoot :anAttribution | 
				anAttribution
					estimate: aRoot
					with: anEstimator
					into: anEstimate ] ] timeToRun ]
		ensure: [ anEstimator releaseVisitedObjects ].
	estimator := anEstimator.
	computationTime := aTime.
	estimate := anEstimate
]

{ #category : #accessing }
GtMemorySpaceEstimation >> subject [
	^ subject
]

{ #category : #accessing }
GtMemorySpaceEstimation >> subject: aSubject [
	subject := aSubject
]

{ #category : #accessing }
GtMemorySpaceEstimation >> totalBytes [
	^ estimate totalBytes
]
