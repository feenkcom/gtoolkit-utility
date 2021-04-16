Trait {
	#name : #TGtPharoTemplateOnlyProgramNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'GToolkit-MVVM-Template-Ast'
}

{ #category : #generated }
TGtPharoTemplateOnlyProgramNodeVisitor >> visitProgram: aProgram [
	^ self visitSmaCCParseNode: aProgram
]

{ #category : #generated }
TGtPharoTemplateOnlyProgramNodeVisitor >> visitTemplate: aTemplate [
	^ self visitProgram: aTemplate
]

{ #category : #generated }
TGtPharoTemplateOnlyProgramNodeVisitor >> visitTemplateCode: aTemplateCode [
	^ self visitProgram: aTemplateCode
]

{ #category : #generated }
TGtPharoTemplateOnlyProgramNodeVisitor >> visitTemplateContent: aTemplateContent [
	^ self visitProgram: aTemplateContent
]
