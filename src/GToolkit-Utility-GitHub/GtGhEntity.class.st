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
]

{ #category : #accessing }
GtGhEntity >> githubGet: anUrlstring [
	^ self githubClient
		get: (anUrlstring removePrefix: 'https://api.github.com/')
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
