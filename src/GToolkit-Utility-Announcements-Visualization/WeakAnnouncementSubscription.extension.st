Extension { #name : #WeakAnnouncementSubscription }

{ #category : #'*GToolkit-Utility-Announcements-Visualization' }
WeakAnnouncementSubscription >> gtAddToAnnouncerGraph: aGraph [
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
	aGraph globalEntryOf: self
		do: 
			[:anEntry |
			| anEntryNode |
			anEntryNode := aGraph ephemeronNodeFor: anEntry description: 'global entry'.
			aGraph
				strongFrom: aGraph rootNode
				to: anEntryNode
				label: 'entry'.
			anEntry key
				ifNotNil: 
					[:aSubscriber |
					aGraph ephemeronKeyFrom: anEntryNode
						to: (aGraph subscriberNodeFor: aSubscriber)].
			aGraph passiveEphemeronValueFrom: anEntryNode to: aNode].
	^aNode
]
