Extension { #name : #FileLocator }

{ #category : #'*GToolkit-Utility-Resources' }
FileLocator class >> gtLocations [
	^ self supportedOrigins 
		collect: [ :aSelector | self perform: aSelector ]
		as: Array
]

{ #category : #'*GToolkit-Utility-Resources' }
FileLocator class >> gtResource [
	^ self origin: #gtResource
]

{ #category : #'*GToolkit-Utility-Resources' }
FileLocator >> parent [
	<gtPharoPatch: #Pharo>
	
	^ GtResourceClosestFileLocator new
		file: self resolve parent;
		transform
]
