Class {
	#name : #GtMethodsSortFunction,
	#superclass : #SortFunction,
	#category : #'GToolkit-Utility-Basic-Sorting'
}

{ #category : #comparing }
GtMethodsSortFunction >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'private - comparison' }
GtMethodsSortFunction >> belongsToClass: aMethodOrName [
	"Return true if a given object that represents a method (compiled method, example or some abstract method definition, or even a selector)
	belongs to any class, false otherwise. This is needed so tht we can compare methods based on the class names too"
	<return: #Boolean>
	
	aMethodOrName
		ifNil: [ ^ false ].

	^ (aMethodOrName respondsTo: self messageToAskForClass)
		and: [ (aMethodOrName perform: self messageToAskForClass) notNil ]
]

{ #category : #'private - comparison' }
GtMethodsSortFunction >> classNameOf: aMethodOrName [
	<return: #Symbol>
	| aMethodClass |

	self
		assert: [ self belongsToClass: aMethodOrName ]
		description: [ 'Only methods that belong to a class are allowed' ].
		
	aMethodClass := aMethodOrName perform: self messageToAskForClass.
	
	self
		assert: [ aMethodClass notNil ]
		description: [ 'Method class must not be nil here (is had to belong to a class)' ].
		
	^ (aMethodClass isString or: [ aMethodClass isSymbol ])
		ifTrue: [ aMethodClass ]
		ifFalse: [ aMethodClass perform: self messageToAskForClassName ]
]

{ #category : #evaluating }
GtMethodsSortFunction >> collate: anObject1 with: anObject2 [
	"Do a three-way comparison between the anObject1 and anObject2, returning
	-1 if anObject1 < anObject2
	0 if anObject1 = anObject2
	1 if anObject1 > anObject2
	This assumes a total order in accordance with the mathematical law of trichotomy.
	See also:  http://en.wikipedia.org/wiki/Three-way_comparison"
	
	^ (self isMethodOrName: anObject1 fromTheSameClassAs: anObject2)
		ifTrue: [ self compareMethodNameOf: anObject1 withMethodNameOf: anObject2 ]
		ifFalse: [
			"if they are not from the same class we should compare based on the class name"
			self compareClassNameOf: anObject1 withClassNameOf: anObject2 ]
]

{ #category : #'private - comparison' }
GtMethodsSortFunction >> compareClassNameOf: aMethodOrName1 withClassNameOf: aMethodOrName2 [
	| firstMethodBelongsToClass secondMethodBelongsToClass |
	
	firstMethodBelongsToClass := self belongsToClass: aMethodOrName1.
	secondMethodBelongsToClass := self belongsToClass: aMethodOrName2.
	
	self
		assert: [ firstMethodBelongsToClass or: [ secondMethodBelongsToClass ] ]
		description: [ 'At least one method should belong to a class' ].
	
	"class of the same object is the same"
	aMethodOrName1 = aMethodOrName2
		ifTrue: [ ^ 0 ].
	
	"nil object end up at the end of the list"
	aMethodOrName1
		ifNil: [ ^ 1 ].

	aMethodOrName2
		ifNil: [ ^ -1 ].

	"both belong to some class, compare class names"
	(firstMethodBelongsToClass and: [ secondMethodBelongsToClass ])
		ifTrue: [ ^ (self classNameOf: aMethodOrName1) threeWayCompareTo: (self classNameOf: aMethodOrName2) ].
		
	^ (firstMethodBelongsToClass and: [ secondMethodBelongsToClass not ])
		ifTrue: [ -1 ]
		ifFalse: [ 1 ]
]

{ #category : #'private - comparison' }
GtMethodsSortFunction >> compareMethodNameOf: aMethodOrName1 withMethodNameOf: aMethodOrName2 [
	| methodName1 methodName2 |
	aMethodOrName1 = aMethodOrName2
		ifTrue: [ ^ 0 ].
	
	"nil object end up at the end of the list"
	aMethodOrName1
		ifNil: [ ^ 1 ].

	aMethodOrName2
		ifNil: [ ^ -1 ].

	methodName1 := (self hasMethodNameOf: aMethodOrName1)
		ifTrue: [ self methodNameOf: aMethodOrName1 ]
		ifFalse: [ nil ].

	methodName2 := (self hasMethodNameOf: aMethodOrName2)
		ifTrue: [ self methodNameOf: aMethodOrName2 ]
		ifFalse: [ nil ].
	
	methodName1 = methodName2
		ifTrue: [ ^ 0 ].
		
	"nil object end up at the end of the list"
	methodName1
		ifNil: [ ^ 1 ].

	methodName2
		ifNil: [ ^ -1 ].

	"both are not nil here"

	methodName1 := methodName1 asSymbol.
	methodName2 := methodName2 asSymbol.

	"binary methods appear before the rest"
	^ (methodName1 isBinary = methodName2 isBinary)
		ifTrue: [ methodName1 threeWayCompareTo: methodName2 ]
		ifFalse: [ methodName1 isBinary ]
]

{ #category : #'private - comparison' }
GtMethodsSortFunction >> hasMethodNameOf: aMethodOrName [
	<return: #Symbol>

	aMethodOrName
		ifNil: [ ^ false ].
		
	(aMethodOrName isString
		or: [ aMethodOrName isSymbol
			or: [ aMethodOrName isText ] ])
		ifTrue: [ ^ true ].

	^ (aMethodOrName respondsTo: self messageToAskForMethodName)
		and: [ (aMethodOrName perform: self messageToAskForMethodName) notNil ]
]

{ #category : #comparing }
GtMethodsSortFunction >> hash [
	^ self class hash
]

{ #category : #'private - comparison' }
GtMethodsSortFunction >> isMethodOrName: aMethodOrName1 fromTheSameClassAs: aMethodOrName2 [
	| firstMethodBelongsToClass secondMethodBelongsToClass |
	
	firstMethodBelongsToClass := self belongsToClass: aMethodOrName1.
	secondMethodBelongsToClass := self belongsToClass: aMethodOrName2.
	
	"if both do not belong to any class we consider them as if they belong to the same one"
	(firstMethodBelongsToClass not and: [ secondMethodBelongsToClass not ])
		ifTrue: [ ^ true ].
		
	"if just one of the methods belongs to a class, then we consider them from different classes"
	(firstMethodBelongsToClass and: [ secondMethodBelongsToClass not ])
		ifTrue: [ ^ false ].
	
	"if just one of the methods belongs to a class, then we consider them from different classes"
	(firstMethodBelongsToClass not and: [ secondMethodBelongsToClass ])
		ifTrue: [ ^ false ].
		
	"at this point both belong to some class, are they the same classes?"
	^ (self classNameOf: aMethodOrName1) = (self classNameOf: aMethodOrName2)
]

{ #category : #'private - comparison' }
GtMethodsSortFunction >> messageToAskForClass [
	"Return a message that we should use to ask for a class of a method"

	^ #methodClass
]

{ #category : #'private - comparison' }
GtMethodsSortFunction >> messageToAskForClassName [
	"Return a message that we should use to ask for a class name"

	^ #name
]

{ #category : #'private - comparison' }
GtMethodsSortFunction >> messageToAskForMethodName [
	"Return a message that we should use to ask for a method name"

	^ #selector
]

{ #category : #'private - comparison' }
GtMethodsSortFunction >> methodNameOf: aMethodOrName [
	<return: #Symbol>
		
	^ (aMethodOrName isString or: [ aMethodOrName isSymbol ])
		ifTrue: [ aMethodOrName ]
		ifFalse: [ aMethodOrName perform: self messageToAskForMethodName ]
]
