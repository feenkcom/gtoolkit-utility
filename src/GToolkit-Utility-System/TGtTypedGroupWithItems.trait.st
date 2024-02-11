Trait {
	#name : #TGtTypedGroupWithItems,
	#traits : 'TGtGroupTypedGrouping + TGtGroupWithItems',
	#classTraits : 'TGtGroupTypedGrouping classTrait + TGtGroupWithItems classTrait',
	#category : #'GToolkit-Utility-System'
}

{ #category : #accessing }
TGtTypedGroupWithItems classSide >> containedType [
	^ self explicitRequirement 
]

{ #category : #accessing }
TGtTypedGroupWithItems >> groupedBy: aBlockClosure [ 
	^ self groupedWithTypeBy: aBlockClosure 
]
