Trait {
	#name : #TGtViewModelProgramNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitCompositeLevel: aCompositeLevel [
	^ self visitLevel: aCompositeLevel
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitDefinition: aDefinition [
	^ self visitProgram: aDefinition
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitDefinitions: aDefinitions [
	^ self visitProgram: aDefinitions
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitFullDefinition: aFullDefinition [
	^ self visitProgram: aFullDefinition
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitGenericProperty: aGenericProperty [
	^ self visitProperty: aGenericProperty
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitGlobalPropertyValue: aGlobalPropertyValue [
	^ self visitPropertyValue: aGlobalPropertyValue
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitHierarchy: aHierarchy [
	^ self visitProgram: aHierarchy
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitHierarchyError: aHierarchyError [
	^ self visitHierarchy: aHierarchyError
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitItemsProperty: anItemsProperty [
	^ self visitProperty: anItemsProperty
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitLevel: aLevel [
	^ self visitProgram: aLevel
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitLevelForMany: aLevelForMany [
	^ self visitSimpleLevel: aLevelForMany
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitLevelForOne: aLevelForOne [
	^ self visitSimpleLevel: aLevelForOne
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitModelAnnotation: aModelAnnotation [
	^ self visitProgram: aModelAnnotation
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitNestedLevel: aNestedLevel [
	^ self visitLevel: aNestedLevel
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitProgram: aProgram [
	^ self visitSmaCCParseNode: aProgram
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitProperties: aProperties [
	^ self visitProgram: aProperties
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitProperty: aProperty [
	^ self visitProgram: aProperty
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitPropertyName: aPropertyName [
	^ self visitProgram: aPropertyName
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitPropertyValue: aPropertyValue [
	^ self visitProgram: aPropertyValue
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitSetting: aSetting [
	^ self visitProgram: aSetting
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitSettings: aSettings [
	^ self visitProgram: aSettings
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitSimpleLevel: aSimpleLevel [
	^ self visitLevel: aSimpleLevel
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitStringPropertyValue: aStringPropertyValue [
	^ self visitPropertyValue: aStringPropertyValue
]

{ #category : #generated }
TGtViewModelProgramNodeVisitor >> visitSymbolPropertyValue: aSymbolPropertyValue [
	^ self visitPropertyValue: aSymbolPropertyValue
]
