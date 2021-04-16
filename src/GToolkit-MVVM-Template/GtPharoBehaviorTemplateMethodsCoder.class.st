Class {
	#name : #GtPharoBehaviorTemplateMethodsCoder,
	#superclass : #GtFilteredMethodsCoder,
	#instVars : [
		'class',
		'object',
		'filteredClasses'
	],
	#category : #'GToolkit-MVVM-Template-Coder'
}

{ #category : #'instance creation' }
GtPharoBehaviorTemplateMethodsCoder class >> forClass: aBehavior [
	^ self new
		forClass: aBehavior;
		yourself
]

{ #category : #'instance creation' }
GtPharoBehaviorTemplateMethodsCoder class >> forObject: anObject [
	^ self new
		forObject: anObject;
		yourself
]

{ #category : #actions }
GtPharoBehaviorTemplateMethodsCoder >> addMethodsForClass: aClass [
	(filteredClasses includes: aClass)
		ifTrue: [ ^ self ].
	filteredClasses add: aClass.
	self updateMethods.
	self updateCoders
]

{ #category : #actions }
GtPharoBehaviorTemplateMethodsCoder >> addNewCoderSelector: aSelector protocol: aProtocol [
	| aCoder |
	aCoder := GtPharoTemplateMethodCoder new
		forTemplateMethod: (GtPharoTemplateMethod new
			storageBehavior: self newMethodClass
				selector: aSelector asSymbol;
			storageProtocol: aProtocol;
			sourceCode: 'template').
	aCoder coders: self.
	self addFirstCoder: aCoder.
	^ aCoder
]

{ #category : #converting }
GtPharoBehaviorTemplateMethodsCoder >> asCoderUIModel [
	^ GtPharoTemplateMethodsCoderViewModel new coder: self
]

{ #category : #accessing }
GtPharoBehaviorTemplateMethodsCoder >> classOrMetaClass [
	^ class
]

{ #category : #private }
GtPharoBehaviorTemplateMethodsCoder >> classesFilter [
	| filter |
	filter := nil.
	filteredClasses
		do: [ :each | 
			| classFilter |
			classFilter := GtSearchMethodsInInstanceAndClassSideFilter forClass: each.
			filter := filter isNil
				ifTrue: [ classFilter ]
				ifFalse: [ filter | classFilter ] ].
	^ filter
]

{ #category : #private }
GtPharoBehaviorTemplateMethodsCoder >> combinedFilter [
	| combined |
	combined := super combinedFilter.
	^ self classesFilter
		ifNil: [ combined ]
		ifNotNil:
			[ :filter | combined ifNil: [ filter ] ifNotNil: [ filter & combined ] ]
]

{ #category : #elements }
GtPharoBehaviorTemplateMethodsCoder >> filterTypes [
	^ GtPhlowViewsCollector new
		fromObject: self;
		pragmaName: #gtFilterTypes;
		collect
]

{ #category : #testing }
GtPharoBehaviorTemplateMethodsCoder >> filteredClass: aBehavior [
	^ filteredClasses includes: aBehavior
]

{ #category : #initialize }
GtPharoBehaviorTemplateMethodsCoder >> forClass: aBehavior [
	class := aBehavior.
	filteredClasses := Set with: aBehavior.
	self forItems: (GtSearchMethodGroupResult 
		forFilter: (GtSearchTemplateMethodsInInstanceAndClassSideFilter forClass: class))
]

{ #category : #initialize }
GtPharoBehaviorTemplateMethodsCoder >> forObject: anObject [
	object := anObject.
	self forClass: anObject class
]

{ #category : #printing }
GtPharoBehaviorTemplateMethodsCoder >> gtDisplayString [
	^ class name , ' methods'
]

{ #category : #'gt-extensions' }
GtPharoBehaviorTemplateMethodsCoder >> gtSpotterMethodsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 10;
		title: 'Methods';
		allCandidates: [ self coders ];
		itemName: [ :method | method selector ];
		previewElement: [ :coder | coder previewElement ];
		filter: GtFilterSubstring
]

{ #category : #testing }
GtPharoBehaviorTemplateMethodsCoder >> hasFilter [
	^ filteredClasses notEmpty
]

{ #category : #initialize }
GtPharoBehaviorTemplateMethodsCoder >> initialize [
	super initialize.
	filteredClasses := Set new
]

{ #category : #testing }
GtPharoBehaviorTemplateMethodsCoder >> isForClass [
	^ true
]

{ #category : #private }
GtPharoBehaviorTemplateMethodsCoder >> newCoderFor: aMethod [
	| coder |
	coder := GtPharoTemplateMethodCoder new forCompiledMethod: aMethod.
	coder coders: self.
	^ coder
]

{ #category : #private }
GtPharoBehaviorTemplateMethodsCoder >> newMethodClass [
	| methodClass |
	methodClass := filteredClasses anyOne.
	filteredClasses
		do: [ :each | 
			(methodClass includesBehavior: each)
				ifFalse: [ methodClass := each ] ].
	^ methodClass
]

{ #category : #accessing }
GtPharoBehaviorTemplateMethodsCoder >> object [
	^ object
]

{ #category : #actions }
GtPharoBehaviorTemplateMethodsCoder >> removeMethodsForClass: aClass [
	(filteredClasses includes: aClass)
		ifFalse: [ ^ self ].
	filteredClasses remove: aClass.
	self updateMethods.
	coders
		removeAllSuchThat: [ :each | 
			(each classOrMetaClass = aClass
				or: [ each classOrMetaClass = aClass classSide ])
				and: [ each isModified not ] ].
	self
		announce:
			(GtCodersCodersChanged new
				coders: self;
				yourself)
]

{ #category : #private }
GtPharoBehaviorTemplateMethodsCoder >> shouldSort: a before: b [
	a selector isNil
		ifTrue: [ ^ b selector notNil
				or: [ a classOrMetaClass allSuperclasses size
						>= b classOrMetaClass allSuperclasses size ] ].
	b selector isNil
		ifTrue: [ ^ false ].
	a selector < b selector
		ifTrue: [ ^ true ].
	a selector > b selector
		ifTrue: [ ^ false ].
	^ a behavior allSuperclasses size >= b behavior allSuperclasses size
]
