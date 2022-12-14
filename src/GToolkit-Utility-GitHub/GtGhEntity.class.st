"
{{gtClass:name=GtGhEntity}} is the superclass of git entities downloaded from GitHub. 

It manages raw GitHub data for the entity, and provides utility methods for making GitHub API requests.
"
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

{ #category : #requests }
GtGhEntity >> githubGet: anUrlstring [
	"Remove the url host if present, as the API client expects only the path, 
	and urls taken from github data contain the full path."
	
	^ self githubClient
		get: (anUrlstring withoutPrefix: 'https://api.github.com/')
]

{ #category : #'gt - extensions' }
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
