Extension { #name : #FileLocator }

{ #category : #'*GToolkit-Utility-URL' }
FileLocator >> asFileLocatorUrl [ 
	"Convert the receiver in a ZnURL of the form fileLocator://<origin>/path"

	^ self path asZnRelativeUrl 
		scheme: #filelocator;
		host: origin;
		yourself
]
