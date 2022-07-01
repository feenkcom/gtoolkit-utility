Class {
	#name : #GtGhEntity,
	#superclass : #Object,
	#instVars : [
		'rawData'
	],
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #accessing }
GtGhEntity >> githubClient [
	^ IceGitHubAPI new
		beAnonymous
]

{ #category : #accessing }
GtGhEntity >> gtRawDataFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Raw data';
		priority: 60;
		items: [ self rawData associations ];
		column: 'Property' text: #key; 
		column: 'Value' text: #value;
		send: [ :each | each value ]
]

{ #category : #accessing }
GtGhEntity >> rawData [
	^ rawData
]

{ #category : #accessing }
GtGhEntity >> rawData: aDictionary [ 
	rawData := aDictionary
]
