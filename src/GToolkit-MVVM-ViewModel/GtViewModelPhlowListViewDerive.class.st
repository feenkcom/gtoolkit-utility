Class {
	#name : #GtViewModelPhlowListViewDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-MVVM-ViewModel-Derives'
}

{ #category : #accessing }
GtViewModelPhlowListViewDerive class >> label [
	^ 'phlowList'
]

{ #category : #'api - generation' }
GtViewModelPhlowListViewDerive >> applyOnMetamodelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |		
		eachViewModelModelWithCodeDefinition isForMany
			ifTrue: [ self generatePhlowListViewForManyMethodFor: eachViewModelModelWithCodeDefinition ]
			ifFalse: [
				eachViewModelModelWithCodeDefinition viewModelModel children
					do: [ :eachChildViewModelModel |
						self
							generatePhlowListViewForOneMethodFor: eachViewModelModelWithCodeDefinition
							childViewModelModel: eachChildViewModelModel] ] ]
]

{ #category : #'private - generation' }
GtViewModelPhlowListViewDerive >> generatePhlowListViewForManyMethodFor: aViewModelModelWithCodeDefinition [
	| aMethodSource |
aMethodSource :=
'gt{Name}ListViewFor: aView
	<gtView>
	
	^ aView list
		priority: 5;
		title: ''{Name}'';
		items: [ self {children} ]'
			format: {
				#Name -> aViewModelModelWithCodeDefinition name capitalized.
				#children -> aViewModelModelWithCodeDefinition childViewModelsName
			} asDictionary.
			
	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: aMethodSource
		protocol: 'gt-extentions'
]

{ #category : #'private - generation' }
GtViewModelPhlowListViewDerive >> generatePhlowListViewForOneMethodFor: aViewModelModelWithCodeDefinition childViewModelModel: aChildViewModelModel [
	| aMethodSource |
aMethodSource :=
'gt{Name}ListViewFor: aView
	<gtView>
	
	^ aView list
		priority: 5;
		title: ''{Name}'';
		items: [ self {child} {grandchildren}]'
			format: {
				#Name -> aChildViewModelModel name capitalized.
				#child -> (aViewModelModelWithCodeDefinition viewModelModel childViewModelsNameFor: aChildViewModelModel).
				#grandchildren -> aChildViewModelModel childViewModelsName
			} asDictionary.
			
	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: aMethodSource
		protocol: 'gt-extentions'
]
