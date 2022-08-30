Extension { #name : #FileReference }

{ #category : #'*GToolkit-Utility-File' }
FileReference class >> gtNewTempFileLocatorPrefix: prefix suffix: suffix [
	| tmpDir random fileName |
	
	tmpDir := FileLocator temp .
	[ 
		random := UUID new asInteger asString.
		fileName := prefix , random , suffix.
		(tmpDir / fileName) exists ] whileTrue.
	^ tmpDir / fileName
]
