Extension { #name : #SubscriptionRegistry }

{ #category : #'*GToolkit-Utility-Announcements-Visualization' }
SubscriptionRegistry >> gtAddToAnnouncerGraph: aGraph [
	| aNode theSubscriptions |
	theSubscriptions := self protected: [subscriptions asArray].
	aNode := aGraph registryNodeFor: self
				subscriptionCount: theSubscriptions size.
	aGraph subscriptions: theSubscriptions
		do: 
			[:each |
			aGraph
				strongFrom: aNode
				to: (each gtAddToAnnouncerGraph: aGraph)
				label: 'subscription'].
	^aNode
]
