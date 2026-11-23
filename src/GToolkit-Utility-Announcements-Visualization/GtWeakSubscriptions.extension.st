Extension { #name : #GtWeakSubscriptions }

{ #category : #'*GToolkit-Utility-Announcements-Visualization' }
GtWeakSubscriptions >> gtAddToAnnouncerGraph: aGraph from: aRegistryNode [
	(aGraph inStableOrder: ephemerons associations) do: 
			[:anEphemeron |
			| anEphemeronNode |
			anEphemeronNode := aGraph ephemeronNodeFor: anEphemeron
						description: 'one per weak subscriber'.
			aGraph strongFrom: aRegistryNode to: anEphemeronNode label: 'weak part'.
			anEphemeron key
				ifNotNil: 
					[:aSubscriber |
					aGraph ephemeronKeyFrom: anEphemeronNode
						to: (aGraph subscriberNodeFor: aSubscriber)].
			aGraph subscriptions: anEphemeron value asArray
				do: 
					[:each |
					aGraph ephemeronValueFrom: anEphemeronNode
						to: (each gtAddToAnnouncerGraph: aGraph)]]
]
