Extension { #name : #Categorizer }

{ #category : #'*GToolkit-Utility-ClassLoader' }
Categorizer >> bulkClassify: aCollection [
	| items index grouping newCategories newStops newElements |
	items := OrderedCollection withAll: aCollection.
	index := 1.
	categoryArray
		with: categoryStops
		do:
			[ :item :last | 
			[ index <= last ]
				whileTrue:
					[ items
						add: {item. elementArray at: index}.
					index := index + 1 ] ].
	grouping := items groupedBy: [ :each | each first ].
	newCategories := grouping keys asSortedCollection asArray.
	index := 0.
	newStops := newCategories collect: [ :each | index := index + (grouping at: each) size ].
	newElements := Array streamContents: [ :stream | 
		newCategories do: [ :each | stream nextPutAll: ((grouping at: each) collect: #second) asSortedCollection ] ].
	categoryArray := newCategories.
	categoryStops := newStops.
	elementArray := newElements
]
