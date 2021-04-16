Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-MVVM-Template' }
GtPharoMethodCoder >> browseTemplateMethodSourceFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 1>

	coderAddOns addStyler: GtPharoBrowseTemplateMethodStyler new
]
