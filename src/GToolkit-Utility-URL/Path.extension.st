Extension { #name : #Path }

{ #category : #'*GToolkit-Utility-URL' }
Path >> asZnRelativeUrl [
	"Convert the receiver in a file:// ZnUrl.
	Note that this breaks the standard, however is useful for constructing custom URLs using different schemes."
	| fileUrl |

	fileUrl := ZnUrl new.
	fileUrl scheme: #file.
	self do: [ :each | fileUrl addPathSegment: each ].
	^ fileUrl
]
