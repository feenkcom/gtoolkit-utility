Class {
	#name : #GtRobocoderMetamodelPhlowListViewDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelPhlowListViewDerive class >> label [
	^ 'phlowList'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelPhlowListViewDerive >> applyOnMetamodelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |		
		eachViewModelModelWithCodeDefinition isForMany
			ifTrue: [ self generatePhlowListViewForManyMethodFor: eachViewModelModelWithCodeDefinition ]
			ifFalse: [
				eachViewModelModelWithCodeDefinition metamodel children
					do: [ :eachChildViewModelModel |
						self
							generatePhlowListViewForOneMethodFor: eachViewModelModelWithCodeDefinition
							childViewModelModel: eachChildViewModelModel] ] ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelPhlowListViewDerive >> generatePhlowListViewForManyMethodFor: aViewModelModelWithCodeDefinition [
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
GtRobocoderMetamodelPhlowListViewDerive >> generatePhlowListViewForOneMethodFor: aViewModelModelWithCodeDefinition childViewModelModel: aChildViewModelModel [
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
				#child -> (aViewModelModelWithCodeDefinition metamodel generateChildObjectGetterSelectorFor: aChildViewModelModel).
				#grandchildren -> aChildViewModelModel childViewModelsName
			} asDictionary.
			
	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: aMethodSource
		protocol: 'gt-extentions'
]
