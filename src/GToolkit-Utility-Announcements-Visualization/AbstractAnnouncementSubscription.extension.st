Extension { #name : #AbstractAnnouncementSubscription }

{ #category : #'*GToolkit-Utility-Announcements-Visualization' }
AbstractAnnouncementSubscription >> gtAddActionAndAnnouncerToAnnouncerGraph: aGraph from: aNode [
	self action gtAddActionToAnnouncerGraph: aGraph from: aNode.
	aGraph
		backReferenceFrom: aNode
		to: (aGraph announcerNodeFor: announcer)
		label: 'announcer'
]

{ #category : #'*GToolkit-Utility-Announcements-Visualization' }
AbstractAnnouncementSubscription >> gtAddToAnnouncerGraph: aGraph [
	| aNode |
	aNode := aGraph subscriptionNodeFor: self.
	self subscriber
		ifNotNil: 
			[:aSubscriber |
			aGraph
				strongFrom: aNode
				to: (aGraph subscriberNodeFor: aSubscriber)
				label: 'subscriber'].
	self gtAddActionAndAnnouncerToAnnouncerGraph: aGraph from: aNode.
	^aNode
]
