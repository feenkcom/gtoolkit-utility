Class {
	#name : #GtDeprecatedClassWrappersGroup,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'GToolkit-Utility-Deprecation'
}

{ #category : #adding }
GtDeprecatedClassWrappersGroup >> addAll: aCollection [
	aCollection do: [ :each |
		self add: each ]
]

{ #category : #'accessing - grouping' }
GtDeprecatedClassWrappersGroup >> groupedByPackage [
	^ self groupedBy: [ :aClassWrapper |
		aClassWrapper targetClass package ] 
]

{ #category : #'gt - extensions' }
GtDeprecatedClassWrappersGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Items';
		priority: 10;
		items: [ self items sorted: [ :aClassWrapper |
			aClassWrapper targetClassReferences size  ] descending ];
		column: 'Class' text: [ :aClassWrapper | 
			aClassWrapper targetClass name ];
		column: 'References' text: [ :aClassWrapper | 
			aClassWrapper targetClassReferences size ]
]

{ #category : #'accessing - grouping' }
GtDeprecatedClassWrappersGroup >> gtViewClassesByPackageFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'By package';
		priority: 45;
		items: [ self groupedByPackage associations 
			sorted: [ :assoc | assoc value size ] descending ];
		column: 'Package' text: [ :assoc | assoc key ];
		column: 'Deprecated Classes' text: [ :assoc | assoc value size ];
		column: 'References' text: [ :assoc | assoc value numberOfReferences ];
		send: [ :assoc | assoc value ]
]

{ #category : #accessing }
GtDeprecatedClassWrappersGroup >> numberOfReferences [
	^ self items sumNumbers: [ :aClassWrapper |
		aClassWrapper numberOfReferences ]
]

{ #category : #accessing }
GtDeprecatedClassWrappersGroup >> selectWithNoReferences [
	^ self select: [ :aClass |
		aClass isReferenced not ]
]

{ #category : #accessing }
GtDeprecatedClassWrappersGroup >> sorted: aBlock [
	^ self species 
		withAll: (self items sorted: aBlock)
]
