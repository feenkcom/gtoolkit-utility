"
I exemplify {{gtClass:GtResourcesUtilityPathExtractor}}.


"
Class {
	#name : #GtResourcesUtilityPathExtractorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources-Examples'
}

{ #category : #'examples - basic' }
GtResourcesUtilityPathExtractorExamples >> basicExtractor [
	<gtExample>
	^ GtResourcesUtilityPathExtractor new
]

{ #category : #'examples - valid paths' }
GtResourcesUtilityPathExtractorExamples >> permitedLongPath [
	<gtExample>
	| aString anExtranctor aPath |
	aString := self permitedLongPathString.
	anExtranctor := self basicExtractor.
	self assert: (anExtranctor canEvaluate: aString).
	aPath := anExtranctor pathFrom: aString.
	self assert: aPath class equals: RelativePath.
	^ aPath
]

{ #category : #'examples - valid paths' }
GtResourcesUtilityPathExtractorExamples >> permitedLongPathString [
	<gtExample>
	^ 'Path * ''feenkcom'' / ''gtoolkit-inspector'' / ''doc'' / ''gt.png'''
]

{ #category : #'examples - valid paths' }
GtResourcesUtilityPathExtractorExamples >> permitedShortPath [
	<gtExample>
	| aString anExtranctor aPath |
	aString := 'Path * '''''.
	anExtranctor := self basicExtractor.
	self assert: (anExtranctor canEvaluate: aString).
	aPath := anExtranctor pathFrom: aString.
	self assert: aPath class equals: RelativePath.
	^ aPath
]

{ #category : #'examples - invalid code' }
GtResourcesUtilityPathExtractorExamples >> unwantedBinarySender [
	<gtExample>
	| aString anExtranctor aPath |
	aString := 'Path * ''feenkcom'' / ''gtoolkit-inspector'' / ''doc'' // ''gt.png'''.
	anExtranctor := self basicExtractor.
	self assert: (anExtranctor canEvaluate: aString) not.
	aPath := anExtranctor pathFrom: aString.
	self assert: aPath isNil.
	^ aString
]

{ #category : #'examples - invalid code' }
GtResourcesUtilityPathExtractorExamples >> unwantedGlobal [
	<gtExample>
	| aString anExtranctor aPath |
	aString := 'Path * ''feenkcom'' / Object / ''doc'' / ''gt.png'''.
	anExtranctor := self basicExtractor.
	self assert: (anExtranctor canEvaluate: aString) not.
	aPath := anExtranctor pathFrom: aString.
	self assert: aPath isNil.
	^ aString
]

{ #category : #'examples - invalid code' }
GtResourcesUtilityPathExtractorExamples >> unwantedLiteralNumber [
	<gtExample>
	| aString anExtranctor aPath |
	aString := 'Path * ''feenkcom'' / ''gtoolkit-inspector'' / ''doc'' / 42'.
	anExtranctor := self basicExtractor.
	self assert: (anExtranctor canEvaluate: aString) not.
	aPath := anExtranctor pathFrom: aString.
	self assert: aPath isNil.
	^ aString
]

{ #category : #'examples - invalid code' }
GtResourcesUtilityPathExtractorExamples >> unwantedMessage [
	<gtExample>
	| aString anExtranctor aPath |
	aString := 'Path with: ''feenkcom'''.
	anExtranctor := self basicExtractor.
	self assert: (anExtranctor canEvaluate: aString) not.
	aPath := anExtranctor pathFrom: aString.
	self assert: aPath isNil.
	^ aString
]

{ #category : #'examples - invalid code' }
GtResourcesUtilityPathExtractorExamples >> unwantedUnarySender [
	<gtExample>
	| aString anExtranctor aPath |
	aString := 'Path * ''feenkcom'' new / ''gtoolkit-inspector'' / ''doc'' / ''gt.png'''.
	anExtranctor := self basicExtractor.
	self assert: (anExtranctor canEvaluate: aString) not.
	aPath := anExtranctor pathFrom: aString.
	self assert: aPath isNil.
	^ aString
]

{ #category : #'examples - invalid code' }
GtResourcesUtilityPathExtractorExamples >> unwantedUnarySender2 [
	<gtExample>
	| aString anExtranctor aPath |
	aString := self unwantedUnarySender2String.
	anExtranctor := self basicExtractor.
	self assert: (anExtranctor canEvaluate: aString) not.
	aPath := anExtranctor pathFrom: aString.
	self assert: aPath isNil.
	^ aString
]

{ #category : #'examples - invalid code' }
GtResourcesUtilityPathExtractorExamples >> unwantedUnarySender2String [
	<gtExample>
	^ '(Path * ''feenkcom'') asFileReference'
]
