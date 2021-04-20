Class {
	#name : #GtRobocoderTemplateTranslatorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateArrayCollectAsStrings [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '{{array collect: [ :eachChar | eachChar asString ]}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #array to: #($A $l $e $x).
		
	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'Alex'.
	
	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateArrayCollectEmptyStrings [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '{{array collect: [ :eachChar | '''' ]}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #array to: #($A $l $e $x).

	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: ''.

	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateArrayCollectWithEmbeddedStrings [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '{{array collect: [ :eachChar | ''eachChar'' ]}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #array to: #($A $l $e $x).
		
	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'eachChareachChareachChareachChar'.
	
	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateArrayCollectWithTemplateEmbeddedInStrings [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '{{array collect: [ :eachChar | ''{{eachChar}}'' ]}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #array to: #($A $l $e $x).

	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'Alex'.

	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateArrayCollectWithTemplateEmbeddedInStringsConcactenate [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '{{array collect: [ :eachChar | ''{{eachChar}}'', ''{{eachChar}}'' ]}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #array to: #($A $l $e $x).

	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'AAlleexx'.

	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateArrayCollectWithTemplateEmbeddedInStringsTwice [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '{{array collect: [ :eachChar | ''{{eachChar}}-{{eachChar}}'' ]}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #array to: #($A $l $e $x).

	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'A-Al-le-ex-x'.

	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateArrayOfChars [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '{{array}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #array to: #($A $l $e $x).
		
	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'Alex'.
	
	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateArrayOfCharsAsUppercase [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '{{array collect: #asUppercase}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #array to: #($A $l $e $x).
		
	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'ALEX'.
	
	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateDoubleNestedTemplate [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '{{{{name}}}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #name to: 'someone';
		map: #someone to: 'Alex'.
		
	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'Alex'.
	
	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateSimpleTemplate [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '{{name}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #name to: 'Alex'.

	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'Alex'.

	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateSimpleTemplateWithText [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := 'My name is {{name}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #name to: 'Alex'.
		
	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'My name is Alex'.
	
	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateTemplateInDoubleEmbeddedString [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '''{{''{{name}}''}}'''.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #name to: 'Alex'.
		
	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: '''Alex'''.
	
	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateTemplateInDoubleEmbeddedStringWithText [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '''{{''My name is {{name}}''}}'''.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #name to: 'Alex'.
		
	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: '''My name is Alex'''.
	
	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateTemplateInEmbeddedString [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '{{''{{name}}''}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #name to: 'Alex'.
		
	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'Alex'.
	
	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateTemplateInEmbeddedStringWithText [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := 'My {{''name is {{name}}''}}'.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #name to: 'Alex'.
		
	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'My name is Alex'.
	
	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateTemplateInString [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := '''{{name}}'''.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #name to: 'Alex'.
		
	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: '''Alex'''.

	^ aResult
]

{ #category : #examples }
GtRobocoderTemplateTranslatorExamples >> translateTemplateInStringWithText [
	<gtExample>
	| aTemplate aTranslator aResult |
	
	aTemplate := 'My name ''is {{name}}'''.
	aTranslator := GtRobocoderTemplateTranslator new
		map: #name to: 'Alex'.
		
	aResult := aTranslator translate: aTemplate.
	self assert: aResult equals: 'My name ''is Alex'''.

	^ aResult
]
