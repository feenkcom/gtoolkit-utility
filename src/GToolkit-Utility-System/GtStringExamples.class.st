Class {
	#name : #GtStringExamples,
	#superclass : #Object,
	#category : 'GToolkit-Utility-System-Examples'
}

{ #category : #accessing }
GtStringExamples >> removeEmptyLinesFromEmptyString [
	<gtExample>
	<return: #GtStringExamples>
	| string |
	string := ''.
	self assert: string gtRemoveEmptyLines isEmpty
]

{ #category : #accessing }
GtStringExamples >> removeEmptyLinesFromStringWithEmptyLineAtTheBeginning [
	<gtExample>
	<return: #GtStringExamples>
	| string |
	string := String cr , String cr , 'a' , String cr , 'b'.
	self assert: string gtRemoveEmptyLines = ('a' , String cr , 'b')
]

{ #category : #accessing }
GtStringExamples >> removeEmptyLinesFromStringWithEmptyLineAtTheEnd [
	<gtExample>
	<return: #GtStringExamples>
	| string |
	string := 'a' , String cr , 'b' , String cr , String cr.
	self assert: string gtRemoveEmptyLines = ('a' , String cr , 'b')
]

{ #category : #accessing }
GtStringExamples >> removeEmptyLinesFromStringWithEmptyLineInTheMiddle [
	<gtExample>
	<return: #GtStringExamples>
	| string |
	string := 'a' , String cr , String cr , 'b'.
	self assert: string gtRemoveEmptyLines = ('a' , String cr , 'b')
]

{ #category : #accessing }
GtStringExamples >> removeEmptyLinesFromStringWithEmptyLines [
	<gtExample>
	<return: #GtStringExamples>
	| string |
	string := 'a' , String cr , String space , String cr , 'b'.
	self assert: string gtRemoveEmptyLines = string
]

{ #category : #accessing }
GtStringExamples >> removeEmptyLinesFromStringWithMultipleEmptyLines [
	<gtExample>
	<return: #GtStringExamples>
	| string |
	string := 'a' , String cr , String cr , String cr , String cr , 'b'.
	self assert: string gtRemoveEmptyLines = ('a' , String cr , 'b')
]
