Class {
	#name : #GtNavigationViewModelForOneModel,
	#superclass : #GtNavigationViewModelModel,
	#instVars : [
		'children'
	],
	#category : #'GToolkit-MVVM-ViewModel-Generator'
}

{ #category : #adding }
GtNavigationViewModelForOneModel >> addChild: aGtNavigationViewModelModel [
	(self hasChild: aGtNavigationViewModelModel)
		ifTrue: [ ^ self ].

	children add: aGtNavigationViewModelModel.
	aGtNavigationViewModelModel parent: self
]

{ #category : #accessing }
GtNavigationViewModelForOneModel >> children [
	^ children
]

{ #category : #accessing }
GtNavigationViewModelForOneModel >> children: anObject [
	children := anObject
]

{ #category : #'private - generation' }
GtNavigationViewModelForOneModel >> generateBehaviorDefinitionIn: aPharoEnvironment [
	| aModelTraitDefinition aSelectableTraitDefinition aDefinition |

	aModelTraitDefinition := self modelApiTrait
		ifNotNil: [ :aTrait | GtTraitDefinition fromTrait: aTrait in: aPharoEnvironment ].
		
	aSelectableTraitDefinition := self generateSelectionPropertyTraitIn: aPharoEnvironment.

	aDefinition := GtViewModelGenerator new
		environment: aPharoEnvironment;
		modelName: self model;
		viewModelName: self viewModelClassName;
		projectPrefix: self project;
		packageName: self package;
		traits: ({ aModelTraitDefinition . aSelectableTraitDefinition } select: #notNil);
		generateBehaviorDefinition.
		
	self generateParentViewModelAccessorsFor: aDefinition.
	
	^ { aSelectableTraitDefinition . aDefinition }
]

{ #category : #'private - generation' }
GtNavigationViewModelForOneModel >> generateSelectionPropertyTraitIn: aPharoEnvironment [
	^ GtTraitGenerator new
		environment: aPharoEnvironment;
		templateTrait: TGtNavigationPropertyForChildTemplate;
		traitName: ('T', self project, self prefix capitalized, 'Selectable', self name capitalized, self suffix capitalized, 'ViewModel');
		packageName: self package;
		templateMap: { 
			#__property__ -> 'selection'.
			#__Status__ -> 'Selected'.
			#__status__ -> 'selected'.
			#__Status_not__ -> 'Deselected'.
			#__Set__ -> 'Select'.
			#__set__ -> 'select'.
			#__Unset__ -> 'deselect'.
			#__unset__ -> 'deselect'.
			#__object__ -> 'package'.
			#__Object__ -> 'Package'.
			#__has_parent_property__ -> #hasSelectedPackageViewModel.
			#__parent_object_getter__ -> #pharoPackagesNavigationViewModel.
			#__parent_property_getter__ -> #selectedPackageViewModel.
			#__parent_property_setter__ -> #selectPackageViewModel:
		};
		generateBehaviorDefinition
]

{ #category : #testing }
GtNavigationViewModelForOneModel >> hasChild: aChild [
	(children includes: aChild)
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #initialization }
GtNavigationViewModelForOneModel >> initialize [
	super initialize.
	
	children := OrderedCollection new.
]

{ #category : #testing }
GtNavigationViewModelForOneModel >> isForOne [
	^ true
]
