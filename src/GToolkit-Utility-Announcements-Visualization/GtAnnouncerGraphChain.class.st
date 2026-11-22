"
I am one chain of references through which the global FinalizationRegistry keeps an object of a {{gtClass:GtAnnouncerGraph}} alive: my edges lead from the root to my target, in order. The graph builds me while it highlights ({{gtMethod:GtAnnouncerGraph>>chainTo:ifFound:}}), and its red lines are the union of all chains. {{gtMethod:GtAnnouncerGraph>>gtWhyAliveFor:}} lists the chains with their steps; my own views draw only my nodes and edges.
"
Class {
	#name : #GtAnnouncerGraphChain,
	#superclass : #Object,
	#instVars : [
		'graph',
		'target',
		'edges'
	],
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #'instance creation' }
GtAnnouncerGraphChain class >> graph: aGraph target: aNode edges: aCollection [
	^self new setGraph: aGraph target: aNode edges: aCollection
]

{ #category : #accessing }
GtAnnouncerGraphChain >> edges [
	^edges
]

{ #category : #views }
GtAnnouncerGraphChain >> gtChainFor: aView [
	<gtView>
	^(aView mondrian)
		title: 'Chain';
		priority: 1;
		painting: 
				[:aMondrian |
				graph
					paintWith: aMondrian
					nodes: self nodes
					edges: edges];
		send: [:each | each objectToInspect]
]

{ #category : #views }
GtAnnouncerGraphChain >> gtStepsFor: aView [
	<gtView>
	^(aView columnedList)
		title: 'Steps';
		priority: 2;
		items: [edges];
		column: 'From' text: [:each | each source];
		column: 'Reference' text: [:each | each whyAliveReference];
		column: 'To' text: [:each | each target];
		send: [:each | each]
]

{ #category : #highlighting }
GtAnnouncerGraphChain >> highlight [
	edges do: [:each | each highlight]
]

{ #category : #accessing }
GtAnnouncerGraphChain >> nodes [
	^(edges collect: [:each | each source]) copyWith: target
]

{ #category : #printing }
GtAnnouncerGraphChain >> printOn: aStream [
	aStream
		nextPutAll: 'Chain to ';
		print: target
]

{ #category : #initialization }
GtAnnouncerGraphChain >> setGraph: aGraph target: aNode edges: aCollection [
	graph := aGraph.
	target := aNode.
	edges := aCollection
]

{ #category : #accessing }
GtAnnouncerGraphChain >> target [
	^target
]

{ #category : #printing }
GtAnnouncerGraphChain >> whyAliveDescription [
	^target printString
]

{ #category : #printing }
GtAnnouncerGraphChain >> whyAliveReference [
	^edges size printString , ' references from the global registry'
]

{ #category : #accessing }
GtAnnouncerGraphChain >> whyAliveSteps [
	^edges
]
