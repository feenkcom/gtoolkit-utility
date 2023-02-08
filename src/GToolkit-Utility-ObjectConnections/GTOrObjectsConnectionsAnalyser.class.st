Class {
	#name : #GTOrObjectsConnectionsAnalyser,
	#superclass : #Object,
	#instVars : [
		'traversal',
		'selectionFilters',
		'selectedObjects',
		'memoryReport',
		'relations',
		'connectionsCollector',
		'connectionsExclusionFilters'
	],
	#category : #'GToolkit-Utility-ObjectConnections'
}

{ #category : #adding }
GTOrObjectsConnectionsAnalyser >> addConnectionsCollector: aConnectionsCollector [
	connectionsCollector add: aConnectionsCollector 
]

{ #category : #adding }
GTOrObjectsConnectionsAnalyser >> addConnectionsExclusionFilters: aFilter [
	connectionsExclusionFilters add: aFilter 
]

{ #category : #accessing }
GTOrObjectsConnectionsAnalyser >> analyseFrom: anObject [
	self collectObjectsFrom: anObject.
	self collectConnectionsFor: selectedObjects
]

{ #category : #accessing }
GTOrObjectsConnectionsAnalyser >> collectConnectionsFor: aCollection [
	relations := connectionsCollector flatCollect: [ :each |
		each collectForObjects: self selectedObjects ].
	relations := relations reject: [ :aRelation |
		connectionsExclusionFilters anySatisfy: [ :aFilter |
			aFilter matches:  aRelation] ]
]

{ #category : #accessing }
GTOrObjectsConnectionsAnalyser >> collectObjectsFrom: aStartingObject [
	memoryReport := traversal computeMemoryFor: aStartingObject.
	traversal run.

	selectedObjects := traversal objectsTraversed select: [ :anObject |
		selectionFilters anySatisfy: [ :aFilter |
			aFilter matches: anObject ]]
]

{ #category : #accessing }
GTOrObjectsConnectionsAnalyser >> excludeConnectionsWithKeys: aListOfKeys [
	self addConnectionsExclusionFilters: (DTObjectTraversalBlockFilter new
		block: [ :aRelation |
			aListOfKeys includes: aRelation connectionKey ])
]

{ #category : #'gt - extensions' }
GTOrObjectsConnectionsAnalyser >> gtViewConnectionsLayersMapFor: aView [
	"<gtView>"
	
	^ aView mondrian 
		title: 'Map (layers)';
		painting: [ :aMondrianView |
			self paintLayeredConnectionsOn: aMondrianView ]
]

{ #category : #'gt - extensions' }
GTOrObjectsConnectionsAnalyser >> gtViewConnectionsMapFor: aView [
	<gtView>
	
	^ aView mondrian 
		title: 'Map (tree)';
		painting: [ :aMondrianView |
			self paintConnectionsOn: aMondrianView ]
]

{ #category : #initialization }
GTOrObjectsConnectionsAnalyser >> initialize [
	super initialize.
	
	traversal := DTObjectGraphTraversal new  .
	selectionFilters := OrderedCollection new.
	connectionsCollector := OrderedCollection new.
	
	connectionsExclusionFilters := OrderedCollection new.
]

{ #category : #accessing }
GTOrObjectsConnectionsAnalyser >> paintConnectionsOn: aMondrianView [
 
	aMondrianView nodes
		stencil: [ :each |
			BrLabel new 
				text: each printString;
				aptitude: (BrGlamorousLabelAptitude new
					foreground:  (
						(each isKindOf: BlElement)
							ifTrue: [ Color red muchDarker  ]
							ifFalse: [
								((each className includesSubstring: 'ViewModel') 
									or: [each isKindOf: BrWidgetModel])
										ifTrue: [ Color blue muchDarker ] 
										ifFalse: [ Color black ] ])) ];
		with: self selectedObjects.

	aMondrianView edges 
		shape: [ :each |
			BlLineElement new
				toHead: (BlArrowheadSimpleArrow new 
					border: (BlBorder 
						paint: (Color gray alpha: 0.5) 
						width: 10));
				border: (BlBorder 
					paint: (Color gray alpha: 0.5) 
					width: 2 ) ];
				fromCenterBottom;
				toCenterTop;
	connect: relations from: #fromObject to: #toObject.
	
	aMondrianView layout tree nodeDistance: 40. "custom: (GtGradWestHierarchicalLayout new)".
]

{ #category : #accessing }
GTOrObjectsConnectionsAnalyser >> paintLayeredConnectionsOn: aMondrianView [
 
	aMondrianView nodes
		stencil: [ :each |
			| childrenContainer |
			childrenContainer := BlElement new 
				border: (BlBorder 
					paint: Color lightGray ); 
				padding: (BlInsets all: 5);
				margin: (BlInsets bottom: 15).
			childrenContainer graph beChildrenContainer: #default. 
			childrenContainer constraintsDo: [ :c | 
				c vertical fitContent. 
				c horizontal fitContent. 
				c linear horizontal alignCenter ]. ];
		with: self selectedObjectsGroupedByLayer;
		forEach: [ :aGroup |
			aMondrianView nodes
				stencil: [ :each |
					BrLabel new 
						text: each printString;
						aptitude: BrGlamorousLabelAptitude new ];
				with: aGroup.
		
			aMondrianView edges 
				shape: [ :each |
					BlLineElement new
						toHead: (BlArrowheadSimpleArrow new 
							border: (BlBorder 
								paint: (Color gray alpha: 0.5) 
								width: 10));
						border: (BlBorder 
							paint: (Color gray alpha: 0.5) 
							width: 2 ) ];
						fromCenterBottom;
						toCenterTop;
				connect: relations from: #fromObject to: #toObject.
			aMondrianView layout tree nodeDistance: 10 ].

	aMondrianView edges 
		passive;
				shape: [ :each |
					BlLineElement new
						toHead: (BlArrowheadSimpleArrow new 
							border: (BlBorder 
								paint: (Color gray alpha: 0.5) 
								width: 10));
						border: (BlBorder 
							paint: (Color gray alpha: 0.5) 
							width: 2 ) ];
						fromCenterBottom;
						toCenterTop;
				connect: relations from: #fromObject to: #toObject.
			
	aMondrianView layout vertical
	
	 "custom: (GtGradWestHierarchicalLayout new)".
]

{ #category : #accessing }
GTOrObjectsConnectionsAnalyser >> removeNotConnectedNodes [
	selectedObjects := self selectedObjects select: [ :each |
		relations anySatisfy: [ :aConnection |
			aConnection fromObject == each or: [
				aConnection toObject == each ] ] ]
]

{ #category : #accessing }
GTOrObjectsConnectionsAnalyser >> selectTypes: aCollectionOfClasses [
	selectionFilters add: (DTObjectTraversalInstanceTypesFilter new
		classes: aCollectionOfClasses)
]

{ #category : #accessing }
GTOrObjectsConnectionsAnalyser >> selectedObjects [
	^ selectedObjects
]

{ #category : #accessing }
GTOrObjectsConnectionsAnalyser >> selectedObjectsGroupedByLayer [
	^ self selectedObjects groupedBy: [ :each |
		(each isKindOf: BlElement)
			ifTrue: [ #element ]
			ifFalse: [
				((each className includesSubstring: 'ViewModel') 
					or: [each isKindOf: BrWidgetModel])
					ifTrue: [ #viewModel ] 
					ifFalse: [ #other ] ] ]
]

{ #category : #accessing }
GTOrObjectsConnectionsAnalyser >> traversal [
	^ traversal
]
