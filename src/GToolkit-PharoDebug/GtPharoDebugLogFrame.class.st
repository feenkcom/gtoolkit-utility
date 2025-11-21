Class {
	#name : #GtPharoDebugLogFrame,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : 'GToolkit-PharoDebug-Model'
}

{ #category : #'instance creation' }
GtPharoDebugLogFrame class >> content: aString [
	| trimmed |

	trimmed := aString trimBoth.
	^ trimmed first = $[
		ifTrue: [ GtPharoDebugLogBlockFrame new content: trimmed ]
		ifFalse: [ GtPharoDebugLogMethodFrame new content: trimmed ]
]

{ #category : #accessing }
GtPharoDebugLogFrame >> content [
	^ content
]

{ #category : #accessing }
GtPharoDebugLogFrame >> content: aString [

	content := aString trimBoth
]

{ #category : #ui }
GtPharoDebugLogFrame >> gtSourceCodeFor: aView [
	<gtView>

	self method ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Source';
		priority: 20;
		object: [ self method ];
		view: #gtSourceCodeFor:
]

{ #category : #ui }
GtPharoDebugLogFrame >> gtViewContentFor: aView [
	<gtView>
	
	^ aView text
		title: 'Frame';
		priority: 10;
		text: [ content ]
]

{ #category : #accessing }
GtPharoDebugLogFrame >> method [
	| methodName fields classString selector className class |

	methodName := self methodName.
	fields := '>>' split: methodName.
	selector := fields second asSymbol.
	classString := fields first.
	className := classString readStream upTo: $(.
	class := self class environment classOrTraitNamed: className.
	^ class ifNotNil: [ class lookupSelector: selector ].
]

{ #category : #accessing }
GtPharoDebugLogFrame >> methodName [

	^ self subclassResponsibility
]
