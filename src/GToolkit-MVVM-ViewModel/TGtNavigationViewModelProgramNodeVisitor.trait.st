Trait {
	#name : #TGtNavigationViewModelProgramNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitCompositeLevel: aCompositeLevel [
	^ self visitLevel: aCompositeLevel
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitDefinition: aDefinition [
	^ self visitProgram: aDefinition
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitDefinitions: aDefinitions [
	^ self visitProgram: aDefinitions
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitFullDefinition: aFullDefinition [
	^ self visitProgram: aFullDefinition
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitHierarchy: aHierarchy [
	^ self visitProgram: aHierarchy
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitHierarchyError: aHierarchyError [
	^ self visitHierarchy: aHierarchyError
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitLevel: aLevel [
	^ self visitProgram: aLevel
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitLevelForMany: aLevelForMany [
	^ self visitSimpleLevel: aLevelForMany
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitLevelForOne: aLevelForOne [
	^ self visitSimpleLevel: aLevelForOne
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitModelAnnotation: aModelAnnotation [
	^ self visitProgram: aModelAnnotation
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitNestedLevel: aNestedLevel [
	^ self visitLevel: aNestedLevel
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitProgram: aProgram [
	^ self visitSmaCCParseNode: aProgram
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitProperties: aProperties [
	^ self visitProgram: aProperties
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitProperty: aProperty [
	^ self visitProgram: aProperty
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitPropertyName: aPropertyName [
	^ self visitProgram: aPropertyName
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitPropertyValue: aPropertyValue [
	^ self visitProgram: aPropertyValue
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitSimpleLevel: aSimpleLevel [
	^ self visitLevel: aSimpleLevel
]

{ #category : #generated }
TGtNavigationViewModelProgramNodeVisitor >> visitSymbolPropertyValue: aSymbolPropertyValue [
	^ self visitPropertyValue: aSymbolPropertyValue
]
