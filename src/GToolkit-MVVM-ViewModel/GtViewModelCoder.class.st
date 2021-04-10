Class {
	#name : #GtViewModelCoder,
	#superclass : #GtSourceCoder,
	#category : #'GToolkit-MVVM-ViewModel-Coder'
}

{ #category : #converting }
GtViewModelCoder >> asCoderUIModel [
	^ GtSourceCoderViewModel new coderModel: self
]

{ #category : #'api - ast' }
GtViewModelCoder >> computeAst: theSourceString [
	^ GtViewModelParser
		parseWithErrors: theSourceString
		startingAt: GtViewModelParser startingStateForFullDefinition
]

{ #category : #'initialize-release' }
GtViewModelCoder >> forSource: aString [
	self sourceCode: (GtCoderExplicitSourceCode new source: aString)
]

{ #category : #initialization }
GtViewModelCoder >> initializeAddOns: addOns [
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
GtViewModelCoder >> newCompletionStrategy [
	^ GtCompletionStrategy new
]

{ #category : #'private - actions' }
GtViewModelCoder >> primitiveDebug: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	
]

{ #category : #'private - actions' }
GtViewModelCoder >> primitiveEvaluate: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	^ (GtViewModelModelsGenerator new
		sourceCode: aSourceString;
		generate) generateCodeDefinitions
]
