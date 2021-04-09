Trait {
	#name : #TGtNavigationPropertyForParentTemplate,
	#category : #'GToolkit-MVVM-ViewModel-Generator'
}

{ #category : #testing }
TGtNavigationPropertyForParentTemplate >> has__Property_status____Property_object__ [
	<return: #Boolean>

	^ self hasSelectedPackageViewModel and: [ self selectedPackageViewModel hasSelectedPackageTagViewModel ]
]
