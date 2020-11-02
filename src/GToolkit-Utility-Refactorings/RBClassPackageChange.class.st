Class {
	#name : #RBClassPackageChange,
	#superclass : #RBClassCategoryChange,
	#category : #'GToolkit-Utility-Refactorings-Changes'
}

{ #category : #private }
RBClassPackageChange >> primitiveExecute [
	| class |
	class := self changeClass.
	class classInstaller
		update: class
		to: [ :builder | 
			builder
				fillFor: class;
				category: category ]
]
