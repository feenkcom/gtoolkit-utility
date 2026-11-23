"
I show one node of a {{gtClass:GtAnnouncerGraph}} in its context: its own references in both directions, and the chains that keep it alive, if any. {{gtMethod:GtAnnouncerGraph>>gtObjectsFor:}} answers me for the selected node.
"
Class {
	#name : #GtAnnouncerGraphNodeContext,
	#superclass : #Object,
	#instVars : [
		'graph',
		'node'
	],
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #'instance creation' }
GtAnnouncerGraphNodeContext class >> graph: aGraph node: aNode [
	^self new setGraph: aGraph node: aNode
]

{ #category : #accessing }
GtAnnouncerGraphNodeContext >> edges [
	| theEdges |
	theEdges := IdentitySet withAll: (graph edgesOf: node).
	(graph chainsTo: node) do: [:each | theEdges addAll: each edges].
	^theEdges asArray
]

{ #category : #views }
GtAnnouncerGraphNodeContext >> gtContextFor: aView [
	<gtView>
	^(aView mondrian)
		title: 'In the graph';
		priority: 1;
		painting: 
				[:aMondrian |
				graph
					paintWith: aMondrian
					nodes: self nodes
					edges: self edges];
		send: [:each | each objectToInspect];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect the object'
			action: [:aButton | aButton phlow spawnObject: node object]
]

{ #category : #views }
GtAnnouncerGraphNodeContext >> gtReferencesFor: aView [
	<gtView>
	^(aView columnedList)
		title: 'References';
		priority: 2;
		items: [graph edgesOf: node];
		column: 'Direction'
			text: [:each | each source == node ifTrue: ['from it'] ifFalse: ['to it']]
			width: 80;
		column: 'Reference' text: [:each | each whyAliveReference];
		column: 'Other object'
			text: [:each | each source == node ifTrue: [each target] ifFalse: [each source]];
		send: [:each | each]
]

{ #category : #views }
GtAnnouncerGraphNodeContext >> gtWhyAliveFor: aView [
	<gtView>
	^(aView columnedTree)
		title: 'Why alive';
		priority: 3;
		items: [graph chainsTo: node];
		children: [:each | each whyAliveSteps];
		expandUpTo: 1;
		column: 'Kept alive, and through which references'
			text: [:each | each whyAliveDescription];
		column: 'Reference' text: [:each | each whyAliveReference];
		send: [:each | each]
]

{ #category : #accessing }
GtAnnouncerGraphNodeContext >> node [
	^node
]

{ #category : #accessing }
GtAnnouncerGraphNodeContext >> nodes [
	| theNodes |
	theNodes := IdentitySet with: node.
	self edges do: 
			[:each |
			theNodes
				add: each source;
				add: each target].
	^theNodes asArray
]

{ #category : #printing }
GtAnnouncerGraphNodeContext >> printOn: aStream [
	aStream
		nextPutAll: 'Context of ';
		print: node
]

{ #category : #initialization }
GtAnnouncerGraphNodeContext >> setGraph: aGraph node: aNode [
	graph := aGraph.
	node := aNode
]
