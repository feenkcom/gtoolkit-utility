Extension { #name : #FastSubscriptionRegistry }

{ #category : #'*GToolkit-Utility-Announcements-Visualization' }
FastSubscriptionRegistry >> gtAddToAnnouncerGraph: aGraph [
	^aGraph registryNodeFor: self subscriptionCount: self numberOfSubscriptions
]
