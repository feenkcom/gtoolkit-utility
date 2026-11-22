Extension { #name : #GtEphemeronAnnouncementSubscription }

{ #category : #'*GToolkit-Utility-Announcements-Visualization' }
GtEphemeronAnnouncementSubscription >> gtAddToAnnouncerGraph: aGraph [
	| aNode |
	aNode := aGraph subscriptionNodeFor: self.
	self subscriber
		ifNotNil: 
			[:aSubscriber |
			aGraph
				weakFrom: aNode
				to: (aGraph subscriberNodeFor: aSubscriber)
				label: 'subscriber'].
	self gtAddActionAndAnnouncerToAnnouncerGraph: aGraph from: aNode.
	^aNode
]
