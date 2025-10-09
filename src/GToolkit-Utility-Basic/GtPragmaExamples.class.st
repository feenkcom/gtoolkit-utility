Class {
	#name : #GtPragmaExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Basic-Pragma'
}

{ #category : #'as yet unclassified' }
GtPragmaExamples >> allNamedFromToExcluding [
	<gtExample>
	| pragmas |
	pragmas := Pragma
			allNamed: #gtView
			from: GtPragmaExamples
			toButExcluding: ProtoObject.
	self assert: pragmas notEmpty.
	pragmas := Pragma
			allNamed: #gtView
			from: GtPragmaExamples
			toButExcluding: Object.
	self assert: pragmas isEmpty.
]
