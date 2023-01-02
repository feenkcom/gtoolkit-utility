Class {
	#name : #GtDeprecatedClassWrapper,
	#superclass : #Object,
	#instVars : [
		'targetClass',
		'references',
		'deprecatedTimestamp'
	],
	#category : #'GToolkit-Utility-Deprecation'
}

{ #category : #'instance creation' }
GtDeprecatedClassWrapper class >> forClass: aClass [ 
	^ self new 
		targetClass: aClass
]

{ #category : #accessing }
GtDeprecatedClassWrapper >> computeDeprecatedTimestamp [
	
	^ [ 
		| icebergRepository methodLog deprecationMethod |
		icebergRepository := IceRepository
			registeredRepositoryIncludingPackage: self targetClass package.
		methodLog := IceLibgitTonelLog for: icebergRepository.
		deprecationMethod := self deprecationMethod.
		deprecationMethod ifNotNil: [ 
			(methodLog historyOfMethod: deprecationMethod) first datetime ] 
	] onErrorDo: [ :ex | nil ]
]

{ #category : #accessing }
GtDeprecatedClassWrapper >> deprecatedTimestamp [
	^ deprecatedTimestamp
]

{ #category : #accessing }
GtDeprecatedClassWrapper >> deprecationMethod [
	^ self targetClass classSide
		classAndMethodFor: #isDeprecated
		do: [ :c :m | m ]
		ifAbsent: [ nil ].
]

{ #category : #'gt - extensions' }
GtDeprecatedClassWrapper >> gtViewReferencesFor: aView [ 
	<gtView>
	
	self targetClass ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'References';
		object: [ self targetClass ];
		view: #gtAllReferencesFor:
]

{ #category : #testing }
GtDeprecatedClassWrapper >> isReferenced [
	^ self targetClassReferences notEmpty
]

{ #category : #accessing }
GtDeprecatedClassWrapper >> numberOfReferences [
	^ self targetClassReferences size
]

{ #category : #printing }
GtDeprecatedClassWrapper >> printOn: aStream [ 
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream << self targetClass name ]
]

{ #category : #accessing }
GtDeprecatedClassWrapper >> targetClass [
	^ targetClass
]

{ #category : #accessing }
GtDeprecatedClassWrapper >> targetClass: aDeprecatedClass [
	self assert: [ aDeprecatedClass  isDeprecated ].
	
	targetClass := aDeprecatedClass
]

{ #category : #accessing }
GtDeprecatedClassWrapper >> targetClassReferences [	
	^ references ifNil: [
		references :=  self targetClass gtReferences contents ]
]

{ #category : #accessing }
GtDeprecatedClassWrapper >> updateDeprecatedTimestamp [
	deprecatedTimestamp := self computeDeprecatedTimestamp
]
