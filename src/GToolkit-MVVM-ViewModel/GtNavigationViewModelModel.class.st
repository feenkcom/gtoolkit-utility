Class {
	#name : #GtNavigationViewModelModel,
	#superclass : #Object,
	#instVars : [
		'name',
		'model',
		'modelApi',
		'settings',
		'properties',
		'parent'
	],
	#category : #'GToolkit-MVVM-ViewModel-Generator'
}

{ #category : #'private - generation' }
GtNavigationViewModelModel >> generateBehaviorDefinitionIn: aPharoEnvironment [
	^ #()
]

{ #category : #'private - generation' }
GtNavigationViewModelModel >> generateParentViewModelAccessorsFor: aViewModelBehaviorDefinition [
	| aTemplateDefinition |

	self hasParent
		ifFalse: [ ^ self ].

	aTemplateDefinition := GtTraitGenerator new
		templateTrait: TGtNavigationViewModelParentAccessorTemplate;
		traitName: #Virtial;
		packageName: 'MyPackage';
		templateMap: { 
			#__view_model__ -> self parentViewModelSelectorName.
			#__View_model__ -> self parentViewModelSelectorName capitalized.
			#__View_model_class__ -> self parent viewModelClassName
		};
		generateBehaviorDefinition.

	self
		mergeTraitDefinition: aTemplateDefinition
		into: aViewModelBehaviorDefinition
]

{ #category : #'gt-extension' }
GtNavigationViewModelModel >> gtInfoFor: aView [
	<gtView>

	^ (({
		'View model class name' -> self viewModelClassName.
		'Model getter' -> self modelGetterSelector printString.
		'Model setter' -> self modelSetterSelector printString.
		'Parent view model name' -> (self hasParent
			ifTrue: [ self parentViewModelSelectorName printString ] 
			ifFalse: [ '-----' ]).
	 } asOrderedDictionary, settings) gtItemsFor: aView)
			title: 'Info';
			priority: 2
]

{ #category : #'gt-extension' }
GtNavigationViewModelModel >> gtTreeFor: aView [
	<gtView>

	^ aView tree
		title: 'Children';
		priority: 5;
		items: [ { self } ];
		children: [ :anItem | anItem children ];
		expandAll
]

{ #category : #testing }
GtNavigationViewModelModel >> hasParent [
	^ parent notNil
]

{ #category : #initialization }
GtNavigationViewModelModel >> initialize [
	super initialize.

	settings := Dictionary new.
	properties := Dictionary new
]

{ #category : #testing }
GtNavigationViewModelModel >> isForMany [
	^ self isForOne not
]

{ #category : #testing }
GtNavigationViewModelModel >> isForOne [
	^ false
]

{ #category : #private }
GtNavigationViewModelModel >> mergeTraitDefinition: aTraitDefinition into: aViewModelDefinition [
	"Merge the given trait definition into the view model definition.
	This is useful when we want to actually compile-in methods and slots from template traits."
	
	aTraitDefinition slots do: [ :eachSlot |
		aViewModelDefinition instanceSideDefinition slots
			addSlotNamed: eachSlot name ].
		
	aTraitDefinition methods do: [ :eachMethod |
		aViewModelDefinition instanceSideDefinition methods
			addMethod: eachMethod sourceCode
			protocol: eachMethod protocol ]
]

{ #category : #accessing }
GtNavigationViewModelModel >> model [
	^ model
]

{ #category : #accessing }
GtNavigationViewModelModel >> model: anObject [
	model := anObject asSymbol
]

{ #category : #accessing }
GtNavigationViewModelModel >> modelApi [
	^ modelApi
]

{ #category : #accessing }
GtNavigationViewModelModel >> modelApi: anObject [
	modelApi := anObject
]

{ #category : #accessing }
GtNavigationViewModelModel >> modelApiTrait [
	self modelApi
		ifNil: [ ^ nil ].

	^ self class environment
		at: self modelApi asSymbol
		ifPresent: [ :aGlobal |
			aGlobal isTrait
				ifTrue: [ aGlobal ]
				ifFalse: [ nil ] ]
		ifAbsent: [ nil ]
]

{ #category : #'api - accessing' }
GtNavigationViewModelModel >> modelGetterSelector [
	| aFallbackSelector |

	aFallbackSelector := (self name, 'Model') asSymbol.

	^ modelApi
		ifNotNil: [ :anApiTraitName |
			self class environment
				at: anApiTraitName asSymbol
				ifPresent: [ :aTrait |
					(Pragma allNamed: #modelGetter in: aTrait)
						ifEmpty: [ aFallbackSelector ]
						ifNotEmpty: [ :thePragmas | thePragmas first method selector ] ]
				ifAbsent: [ aFallbackSelector ] ]
		ifNil: [ aFallbackSelector ]
]

{ #category : #'api - accessing' }
GtNavigationViewModelModel >> modelSetterSelector [
	| aFallbackSelector |

	aFallbackSelector := (self name, 'Model:') asSymbol.

	^ modelApi
		ifNotNil: [ :anApiTraitName |
			self class environment
				at: anApiTraitName asSymbol
				ifPresent: [ :aTrait |
					(Pragma allNamed: #modelSetter in: aTrait)
						ifEmpty: [ aFallbackSelector ]
						ifNotEmpty: [ :thePragmas | thePragmas first method selector ] ]
				ifAbsent: [ aFallbackSelector ] ]
		ifNil: [ aFallbackSelector ]
]

{ #category : #accessing }
GtNavigationViewModelModel >> name [
	^ name
]

{ #category : #accessing }
GtNavigationViewModelModel >> name: anObject [
	name := anObject
]

{ #category : #'api - accessing' }
GtNavigationViewModelModel >> package [
	^ settings at: #package ifAbsent: [ '' ]
]

{ #category : #accessing }
GtNavigationViewModelModel >> parent [
	^ parent
]

{ #category : #accessing }
GtNavigationViewModelModel >> parent: anObject [
	parent := anObject
]

{ #category : #'api - accessing' }
GtNavigationViewModelModel >> parentViewModelSelectorName [
	self
		assert: [ self parent notNil ]
		description: [ 'Can not create parent selector if there is no parent' ].

	^ (self prefix uncapitalized, self parent name capitalized, self suffix capitalized, 'ViewModel') asSymbol
]

{ #category : #'api - accessing' }
GtNavigationViewModelModel >> prefix [
	^ settings at: #prefix ifAbsent: [ '' ]
]

{ #category : #printing }
GtNavigationViewModelModel >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."
	
	self isForOne
		ifTrue: [ aStream nextPutAll: 'ForOne' ]
		ifFalse: [ aStream nextPutAll: 'ForMany' ].
	
	aStream
		nextPutAll: ' model: ';
		print: model.
	aStream
		nextPutAll: ' name: ';
		print: name
]

{ #category : #'api - accessing' }
GtNavigationViewModelModel >> project [
	^ settings at: #project ifAbsent: [ '' ]
]

{ #category : #accessing }
GtNavigationViewModelModel >> properties [
	^ properties
]

{ #category : #accessing }
GtNavigationViewModelModel >> properties: anObject [
	properties := anObject
]

{ #category : #accessing }
GtNavigationViewModelModel >> settings [
	^ settings
]

{ #category : #accessing }
GtNavigationViewModelModel >> settings: anObject [
	settings := anObject
]

{ #category : #'api - accessing' }
GtNavigationViewModelModel >> suffix [
	^ settings at: #suffix ifAbsent: [ '' ]
]

{ #category : #'api - accessing' }
GtNavigationViewModelModel >> viewModelClassName [
	properties
		at: #name
		ifPresent: [ :aViewModelName | ^ aViewModelName ].


	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: self project;
			nextPutAll: self prefix capitalized;
			nextPutAll: self name capitalized;
			nextPutAll: self suffix capitalized;
			nextPutAll: 'ViewModel' ]
]
