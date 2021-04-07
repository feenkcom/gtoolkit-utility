Class {
	#name : #GtNavigationViewModelsCoder,
	#superclass : #GtSourceCoder,
	#category : #'GToolkit-MVVM-ViewModel-Coder'
}

{ #category : #converting }
GtNavigationViewModelsCoder >> asCoderUIModel [
	^ GtSourceCoderViewModel new coderModel: self
]

{ #category : #'api - ast' }
GtNavigationViewModelsCoder >> computeAst: theSourceString [
	^ GtNavigationViewModelParser
		parseWithErrors: theSourceString
		startingAt: GtNavigationViewModelParser startingStateForFullDefinition
]

{ #category : #'initialize-release' }
GtNavigationViewModelsCoder >> forSource: aString [
	self sourceCode: (GtCoderExplicitSourceCode new source: aString)
]

{ #category : #initialization }
GtNavigationViewModelsCoder >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	addOns addStyler: GtNavigationViewModelsStyler new.
	addOns addStyler: GtNavigationViewModelsBrowseStyler new.
	addOns addStyler: GtNavigationViewModelsExpanderStyler new.

	addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | 
			GtCoderCodeExecutor doItAndGo
				coderUIModel: aCoderUIModel;
				event: anEvent;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.

	addOns
		addMainAction: 'Inspect UI Model' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :aCoderUIModel :anEvent | self notifyObjectSpawn: aCoderUIModel ].
]

{ #category : #'instance creation' }
GtNavigationViewModelsCoder >> newCompletionStrategy [
	^ GtCompletionStrategy new
]

{ #category : #'private - actions' }
GtNavigationViewModelsCoder >> primitiveEvaluate: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	^ GtNavigationViewModelsGenerator new
		hierarchy: aSourceString;
		generate
]
