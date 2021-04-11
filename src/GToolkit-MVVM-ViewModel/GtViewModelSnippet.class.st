Class {
	#name : #GtViewModelSnippet,
	#superclass : #GtCodeSnippet,
	#instVars : [
		'coder',
		'shouldSpawn',
		'coderViewModel'
	],
	#category : #'GToolkit-MVVM-ViewModel-Coder'
}

{ #category : #accessing }
GtViewModelSnippet class >> typeName [
	"Return a playground snippet type name.
	It should be an unique name among all playground snippet types."
	<return: #String>

	^ 'viewmodel'
]

{ #category : #accessing }
GtViewModelSnippet class >> xdocSnippetMappingFor: aNeoJSONMapper [
	aNeoJSONMapper 
		for: self do: [ :mapping | 
			(mapping mapAccessor: #sourceCode to: #source_code) ]
]

{ #category : #visitor }
GtViewModelSnippet >> accept: aVisitor [
	^ aVisitor visitViewModdelSnippet: self
]

{ #category : #accessing }
GtViewModelSnippet >> allImplicitVariables: aCollection [
	
]

{ #category : #'private - text' }
GtViewModelSnippet >> appendDotCharacter [
	self text insertString: '.' at: self text size
]

{ #category : #'private - text' }
GtViewModelSnippet >> appendNewLine [
	self text insertString: String cr at: self text size.
]

{ #category : #'private - text' }
GtViewModelSnippet >> appendText: aNewText [
	| aLastNonSeparatorCharacterIndex |
	aLastNonSeparatorCharacterIndex := self text finder
		startAtEnd;
		reversed;
		pattern: [ :aText :aCurrentIndex | (aText at: aCurrentIndex) isSeparator not ];
		search.
	(aLastNonSeparatorCharacterIndex > 2
		and: [ (self text at: aLastNonSeparatorCharacterIndex) ~= $. ])
		ifTrue: [ self appendDotCharacter ].
	self appendNewLine.
	self text append: aNewText
]

{ #category : #ui }
GtViewModelSnippet >> asElement [
	| aCoderElement |
	
	aCoderElement := coderViewModel asElement.
	aCoderElement margin: (BlInsets all: 0).

	self announcer
		when: GtSnippetFocusRequestAnnouncement
		send: #requestFocus
		to: aCoderElement.
	
	^ BrFrame new
		vFitContent;
		hMatchParent;
		addAptitude: (GtSnippetContainerAptitude new snippet: self);
		addChild: aCoderElement
]

{ #category : #converting }
GtViewModelSnippet >> asStencilBuilder [
	^ self
]

{ #category : #ui }
GtViewModelSnippet >> bind: aSnippet to: aSnippetElement [
]

{ #category : #private }
GtViewModelSnippet >> codeEvaluated: anEvaluationAnnouncement [
	self
		notifyAboutResult: anEvaluationAnnouncement evaluationResult
		exception: anEvaluationAnnouncement evaluationResult isError
		spawn: shouldSpawn
]

{ #category : #private }
GtViewModelSnippet >> codeModified: aCoderTextModifiedAnnouncement [
	self announce: (GtPageSnippetChangedAnnouncement new snippet: self)
]

{ #category : #'api - cursor' }
GtViewModelSnippet >> focusAndPlaceCursorAtBeginning [
	self flag: 'self textEditor moveCursorTo: 0.'.
	self requestSnippetFocus
]

{ #category : #'api - cursor' }
GtViewModelSnippet >> focusAndPlaceCursorAtEnd [
	self flag: 'self textEditor moveCursorTo: self textEditor text size.'.
	self requestSnippetFocus
]

{ #category : #accessing }
GtViewModelSnippet >> gtKeybindingsFor: aView [
	<gtView>
	^ (coder gtViewKeybindingsFor: aView)
		priority: 60
]

{ #category : #accessing }
GtViewModelSnippet >> implicitLocalVariables [
	^ #()
]

{ #category : #initialization }
GtViewModelSnippet >> initialize [
	coder := GtViewModelCoder new.
	super initialize.

	shouldSpawn := false.
	
	coderViewModel := coder asCoderViewModel.
	
	coder announcer weak
		when: GtCoderEvaluationAnnouncement
		send: #codeEvaluated:
		to: self.
		
	coder announcer weak
		when: GtCoderSourceCodeChanged
		send: #codeModified:
		to: self.

	self subscribeToEditorChanges.
	self initializeCoderAddOns
]

{ #category : #initialization }
GtViewModelSnippet >> initializeCoderAddOns [
	coder addOns
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination builder primary backspace build;
				action: [ :aShortcutEvent | self requestSnippetMerge ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: (BlKeyCombination builder primary return build);
				action: [ :aShortcutEvent | self requestSnippetSplitInEditor: aShortcutEvent currentTarget editor ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination arrowLeft;
				action: [ :aShortcutEvent | self moveLeft: aShortcutEvent currentTarget ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination arrowRight;
				action: [ :aShortcutEvent | self moveRight: aShortcutEvent currentTarget ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination arrowUp;
				action: [ :aShortcutEvent | self moveUp: aShortcutEvent currentTarget ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination arrowDown;
				action: [ :aShortcutEvent | self moveDown: aShortcutEvent currentTarget ])
]

{ #category : #'api - modification' }
GtViewModelSnippet >> mergeWith: aSnippet [
	"Subclasses can define merging mechanism"

	aSnippet class = self class
		ifFalse: [ ^ self ].
	aSnippet text ifNotEmpty: [ self appendText: aSnippet text ].
	aSnippet requestSnippetRemoval.
	self requestSnippetFocus.
]

{ #category : #actions }
GtViewModelSnippet >> moveDown: anElement [
	| textEditor position |
	textEditor := anElement editor.
	textEditor cursors cursorsCount = 1
		ifTrue: [ position := textEditor cursors first position ].
	textEditor deselecter all deselect.
	textEditor navigator moveDown apply.
	(textEditor cursors cursorsCount = 1
		and: [ position = textEditor cursors first position ])
		ifTrue: [ self
				announce:
					(GtSnippetExternalCursorAnnouncement new
						snippet: self;
						direction: #down) ]
]

{ #category : #actions }
GtViewModelSnippet >> moveLeft: anElement [
	| textEditor |
	textEditor := anElement editor.
	(textEditor cursors cursorsCount = 1
		and: [ textEditor cursors first position = 0 ])
		ifTrue: [ self
				announce:
					(GtSnippetExternalCursorAnnouncement new
						snippet: self;
						direction: #left) ]
		ifFalse: [ textEditor deselecter all deselect.
			textEditor navigator moveLeft apply ]
]

{ #category : #actions }
GtViewModelSnippet >> moveRight: anElement [
	| textEditor |
	textEditor := anElement editor.
	(textEditor cursors cursorsCount = 1
		and: [ textEditor cursors first position >= textEditor text size ])
		ifTrue: [ self
				announce:
					(GtSnippetExternalCursorAnnouncement new
						snippet: self;
						direction: #right) ]
		ifFalse: [
			textEditor deselecter all deselect.
			textEditor navigator moveRight apply ]
]

{ #category : #actions }
GtViewModelSnippet >> moveUp: anElement [
	| textEditor position |
	textEditor := anElement editor.
	textEditor cursors cursorsCount = 1
		ifTrue: [ position := textEditor cursors first position ].
	textEditor deselecter all deselect.
	textEditor navigator moveUp apply.
	(textEditor cursors cursorsCount = 1
		and: [ position = textEditor cursors first position ])
		ifTrue: [ self
				announce:
					(GtSnippetExternalCursorAnnouncement new
						snippet: self;
						direction: #up) ]
]

{ #category : #actions }
GtViewModelSnippet >> playAll [
	^ coder doItAll
]

{ #category : #accessing }
GtViewModelSnippet >> receiver: anObject [
	
]

{ #category : #'private - requests' }
GtViewModelSnippet >> requestNewSnippetWith: aNewText [
	| aNewSnippet |
	aNewSnippet := self class new.
	aNewSnippet sourceCode: aNewText.
	self announce: (GtSnippetBelowRequestedAnnouncement
		snippet: self
		second: aNewSnippet).
]

{ #category : #'api - requests' }
GtViewModelSnippet >> requestSnippetMerge [
	self announce: (GtSnippetMergeRequestedAnnouncement snippet: self)
]

{ #category : #actions }
GtViewModelSnippet >> requestSnippetSplit [
	| positions |
	self deprecated: 'use #requestSnippetSplitInEditor:'.
	positions := (self editor cursor cursors collect: [ :each | each position ]) asSortedCollection.
	positions reverseDo: [ :each | self splitTextAt: each ].
	self editor moveCursorTo: self editor text size
]

{ #category : #'api - requests' }
GtViewModelSnippet >> requestSnippetSplitInEditor: aTextEditor [
	| positions |
	positions := (aTextEditor cursors cursors
		collect: [ :each | each position ]) asSortedCollection.
	positions
		reverseDo: [ :eachIndex | 
			| aNewText |
			aNewText := self splitTextAt: eachIndex.
			self requestNewSnippetWith: aNewText ].
	aTextEditor moveCursorTo: aTextEditor text size
]

{ #category : #'api - requests' }
GtViewModelSnippet >> requestStyleText [
	coder requestStyleSourceText
]

{ #category : #private }
GtViewModelSnippet >> snippetType [
	^ GtCoderSnippetType of: self
]

{ #category : #accessing }
GtViewModelSnippet >> sourceCode [
	^ self text asString
]

{ #category : #accessing }
GtViewModelSnippet >> sourceCode: aString [
	coder currentSourceString: aString
]

{ #category : #'private - text' }
GtViewModelSnippet >> splitTextAt: aSplitIndex [
	"Return a part that is deleted"
	| aDeletedPart anUpdatedText |

	aDeletedPart := self text copyFrom: aSplitIndex + 1 to: self text size.
	aDeletedPart ifEmpty: [ ^ aDeletedPart ].
	aDeletedPart trimmer leftLineBreaks; trim.
	
	anUpdatedText := coder sourceText copy.
	anUpdatedText delete: aSplitIndex + 1 to: self text size.
	anUpdatedText trimmer rightLineBreaks; trim.
	
	coder currentSourceText: anUpdatedText.
	
	^ aDeletedPart
]

{ #category : #converting }
GtViewModelSnippet >> stencilBuilderClass [
	"Return a stencil builder class that knows how to display a snippet in Bloc"
	<return: #GtSnippetStencilBuilder>
	^ nil
]

{ #category : #accessing }
GtViewModelSnippet >> text [
	<return: #BlText>
	^ coder sourceCode sourceText
]

{ #category : #private }
GtViewModelSnippet >> textEditor [
	^ coder sourceEditor
]

{ #category : #accessing }
GtViewModelSnippet >> variableBindings [
	^ GtNoBindings uniqueInstance
]

{ #category : #accessing }
GtViewModelSnippet >> variableBindings: aGtPlaygroundBindings [
]

{ #category : #'as yet unclassified' }
GtViewModelSnippet >> xDocLoadSavedContent [
	"Load the saved content from the XdKeyDocumentStore"
]
