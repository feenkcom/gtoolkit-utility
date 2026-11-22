Extension { #name : #Announcer }

{ #category : #'*GToolkit-Utility-Announcements-Visualization' }
Announcer >> gtAddToAnnouncerGraph: aGraph [
	| aNode |
	aNode := aGraph announcerNodeFor: self.
	aGraph
		strongFrom: aNode
		to: (registry gtAddToAnnouncerGraph: aGraph)
		label: 'registry'.
	^aNode
]
