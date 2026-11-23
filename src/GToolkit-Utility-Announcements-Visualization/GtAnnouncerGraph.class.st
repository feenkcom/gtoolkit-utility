"
I am a graph of the objects behind an announcer: its subscription registry, the subscriptions, their subscribers, actions and the objects their blocks capture, the ephemerons of a mixed registry and the entries of the global FinalizationRegistry that point to weak subscriptions. I mark each reference as strong, weak, ephemeron key or ephemeron value. I highlight the shortest chains through which the global FinalizationRegistry keeps the subscribers and the announcer alive while another weak subscriber lives: I assume every weak subscriber is alive, and to reach an object I follow the value of an ephemeron only when its key is a different object. I look up only the global entries of the announcer's weak subscriptions and keep no others. Create me with {{gtMethod:GtAnnouncerGraph class>>forAnnouncer:}}. {{gtMethod:GtAnnouncerGraphScenario>>gtSubscriptionGraphFor:}} shows me with a toggle that hides the back references. Besides the graph, my views list the chains that keep objects alive ({{gtMethod:GtAnnouncerGraph>>gtWhyAliveFor:}}), every object with a view of it in context ({{gtMethod:GtAnnouncerGraph>>gtObjectsFor:}}), and a legend ({{gtMethod:GtAnnouncerGraph>>gtLegendFor:}}).
"
Class {
	#name : #GtAnnouncerGraph,
	#superclass : #Object,
	#instVars : [
		'nodesByObject',
		'nodes',
		'edges',
		'globalEntriesByValue',
		'shownSubscriptions',
		'chains'
	],
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #'instance creation' }
GtAnnouncerGraph class >> forAnnouncer: anAnnouncer [
	^(self new)
		addAnnouncer: anAnnouncer;
		highlightWhatTheGlobalRegistryKeepsAlive;
		yourself
]

