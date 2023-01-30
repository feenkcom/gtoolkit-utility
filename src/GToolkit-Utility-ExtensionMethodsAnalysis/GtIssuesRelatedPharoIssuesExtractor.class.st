"
{{gtClass:GtIssuesRelatedPharoIssuesExtractor}} extracts the list of Pharo issues mentioned in the GT Book that are related to GT.
"
Class {
	#name : #GtIssuesRelatedPharoIssuesExtractor,
	#superclass : #Object,
	#category : #'GToolkit-Utility-ExtensionMethodsAnalysis'
}

{ #category : #accessing }
GtIssuesRelatedPharoIssuesExtractor class >> currentLinkUrls [
	<gtExample>
	
	^ self new linkUrls
]

{ #category : #accessing }
GtIssuesRelatedPharoIssuesExtractor class >> currentRelatedIssues [
	<gtExample>
	<noTest>
	
	^ self new relatedIssues
]

{ #category : #accessing }
GtIssuesRelatedPharoIssuesExtractor >> issuesData [ 
	^ (self linkUrls collect: [ :aUrlString |
		| znUrl|
		znUrl := aUrlString asZnUrl.
		IceGitHubAPI new 
			getIssue: znUrl segments first
			project: znUrl segments second
			number: znUrl segments fourth ] )
]

{ #category : #accessing }
GtIssuesRelatedPharoIssuesExtractor >> linkNodes [ 
	^ self snippetsWithLinks collect: [ :aSnippet |
		(aSnippet ast / #LeExternalLabelUrlLinkNode) anyOne  ]
]

{ #category : #accessing }
GtIssuesRelatedPharoIssuesExtractor >> linkUrls [ 
	^ self linkNodes collect: [ :aLinkNode | aLinkNode url ]
]

{ #category : #accessing }
GtIssuesRelatedPharoIssuesExtractor >> relatedIssues [ 
	^ GtGhIssuesGroup withAll: (self issuesData 
		collect: [ :anIssueData |
			GtGhIssue new 
			rawData: anIssueData ])
]

{ #category : #accessing }
GtIssuesRelatedPharoIssuesExtractor >> snippetsWithLinks [ 
	^ self targetPage allChildrenBreadthFirst 
		select: [ :aSnippet | 
			aSnippet string includesSubstring:  'https://github.com/pharo-project/' ]
]

{ #category : #accessing }
GtIssuesRelatedPharoIssuesExtractor >> targetPage [ 
	^ LeDatabasesRegistry defaultLogicalDatabase 
		pageNamed: 'Patches/changes to the base Pharo Image'
]
