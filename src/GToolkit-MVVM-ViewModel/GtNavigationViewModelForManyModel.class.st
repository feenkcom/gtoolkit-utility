Class {
	#name : #GtNavigationViewModelForManyModel,
	#superclass : #GtNavigationViewModelModel,
	#category : #'GToolkit-MVVM-ViewModel-Generator'
}

{ #category : #initialization }
GtNavigationViewModelForManyModel >> initialize [
	super initialize.
	
	model := #OrderedCollection
]
