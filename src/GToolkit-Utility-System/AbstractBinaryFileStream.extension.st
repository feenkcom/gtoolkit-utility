Extension { #name : #AbstractBinaryFileStream }

{ #category : #'*GToolkit-Utility-System' }
AbstractBinaryFileStream >> edit [
	"Create and schedule an editor on this file."

	Smalltalk tools fileList openEditorOn: self editString: nil.

]

{ #category : #'*GToolkit-Utility-System' }
AbstractBinaryFileStream >> fullName [
	^ self file name 
]
