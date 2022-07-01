Class {
	#name : #GtGhFeenkOrganisation,
	#superclass : #GtGhOrganisation,
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #'api - instantiation' }
GtGhFeenkOrganisation class >> create [ 
	^ self forLogin: self loginName
]

{ #category : #accessing }
GtGhFeenkOrganisation class >> loginName [
	^ 'feenkcom'
]

{ #category : #accessing }
GtGhFeenkOrganisation >> glamorousToolkitRepository [ 
	^ self repositoryNamed: 'gtoolkit'
]
