Class {
	#name : #RBAddMethodToClassNamedChange,
	#superclass : #RBAddMethodChange,
	#category : #'GToolkit-Utility-Refactorings-Changes'
}

{ #category : #compiling }
RBAddMethodToClassNamedChange class >> compile: aString inBehaviorNamed: aBehaviorName protocol: aProtocol isMeta: isMeta [
	^ self new
		compile: aString
		inBehaviorNamed: aBehaviorName
		protocol: aProtocol
		isMeta: isMeta
]

{ #category : #compiling }
RBAddMethodToClassNamedChange class >> compile: aString protocol: aProtocol [
	^ self new
		compile: aString
		protocol: aProtocol
		isMeta: false
]

{ #category : #compiling }
RBAddMethodToClassNamedChange class >> compile: aString protocol: aProtocol isMeta: isMeta [
	^ self new
		compile: aString
		protocol: aProtocol
		isMeta: isMeta
]

{ #category : #compiling }
RBAddMethodToClassNamedChange >> behaviorName: aBehaviorName [
	className := aBehaviorName
]

{ #category : #compiling }
RBAddMethodToClassNamedChange >> compile: aString inBehaviorNamed: aBehaviorName protocol: aProtocol isMeta: isMetaClass [
	isMeta := isMetaClass.
	className := aBehaviorName.
	self protocols: aProtocol.
	source := aString.
	controller := nil
]

{ #category : #compiling }
RBAddMethodToClassNamedChange >> compile: aString protocol: aProtocol isMeta: isMetaClass [
	isMeta := isMetaClass.
	self protocols: aProtocol.
	source := aString.
	controller := nil
]

{ #category : #compiling }
RBAddMethodToClassNamedChange >> isMeta: isMetaClass [
	isMeta := isMetaClass
]
