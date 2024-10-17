Class {
	#name : #GtExtensionMethodWrapper,
	#superclass : #Object,
	#instVars : [
		'currentCompiledMethod',
		'previousSourceCode'
	],
	#category : #'GToolkit-Utility-ExtensionMethodsAnalysis'
}

{ #category : #'instance creation' }
GtExtensionMethodWrapper class >> forCompiledMethod: aCompiledMethod [ 
	^ self new 
		currentCompiledMethod: aCompiledMethod
]

{ #category : #accessing }
GtExtensionMethodWrapper >> currentCompiledMethod [
	^ currentCompiledMethod
]

{ #category : #accessing }
GtExtensionMethodWrapper >> currentCompiledMethod: aCompiledMethod [
	currentCompiledMethod := aCompiledMethod
]

{ #category : #'gt - extensions' }
GtExtensionMethodWrapper >> gtSourceCodeFor: aView [
	<gtView>
	
	currentCompiledMethod ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Source';
		priority: 5;
		object: [ currentCompiledMethod ];
		view: #gtSourceCodeFor:
]

{ #category : #'gt - extensions' }
GtExtensionMethodWrapper >> gtViewTwoPanesDiffFor: aView [
	<gtView>
	
	previousSourceCode ifNil: [ ^ aView empty  ].
	
	^ aView explicit
		title: 'Diff ';
		priority: 19;
		stencil: [ 
			GtDiffElementWithLabelStencil new
				fromLabelText: 'Repository:';
				toLabelText: 'Working Copy (local):';
				change: (GtDiffBuilder
					computeDifferencesFrom: previousSourceCode
					to: currentCompiledMethod sourceCode
					using: GtSmaCCDiffSplitter forPharo);
				styler: GtCodeDiffRBTextStyler new ];
		yourself
]

{ #category : #accessing }
GtExtensionMethodWrapper >> methodClass [
	^ currentCompiledMethod methodClass
]

{ #category : #accessing }
GtExtensionMethodWrapper >> package [
	^ currentCompiledMethod package
]

{ #category : #accessing }
GtExtensionMethodWrapper >> previousSourceCode [
	^ previousSourceCode
]

{ #category : #accessing }
GtExtensionMethodWrapper >> previousSourceCode: aStringOrNil [
	previousSourceCode := aStringOrNil
]

{ #category : #printing }
GtExtensionMethodWrapper >> printOn: aStream [
	aStream print: currentCompiledMethod
]

{ #category : #accessing }
GtExtensionMethodWrapper >> selector [
	^ currentCompiledMethod selector
]
