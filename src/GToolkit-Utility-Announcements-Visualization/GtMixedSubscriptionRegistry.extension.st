Extension { #name : #GtMixedSubscriptionRegistry }

{ #category : #'*GToolkit-Utility-Announcements-Visualization' }
GtMixedSubscriptionRegistry >> gtAddToAnnouncerGraph: aGraph [
	^self protected: 
			[| aNode |
			aNode := aGraph registryNodeFor: self
						subscriptionCount: self numberOfSubscriptions.
			aGraph subscriptions: strongSubscriptions asArray
				do: 
					[:each |
					aGraph
						strongFrom: aNode
						to: (each gtAddToAnnouncerGraph: aGraph)
						label: 'strong part'].
			self weakPart gtAddToAnnouncerGraph: aGraph from: aNode.
			aNode]
]
