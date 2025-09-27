Class {
	#name : #GtGhIssue,
	#superclass : #GtGhEntity,
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #accessing }
GtGhIssue >> body [
	^ self rawData at: #body
]

{ #category : #'gt - extensions' }
GtGhIssue >> gtActionWebBrowseFor: anAction [
    <gtAction>
    ^ anAction explicit stencil: [
        BrButton new
            aptitude: BrGlamorousButtonWithIconAptitude;
            action:  [ WebBrowser openOn: self htmlUrlString asZnUrl ];
            icon: BrGlamorousVectorIcons web;
            label: 'Open in browser' translated ]
]

{ #category : #'gt - extensions' }
GtGhIssue >> gtViewIssueBodyFor: aView [ 
	<gtView>
	
	^ aView explicit
		title: 'Body';
		stencil: [
			BrEditor new
				beReadOnlyWithSelection;
				aptitude: BrGlamorousRegularEditorAptitude;
				styler: LeSnippetStyler new;
				hMatchParent;
				vFitContentLimited;
				text: self body ]
]

{ #category : #accessing }
GtGhIssue >> htmlUrlString [
	^ self rawData at: #html_url
]

{ #category : #accessing }
GtGhIssue >> number [
	^ self rawData at: #number
]

{ #category : #printing }
GtGhIssue >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< self shortReference;
			<< ', ';
			<< self title]
]

{ #category : #accessing }
GtGhIssue >> shortReference [
	| url|
	url := self htmlUrlString asZnUrl.
	^ '{1}/{2}#{3}' format: {
		url segments first.
		url segments second.
		url segments fourth }
]

{ #category : #accessing }
GtGhIssue >> state [
	^ self rawData at: #state
]

{ #category : #accessing }
GtGhIssue >> title [
	^ self rawData at: #title
]
