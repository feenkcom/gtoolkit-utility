Class {
	#name : #GtLevenshteinExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Algorithms-EditDistance - Examples'
}

{ #category : #examples }
GtLevenshteinExamples >> caseSensitive [
	<gtExample>
	<return: #SmallInteger>
	| distance |
	distance := GtLevenshtein distanceBetween: 'foobar' and: 'FOOBAR'.
	self assert: distance equals: 6.
	^ distance
]

{ #category : #examples }
GtLevenshteinExamples >> emptyStrings [
	<gtExample>
	<return: #SmallInteger>
	| distance |
	distance := GtLevenshtein distanceBetween: '' and: ''.
	self assert: distance equals: 0.
	^ distance
]

{ #category : #examples }
GtLevenshteinExamples >> insertion [
	<gtExample>
	<return: #SmallInteger>
	| distance |
	distance := GtLevenshtein distanceBetween: 'foobar' and: 'fooREbar'.
	self assert: distance equals: 2.
	^ distance
]

{ #category : #examples }
GtLevenshteinExamples >> noPermutation [
	<gtExample>
	<return: #SmallInteger>
	| distance |
	distance := GtLevenshtein distanceBetween: 'AB' and: 'BA'.
	self assert: distance equals: 2.
	^ distance
]

{ #category : #examples }
GtLevenshteinExamples >> oneReplace [
	<gtExample>
	<return: #SmallInteger>
	| distance |
	distance := GtLevenshtein distanceBetween: 'foobar' and: 'foobaz'.
	self assert: distance equals: 1.
	^ distance
]

{ #category : #examples }
GtLevenshteinExamples >> removeAll [
	<gtExample>
	<return: #SmallInteger>
	| distance |
	distance := GtLevenshtein distanceBetween: 'foobar' and: ''.
	self assert: distance equals: 6.
	^ distance
]

{ #category : #examples }
GtLevenshteinExamples >> unicode [
	<gtExample>
	<return: #SmallInteger>
	| distance |
	distance := GtLevenshtein distanceBetween: 'foobàr' and: 'foobár'.
	self assert: distance equals: 1.
	^ distance
]
