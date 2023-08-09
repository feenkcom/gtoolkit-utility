Class {
	#name : #GtInheritedMethodsSortFunction,
	#superclass : #SortFunction,
	#category : #'GToolkit-Utility-Basic-Sorting'
}

{ #category : #comparing }
GtInheritedMethodsSortFunction >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'private - comparison' }
GtInheritedMethodsSortFunction >> belongsToClass: aMethodOrName [
	"Return true if a given object that represents a method (compiled method, example or some abstract method definition, or even a selector)
	belongs to any class, false otherwise. This is needed so tht we can compare methods based on the class names too"

	<return: #Boolean>
	
	aMethodOrName ifNil: [ ^ false ].

	^ [ aMethodOrName methodClass notNil ] on: Error do: [ :ex | ex return: false ]
]

{ #category : #'private - comparison' }
GtInheritedMethodsSortFunction >> classNameOf: aMethodOrName [
	<return: #Symbol>
	
	| aMethodClass |
	aMethodClass := aMethodOrName methodClass.

	^ (aMethodClass isString or: [ aMethodClass isSymbol ])
		ifTrue: [ aMethodClass ]
		ifFalse: [ aMethodClass name ]
]

{ #category : #evaluating }
GtInheritedMethodsSortFunction >> collate: anObject1 with: anObject2 [
	"Do a three-way comparison between the anObject1 and anObject2, returning
	-1 if anObject1 < anObject2
	0 if anObject1 = anObject2
	1 if anObject1 > anObject2
	This assumes a total order in accordance with the mathematical law of trichotomy.
	See also:  http://en.wikipedia.org/wiki/Three-way_comparison"

	| classResult |
	classResult := self compareClassOf: anObject1 withClassOf: anObject2.
	^ classResult = 0
		ifTrue: [ self compareMethodNameOf: anObject1 withMethodNameOf: anObject2 ]
		ifFalse: [ classResult ]
]

{ #category : #'private - comparison' }
GtInheritedMethodsSortFunction >> compareClassOf: aMethod1 withClassOf: aMethod2 [
	aMethod1 methodClass == aMethod2 methodClass ifTrue: [^0].
	(aMethod1 methodClass inheritsFrom: aMethod2 methodClass) ifTrue: [^-1].
	(aMethod2 methodClass inheritsFrom: aMethod1 methodClass) ifTrue: [^1].
	^0
]

{ #category : #'private - comparison' }
GtInheritedMethodsSortFunction >> compareMethodNameOf: aMethodOrName1 withMethodNameOf: aMethodOrName2 [
	| methodName1 methodName2 |
	aMethodOrName1 == aMethodOrName2
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
	^methodName1 isBinary = methodName2 isBinary 
		ifTrue: [ methodName1 threeWayCompareTo: methodName2 ]
		ifFalse: [ methodName2 isBinary threeWayCompareTo: methodName1 isBinary ]
]

{ #category : #'private - comparison' }
GtInheritedMethodsSortFunction >> hasMethodNameOf: aMethodOrName [
	<return: #Symbol>
	
	aMethodOrName ifNil: [ ^ false ].

	(aMethodOrName isString
		or: [ aMethodOrName isSymbol or: [ aMethodOrName isText ] ])
		ifTrue: [ ^ true ].

	^ [ aMethodOrName selector notNil ] on: Error do: [ :ex | ex return: false ]
]

{ #category : #comparing }
GtInheritedMethodsSortFunction >> hash [
	^ self class hash
]

{ #category : #'private - comparison' }
GtInheritedMethodsSortFunction >> methodNameOf: aMethodOrName [
	<return: #Symbol>
		
	^ (aMethodOrName isString or: [ aMethodOrName isSymbol ])
		ifTrue: [ aMethodOrName ]
		ifFalse: [ aMethodOrName selector ]
]
