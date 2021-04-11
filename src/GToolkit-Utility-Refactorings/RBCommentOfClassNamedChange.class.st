Class {
	#name : #RBCommentOfClassNamedChange,
	#superclass : #RBCommentChange,
	#category : #'GToolkit-Utility-Refactorings-Changes'
}

{ #category : #'instance creation' }
RBCommentOfClassNamedChange class >> comment: aString inBehaviorNamed: aBehaviorName [
	^ self new
		comment: aString
		inBehaviorNamed: aBehaviorName
]

{ #category : #accessing }
RBCommentOfClassNamedChange >> behaviorName: aBehaviorName [
	className := aBehaviorName
]

{ #category : #initialization }
RBCommentOfClassNamedChange >> comment: aString inBehaviorNamed: aBehaviorName [
	comment := aString.
	isMeta := false.
	className := aBehaviorName
]

{ #category : #accessing }
RBCommentOfClassNamedChange >> isMeta: isMetaClass [
	isMeta := isMetaClass
]
