"
GtFileReferenceWithRanges contains a collection of ranges which are highlighted when the source code is inspected.

For example, assuming that we want to highlight a single line at a given column:

[[[ 
'/path/to/source.code' asFileReference asGtFileReferenceWithRanges 
	addStartLine: startLine
	startColumn: startColumn 
	endLine: startLine
	endColumn: 0
]]]

Note that when the startLine and EndLine are the same, an endColumn of 0 indicates that the remainder of the line should be highlighted.
 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables

	highlightRanges:		<Array of GtFileRange>

"
Class {
	#name : #GtFileReferenceWithRanges,
	#superclass : #FileReference,
	#instVars : [
		'highlightRanges'
	],
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
GtFileReferenceWithRanges >> addStartLine: startLineNumber startColumn: startColumnNumber endLine: endLineNumber endColumn: endColumnNumber [

	highlightRanges := highlightRanges copyWith: 
		(GtFileRangeByLineNumber 
			file: self 
			startLine: startLineNumber 
			startColumn: startColumnNumber 
			endLine: endLineNumber 
			endColumn: endColumnNumber)
]

{ #category : #accessing }
GtFileReferenceWithRanges >> firstStartLine [
	"Answer the start line number of the first range"

	^ highlightRanges 
		ifEmpty: [ 0 ]
		ifNotEmpty: [ highlightRanges first startLine ]
]

{ #category : #ui }
GtFileReferenceWithRanges >> gtStyledCodeFor: aView [
	<gtView>
	| parser styler |
	(self isFile
		and: [ (parser := SmaCCParser allSubclasses
				detect: [ :each | each fileExtensions includes: '.' , self extension ]
				ifNone: [  ]) notNil and: [ (styler := parser gtStyler) notNil ] ])
		ifFalse: [ ^ aView empty ].

	^ aView explicit 
		title: 'Code';
		priority: 10;
		stencil: [ | editor |
			editor := BrEditor new
				look: BrGlamorousCodeEditorLook new;
				styler: styler;
				text: self highlightedText;
				yourself.
			self firstStartLine > 5 ifTrue:
				[ editor scrollToPosition: self firstStartLine - 5 ].
			editor ].

]

{ #category : #accessing }
GtFileReferenceWithRanges >> highlightedText [ 
	| text |

	text := self contents asRopedText.
	highlightRanges do: [ :range |
		(text from: range startIndex to: range endIndex)
			attribute: (BlTextHighlightAttribute paint: BrGlamorousColors errorBackgroundColor)
				beNotOverwritableByStyler ].
	^ text
]

{ #category : #initialization }
GtFileReferenceWithRanges >> initialize [ 

	super initialize.
	highlightRanges := #().
]