{ #category : #building }
GtAnnouncerGraph >> addAnnouncer: anAnnouncer [
	globalEntriesByValue := self
				globalEntriesOf: anAnnouncer subscriptions allWeakSubscriptions.
	anAnnouncer gtAddToAnnouncerGraph: self
]

{ #category : #building }
GtAnnouncerGraph >> announcerNodeFor: anAnnouncer [
	^self
		nodeFor: anAnnouncer
		role: GtAnnouncerGraphAnnouncerRole new
		description: (self describe: anAnnouncer)
]

{ #category : #building }
GtAnnouncerGraph >> backReferenceFrom: aSourceNode to: aTargetNode label: aString [
	edges
		add: (GtAnnouncerGraphEdge
				from: aSourceNode
				to: aTargetNode
				kind: GtAnnouncerGraphStrongReference new
				label: aString) beBackReference
]

{ #category : #building }
GtAnnouncerGraph >> blockNodeFor: aBlock [
	^self
		nodeFor: aBlock
		role: GtAnnouncerGraphBlockRole new
		description: 'block action'
]

{ #category : #building }
GtAnnouncerGraph >> capturedNodeFor: anObject [
	^self
		nodeFor: anObject
		role: GtAnnouncerGraphCapturedRole new
		description: (self describe: anObject)
]

{ #category : #highlighting }
GtAnnouncerGraph >> chainTo: aNode ifFound: aBlock [
	| theParentEdges theEdges anEdge |
	theParentEdges := self parentEdgesTowards: aNode.
	(theParentEdges includesKey: aNode) ifFalse: [^self].
	theEdges := OrderedCollection new.
	anEdge := theParentEdges at: aNode.
	[anEdge notNil] whileTrue: 
			[theEdges addFirst: anEdge.
			anEdge := theParentEdges at: anEdge source].
	aBlock value: (GtAnnouncerGraphChain
				graph: self
				target: aNode
				edges: theEdges asArray)
]

{ #category : #accessing }
GtAnnouncerGraph >> chains [
	^chains
]

{ #category : #accessing }
GtAnnouncerGraph >> chainsTo: aNode [
	^chains select: [:each | each target == aNode]
]

{ #category : #accessing }
GtAnnouncerGraph >> contextOf: aNode [
	^GtAnnouncerGraphNodeContext graph: self node: aNode
]

{ #category : #building }
GtAnnouncerGraph >> describe: anObject [
	^anObject printStringLimitedTo: 40
]

{ #category : #accessing }
GtAnnouncerGraph >> edges [
	^edges
]

{ #category : #accessing }
GtAnnouncerGraph >> edgesInto: aNode [
	^edges select: [:each | each target == aNode]
]

{ #category : #accessing }
GtAnnouncerGraph >> edgesOf: aNode [
	^edges select: [:each | each source == aNode or: [each target == aNode]]
]

{ #category : #building }
GtAnnouncerGraph >> ephemeronKeyFrom: anEphemeronNode to: aKeyNode [
	edges
		add: (GtAnnouncerGraphEdge
				from: anEphemeronNode
				to: aKeyNode
				kind: GtAnnouncerGraphEphemeronKeyReference new
				label: 'key') bePassive
]

{ #category : #building }
GtAnnouncerGraph >> ephemeronNodeFor: anEphemeron description: aString [
	^self
		nodeFor: anEphemeron
		role: GtAnnouncerGraphEphemeronRole new
		description: aString
]

{ #category : #building }
GtAnnouncerGraph >> ephemeronValueFrom: anEphemeronNode to: aValueNode [
	edges add: (GtAnnouncerGraphEdge
				from: anEphemeronNode
				to: aValueNode
				kind: GtAnnouncerGraphEphemeronValueReference new
				label: 'value')
]

{ #category : #private }
GtAnnouncerGraph >> globalEntriesOf: aCollection [
	| theSubscriptions theEntries |
	theEntries := IdentityDictionary new.
	aCollection ifEmpty: [^theEntries].
	theSubscriptions := IdentitySet withAll: aCollection.
	FinalizationRegistry default gtCurrentEphemerons do: 
			[:anEntry |
			(theSubscriptions includes: anEntry value)
				ifTrue: [theEntries at: anEntry value put: anEntry]].
	^theEntries
]

{ #category : #building }
GtAnnouncerGraph >> globalEntryOf: aSubscription do: aBlock [
	(globalEntriesByValue at: aSubscription ifAbsent: [^self]) in: aBlock
]

{ #category : #views }
GtAnnouncerGraph >> gtEdgesFor: aView [
	<gtView>
	^(aView columnedList)
		title: 'References';
		priority: 2;
		items: [edges];
		column: 'From' text: [:each | each source];
		column: 'Reference' text: [:each | each printString];
		column: 'Kept alive by the global registry'
			text: [:each | each isHighlighted ifTrue: ['yes'] ifFalse: ['']]
]

{ #category : #views }
GtAnnouncerGraph >> gtGraphFor: aView [
	<gtView>
	^(aView mondrian)
		title: 'Graph';
		priority: 1;
		painting: [:aMondrian | self paintWith: aMondrian];
		send: [:each | each objectToInspect]
]

{ #category : #views }
GtAnnouncerGraph >> gtLegendFor: aView [
	<gtView>
	^(aView explicit)
		title: 'Legend';
		priority: 5;
		stencil: [GtAnnouncerGraphLegend new element]
]

{ #category : #views }
GtAnnouncerGraph >> gtObjectsFor: aView [
	<gtView>
	^(aView columnedList)
		title: 'Objects';
		priority: 4;
		items: [nodes];
		column: 'Object' text: [:each | each printString];
		column: 'Role'
			text: [:each | each roleTitle]
			width: 120;
		column: 'Kept alive by the global registry'
			text: [:each | (self chainsTo: each) isEmpty ifTrue: [''] ifFalse: ['yes']]
			width: 200;
		send: [:each | self contextOf: each]
]

{ #category : #views }
GtAnnouncerGraph >> gtWhyAliveFor: aView [
	<gtView>
	^(aView columnedTree)
		title: 'Why alive';
		priority: 3;
		items: [chains];
		children: [:each | each whyAliveSteps];
		expandUpTo: 1;
		column: 'Kept alive, and through which references'
			text: [:each | each whyAliveDescription];
		column: 'Reference' text: [:each | each whyAliveReference];
		send: [:each | each]
]

{ #category : #highlighting }
GtAnnouncerGraph >> highlightWhatTheGlobalRegistryKeepsAlive [
	nodes do: 
			[:each |
			(each isSubscriber or: [each isAnnouncer])
				ifTrue: [self chainTo: each ifFound: [:aChain | chains add: aChain]]].
	chains do: [:each | each highlight]
]

{ #category : #accessing }
GtAnnouncerGraph >> highlightedEdges [
	^edges select: [:each | each isHighlighted]
]

{ #category : #building }
GtAnnouncerGraph >> inStableOrder: aCollection [
	^aCollection asArray
		sorted: [:first :second | first identityHash <= second identityHash]
]

{ #category : #initialization }
GtAnnouncerGraph >> initialize [
	super initialize.
	nodesByObject := IdentityDictionary new.
	nodes := OrderedCollection new.
	edges := OrderedCollection new.
	globalEntriesByValue := IdentityDictionary new.
	shownSubscriptions := 0.
	chains := OrderedCollection new
]

{ #category : #testing }
GtAnnouncerGraph >> isKeptAliveByTheGlobalRegistry: anObject [
	^(self edgesInto: (self nodeOf: anObject))
		contains: [:each | each isHighlighted]
]

{ #category : #accessing }
GtAnnouncerGraph >> keptAliveDescription [
	| theKeptNodes |
	theKeptNodes := nodes select: 
					[:each |
					(each isSubscriber or: [each isAnnouncer])
						and: [(self edgesInto: each) contains: [:anEdge | anEdge isHighlighted]]].
	^theKeptNodes isEmpty
		ifTrue: ['nothing']
		ifFalse: 
			[String streamContents: 
					[:aStream |
					theKeptNodes do: [:each | aStream nextPutAll: each description]
						separatedBy: [aStream nextPutAll: ', ']]]
]

{ #category : #accessing }
GtAnnouncerGraph >> keyNodesOf: anEphemeronNode [
	^(edges
		select: [:each | each source == anEphemeronNode and: [each isEphemeronKey]])
			collect: [:each | each target]
]

{ #category : #accessing }
GtAnnouncerGraph >> maximumSubscriptions [
	^40
]

{ #category : #building }
GtAnnouncerGraph >> nodeFor: anObject role: aRole description: aString [
	^nodesByObject
		at: anObject
		ifPresent: 
			[:aNode |
			aNode joinRole: aRole.
			aNode]
		ifAbsent: 
			[| aNode |
			aNode := GtAnnouncerGraphNode
						object: anObject
						role: aRole
						description: aString.
			nodesByObject at: anObject put: aNode.
			nodes add: aNode.
			aNode]
]

{ #category : #accessing }
GtAnnouncerGraph >> nodeOf: anObject [
	^nodesByObject at: anObject
]

{ #category : #accessing }
GtAnnouncerGraph >> nodes [
	^nodes
]

{ #category : #painting }
GtAnnouncerGraph >> paintWith: aMondrian [
	self paintWith: aMondrian edges: edges
]

{ #category : #painting }
GtAnnouncerGraph >> paintWith: aMondrian edges: aCollection [
	self paintWith: aMondrian nodes: nodes edges: aCollection
]

{ #category : #painting }
GtAnnouncerGraph >> paintWith: aMondrian nodes: aNodeCollection edges: anEdgeCollection [
	(aMondrian nodes)
		stencil: [:aNode | aNode element];
		with: aNodeCollection.
	(aMondrian edges)
		fromRightCenter;
		toLeftCenter;
		stencil: [:anEdge | anEdge lineElement];
		connect: (anEdgeCollection reject: [:each | each isPassive])
			from: [:anEdge | anEdge source]
			to: [:anEdge | anEdge target].
	(aMondrian edges)
		passive;
		stencil: [:anEdge | anEdge lineElement];
		connect: (anEdgeCollection select: [:each | each isPassive])
			from: [:anEdge | anEdge source]
			to: [:anEdge | anEdge target].
	(aMondrian layout horizontalTree)
		levelDistance: 80;
		nodeDistance: 45
]

{ #category : #painting }
GtAnnouncerGraph >> paintWithoutBackReferencesWith: aMondrian [
	self paintWith: aMondrian
		edges: (edges
				reject: [:each | each isBackReference and: [each isHighlighted not]])
]

{ #category : #highlighting }
GtAnnouncerGraph >> parentEdgesTowards: aTargetNode [
	| theParentEdges theQueue |
	theParentEdges := IdentityDictionary new.
	theQueue := OrderedCollection
				withAll: (nodes select: [:each | each isRoot]).
	theQueue do: [:each | theParentEdges at: each put: nil].
	[theQueue notEmpty] whileTrue: 
			[| aNode |
			aNode := theQueue removeFirst.
			(edges select: 
					[:each |
					each source == aNode and: [each isFollowedTowards: aTargetNode in: self]])
				do: 
					[:anEdge |
					(theParentEdges includesKey: anEdge target)
						ifFalse: 
							[theParentEdges at: anEdge target put: anEdge.
							theQueue add: anEdge target]]].
	^theParentEdges
]

{ #category : #building }
GtAnnouncerGraph >> passiveEphemeronValueFrom: anEphemeronNode to: aValueNode [
	edges
		add: (GtAnnouncerGraphEdge
				from: anEphemeronNode
				to: aValueNode
				kind: GtAnnouncerGraphEphemeronValueReference new
				label: 'value') bePassive
]

{ #category : #building }
GtAnnouncerGraph >> registryNodeFor: aRegistry subscriptionCount: aNumber [
	^self
		nodeFor: aRegistry
		role: GtAnnouncerGraphRegistryRole new
		description: aNumber printString , ' subscriptions'
				, (aNumber > self maximumSubscriptions
						ifTrue: [', ' , self maximumSubscriptions printString , ' shown']
						ifFalse: [''])
]

{ #category : #building }
GtAnnouncerGraph >> rootNode [
	^self
		nodeFor: FinalizationRegistry default
		role: GtAnnouncerGraphRootRole new
		description: 'FinalizationRegistry default'
]

{ #category : #building }
GtAnnouncerGraph >> strongFrom: aSourceNode to: aTargetNode label: aString [
	edges add: (GtAnnouncerGraphEdge
				from: aSourceNode
				to: aTargetNode
				kind: GtAnnouncerGraphStrongReference new
				label: aString)
]

{ #category : #building }
GtAnnouncerGraph >> subscriberNodeFor: aSubscriber [
	^self
		nodeFor: aSubscriber
		role: GtAnnouncerGraphSubscriberRole new
		description: (self describe: aSubscriber)
]

{ #category : #building }
GtAnnouncerGraph >> subscriptionNodeFor: aSubscription [
	^self
		nodeFor: aSubscription
		role: GtAnnouncerGraphSubscriptionRole new
		description: aSubscription announcementClass printString , ' → '
				, aSubscription action gtAnnouncerGraphActionDescription
]

{ #category : #building }
GtAnnouncerGraph >> subscriptions: aCollection do: aBlock [
	(self inStableOrder: aCollection) do: 
			[:each |
			shownSubscriptions < self maximumSubscriptions
				ifTrue: 
					[shownSubscriptions := shownSubscriptions + 1.
					aBlock value: each]]
]

{ #category : #building }
GtAnnouncerGraph >> weakFrom: aSourceNode to: aTargetNode label: aString [
	edges add: (GtAnnouncerGraphEdge
				from: aSourceNode
				to: aTargetNode
				kind: GtAnnouncerGraphWeakReference new
				label: aString)
]
