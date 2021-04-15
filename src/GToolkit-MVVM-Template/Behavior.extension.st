Extension { #name : #Behavior }

{ #category : #'*GToolkit-MVVM-Template' }
Behavior >> gtCoderTemplateMethodsFor: aView context: aPhlowContext [
	<gtClassView>
	| aMethodsCoderUIModel |

	aMethodsCoderUIModel := (GtPharoBehaviorTemplateMethodsCoder forClass: self) asCoderUIModel.
	aMethodsCoderUIModel coderUIModels
		ifEmpty: [ ^ aView empty ].
	
	^ aView explicit
		priority: 5;
		title: 'Template Methods';
		disableAsync;
		actionButtonDo: [ :aButtonAction |
			aButtonAction
				icon: BrGlamorousVectorIcons add;
				tooltip: 'Add new method';
				action: [ aMethodsCoderUIModel addNewCoder ];
				name: GtPharoBehaviorCoder addNewMethodButtonName ];
		stencil: [ aMethodsCoderUIModel asElement ]
]
