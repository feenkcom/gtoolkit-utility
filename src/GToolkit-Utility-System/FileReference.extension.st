Extension { #name : #FileReference }

{ #category : #'*GToolkit-Utility-System' }
FileReference >> osCopyTo: aFileReference [
	"Copy the receiver and create the argument, a file reference.
	If you want to copy a file from a folder into a given folder, the argument should not be the future parent folder but a file reference of the future location.  
	Therefore use 
		(folder1 / 'foo.txt') copyTo: (folder2 / 'bar.txt')"
		
	self isDirectory
		ifTrue: [ aFileReference ensureCreateDirectory ]
		ifFalse: [ filesystem osCopy: path toReference: aFileReference ]
]
