"
!! Simple file browser:

@project Gt2
@package MyPackageFiles
@derive print
@derive phlowList

folder => folder(s) and file(s).
folder {
	folder(s): #directories,
	file(s): #files
}.


!! Simple system browser:

@project Gt2
@package MyPackageSystem
@derive print
@derive phlowList

smalltalk => package(s) => tag(s) => class(es) => protocol(s).

smalltalk { package(s): #packages }.
package { tag(s): #classTags }.
tag { class(es): #classes }.
class { protocol(s): #protocols }
"
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
	
	addOns addStyler: GtViewModelStyler new.
	addOns addStyler: GtViewModelBrowseStyler new.
	addOns addStyler: GtViewModelExpanderStyler new.

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
