Class {
	#name : #GtTaskerValuableTask,
	#superclass : #GtTaskerTask,
	#instVars : [
		'valuable'
	],
	#category : #'GToolkit-Utility-Tasker-GToolkit-Utility-Tasker'
}

{ #category : #comparing }
GtTaskerValuableTask >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ valuable = anObject valuable
]

{ #category : #execution }
GtTaskerValuableTask >> execute [
	self valuable value
]

{ #category : #'gt-extension' }
GtTaskerValuableTask >> gtValuableFor: aView [
	<gtView>
	(self valuable isKindOf: BlockClosure) ifFalse: [ ^ aView empty ].
	^ self valuable gtSourceCodeFor: aView
]

{ #category : #comparing }
GtTaskerValuableTask >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ valuable hash
]

{ #category : #initialization }
GtTaskerValuableTask >> initialize [
	super initialize.
	valuable := [ "do nothing" ].
]

{ #category : #printing }
GtTaskerValuableTask >> printOn: aStream [
	aStream
		nextPutAll: 'Valuable task: ';
		print: valuable
]

{ #category : #accessing }
GtTaskerValuableTask >> valuable [
	^ valuable
]

{ #category : #accessing }
GtTaskerValuableTask >> valuable: aValuable [
	self 
		assert: [ aValuable isNotNil ] 
		description: [ 'Task valuable must be non-nil' ].
	valuable := aValuable
]
