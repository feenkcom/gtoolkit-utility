Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-MVVM-Template' }
CompiledMethod >> gtTemplateMethodFor: aView [
	<gtView>
	
	(self pragmaAt: #gtMethodTemplate)
		ifNil: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Template';
		priority: 1;
		stencil: [ GtPharoTemplateMethodCoder new forCompiledMethod: self ]
]
