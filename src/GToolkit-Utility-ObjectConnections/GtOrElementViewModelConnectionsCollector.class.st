Class {
	#name : #GtOrElementViewModelConnectionsCollector,
	#superclass : #Object,
	#category : #'GToolkit-Utility-ObjectConnections'
}

{ #category : #accessing }
GtOrElementViewModelConnectionsCollector >> collectForObjects: aCollection [
	| containmentRelations |
	containmentRelations := OrderedCollection new.
	
	aCollection 
		select: [ :each |
			(each isKindOf: BlElement) and: [
				each viewModel notNil ]] 
		thenDo: [ :anElement |
			| viewModel|
			viewModel := anElement viewModel.
			(aCollection anySatisfy: [ :e | e == viewModel ])
				ifTrue: [ 
					containmentRelations add: (GtOrElementViewModelConnection new 
						element: anElement;
						viewModel: viewModel) ] ].
	
	^ containmentRelations
]
