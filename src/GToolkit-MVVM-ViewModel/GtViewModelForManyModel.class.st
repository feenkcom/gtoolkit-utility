Class {
	#name : #GtViewModelForManyModel,
	#superclass : #GtViewModelModel,
	#instVars : [
		'forOneModel',
		'parents'
	],
	#category : #'GToolkit-MVVM-ViewModel-Model'
}

{ #category : #accessing }
GtViewModelForManyModel >> addParent: aGtViewModelModel [
	(parents includes: aGtViewModelModel)
		ifTrue: [ ^ self ].

	parents add: aGtViewModelModel
]

{ #category : #'api - accessing' }
GtViewModelForManyModel >> childViewModelsName [
	^ self childViewModelsNameFor: self forOneModel
]

{ #category : #accessing }
GtViewModelForManyModel >> children [
	^ { self forOneModel }
]

{ #category : #accessing }
GtViewModelForManyModel >> forOneModel [
	^ forOneModel
]

{ #category : #accessing }
GtViewModelForManyModel >> forOneModel: anObject [
	forOneModel := anObject.
	forOneModel parent: self
]

{ #category : #'api - generation' }
GtViewModelForManyModel >> generateChildViewModelsAccessorFor: aViewModelDefinition [
	| aDefinition |

	aDefinition := GtClassFromTemplateGenerator new
		templateClass: TGtViewModelChildrenForManyAccessorTemplate;
		className: #VirtialClass;
		packageName: 'MyPackage';
		templateMap: { 
			#modelGetter -> self modelGetterSelector uncapitalized.
			#viewModelClass -> self viewModelClassName.
			#childViewModels -> self childViewModelsName uncapitalized.
			#chilViewModelsClass -> self forOneModel viewModelClassName capitalized.
			#childModelsGetter -> self itemsAccessorSelector uncapitalized.
			#childModelSetter -> self forOneModel modelSetterSelectorName uncapitalized.
			#childParentViewModelSetter -> self forOneModel parentViewModelSelectorName uncapitalized.
		};
		generateBehaviorDefinition.

	self
		mergeBehaviorDefinition: aDefinition instanceSideDefinition
		into: aViewModelDefinition
]

{ #category : #'api - generation' }
GtViewModelForManyModel >> generateParentViewModelAccessorsFor: aViewModelBehaviorDefinition [
	self parents do: [ :eachParentViewModelModel |
		self
			generateParentViewModelAccessorsFor: aViewModelBehaviorDefinition
			parentViewModelModel: eachParentViewModelModel ]
]

{ #category : #testing }
GtViewModelForManyModel >> hasParents [
	^ self parents notEmpty
]

{ #category : #initialize }
GtViewModelForManyModel >> initialize [
	super initialize.

	model := #OrderedCollection.
	parents := OrderedCollection new
]

{ #category : #'api - accessing' }
GtViewModelForManyModel >> itemsAccessorSelector [
	^ properties
		at: #items
		ifAbsent: [ #yourself ]
]

{ #category : #accessing }
GtViewModelForManyModel >> parents [
	^ parents
]

{ #category : #accessing }
GtViewModelForManyModel >> parents: anObject [
	parents := anObject asOrderedCollection
]
