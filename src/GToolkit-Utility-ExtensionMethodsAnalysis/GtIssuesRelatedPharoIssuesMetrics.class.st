Class {
	#name : #GtIssuesRelatedPharoIssuesMetrics,
	#superclass : #Object,
	#instVars : [
		'relatedIssues'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'GToolkit-Utility-ExtensionMethodsAnalysis'
}

{ #category : #accessing }
GtIssuesRelatedPharoIssuesMetrics class >> cleanUp [
	defaultInstance := nil
]

{ #category : #accessing }
GtIssuesRelatedPharoIssuesMetrics class >> defaultInstance [
	<gtExample>
	
	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : #accessing }
GtIssuesRelatedPharoIssuesMetrics class >> relatedIssues [
	<gtExample>
	<noTest>
	
	^ self defaultInstance relatedIssues
]

{ #category : #accessing }
GtIssuesRelatedPharoIssuesMetrics >> relatedIssues [
	^ relatedIssues ifNil: [
		relatedIssues := GtIssuesRelatedPharoIssuesExtractor currentRelatedIssues  ]
]
