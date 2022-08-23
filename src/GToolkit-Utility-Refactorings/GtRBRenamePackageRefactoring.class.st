Class {
	#name : #GtRBRenamePackageRefactoring,
	#superclass : #RBRefactoring,
	#instVars : [
		'oldName',
		'newName'
	],
	#category : #'GToolkit-Utility-Refactorings-Refactorings'
}

{ #category : #'instance creation' }
GtRBRenamePackageRefactoring class >> from: oldName to: newName [
	^ self new
		from: oldName to: newName;
		yourself
]

{ #category : #'initialize-release' }
GtRBRenamePackageRefactoring >> from: oldPackageName to: newPackageName [
	oldName := oldPackageName.
	newName := newPackageName
]

{ #category : #accessing }
GtRBRenamePackageRefactoring >> preconditions [
	^ ((RBCondition
		withBlock: [ (RPackage organizer packageNamed: oldName asSymbol ifAbsent: [  ])
				notNil ]) errorMacro: 'Package ' , oldName , ' does not exist')
		&
			((RBCondition
				withBlock: [ (RPackage organizer packageNamed: newName asSymbol ifAbsent: [  ])
						isNil ]) errorMacro: 'Package ' , newName , ' already exists')
]

{ #category : #transforming }
GtRBRenamePackageRefactoring >> renameBaselineReferences [
	| rewriter baselineClass |
	baselineClass := self model classNamed: #BaselineOf.
	baselineClass isNil ifTrue: [ ^ self ].
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: oldName asString storeString
		with: newName asString storeString.
	baselineClass withAllSubclasses
		do: [ :each | 
			(each whichSelectorsReferToSymbol: oldName asString)
				do: [ :sel | 
					| method |
					method := each methodFor: sel.
					(rewriter executeTree: method ast)
						ifTrue: [ method compileTree: rewriter tree ] ] ]
]

{ #category : #transforming }
GtRBRenamePackageRefactoring >> renamePackage [
	self model changes
		addChange: (GtRBRenamePackageChange from: oldName to: newName)
]

{ #category : #transforming }
GtRBRenamePackageRefactoring >> transform [
	self renamePackage.
	self renameBaselineReferences
]
