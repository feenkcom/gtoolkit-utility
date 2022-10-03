Extension { #name : #Collection }

{ #category : #'*GToolkit-Utility-Basic' }
Collection >> collect: elementBlock separatedBy: separatorBlock [
	| newCollection |

	newCollection := OrderedCollection new.
	self
		do: [ :each | newCollection add: (elementBlock value: each)]
		separatedBy: [ newCollection add: (separatorBlock value) ].

	^ newCollection as: self species
]

{ #category : #'*GToolkit-Utility-Basic' }
Collection >> gtMaxWithNilValues: aBlock [ 
	| maxValue |
	maxValue := nil .
	self do: [ :anObject | 
		maxValue 
			ifNil: [ maxValue := aBlock value: anObject ]
			ifNotNil: [
				(aBlock value: anObject) ifNotNil: [ :aNewValue |
					aNewValue > maxValue  
						ifTrue: [ maxValue := aNewValue ] ] ] ].
	^ maxValue
]

{ #category : #'*GToolkit-Utility-Basic' }
Collection >> gtMinWithNilValues: aBlock [ 
	| minValue |
	minValue := nil .
	self do: [ :anObject | 
		minValue 
			ifNil: [ minValue := aBlock value: anObject ]
			ifNotNil: [
				(aBlock value: anObject) ifNotNil: [ :aNewValue |
					aNewValue < minValue  
						ifTrue: [ minValue := aNewValue ] ] ] ].
	^ minValue
]

{ #category : #'*GToolkit-Utility-Basic' }
Collection >> gtSumWithNilValues: aBlock [
	"Perform a sum using '+' on the objects of this collection using aBlock. 
	aBlock can return nil, values which are ignored.
	nil is returned for empty collections"
	
	^ self 
		inject: nil "nil indicates there is no value"
		into: [ :sum :anObject |
			sum
				ifNil: [ aBlock value: anObject ] 
				ifNotNil: [
					(aBlock value: anObject) 
						ifNil: [ sum ]
						ifNotNil: [ :aNewValue | sum + aNewValue ] ] ]
]
