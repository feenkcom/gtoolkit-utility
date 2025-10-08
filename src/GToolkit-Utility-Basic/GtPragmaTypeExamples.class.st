Class {
	#name : #GtPragmaTypeExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Basic-Pragma'
}

{ #category : #'as yet unclassified' }
GtPragmaTypeExamples >> pragmasOfPragmaType [
	<gtExample>
	<aPragmaForTestingPurposes>
	| pragmaType |
	pragmaType := GtPragmaType new keyword: #aPragmaForTestingPurposes.
	self assert: (pragmaType pragmas anySatisfy: [:p | p method = (GtPragmaTypeExamples>>#pragmasOfPragmaType) ]).
	^ pragmaType
]

{ #category : #'as yet unclassified' }
GtPragmaTypeExamples >> usersOfPragmaTypeDoNotIncludeThePragmas [
	<gtExample>
	| pragmaType |
	pragmaType := GtPragmaType new keyword: #aPragmaForTestingPurposes.
	self assert: (pragmaType users noneSatisfy: [:p | p method = (GtPragmaTypeExamples>>#pragmasOfPragmaType) ]).
	self assert: (pragmaType users anySatisfy: [:p | p method = (GtPragmaTypeExamples>>#usersOfPragmaTypeDoNotIncludeThePragmas) ]).
	^ pragmaType
]
