Extension { #name : #FinalizationRegistry }

{ #category : #'*GToolkit-Utility-System' }
FinalizationRegistry >> checkIntegrity [
	"Validate that the receiver looks OK.
	Assumes that the receiver is not modified while running the check."

	ephemeronList checkIntegrity
]

{ #category : #'*GToolkit-Utility-System' }
FinalizationRegistry >> hasIntegrity [
	"Answer a boolean indicating the receiver looks OK.
	Assumes that the receiver is not modified while running the check."

	^ ephemeronList hasIntegrity
]
