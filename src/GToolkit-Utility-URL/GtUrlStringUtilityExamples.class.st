Class {
	#name : #GtUrlStringUtilityExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Utility-URL-Model'
}

{ #category : #examples }
GtUrlStringUtilityExamples >> fileAbsoluteUrl [
	<gtExample>
	| urlUtility imageReference urlString |

	urlUtility := GtUrlStringUtility rootDirectory: FileLocator imageDirectory resolve.
	imageReference := FileLocator image resolve.
	self deny: (imageReference fullName includes: Character space)
		description: 'This test assumes that image path doesn''t include spaces'.
	urlString := imageReference asZnUrl asString.
	self
		assert: (urlUtility urlString: urlString) url asFileReference
		equals: imageReference.
	^ urlUtility
]

{ #category : #examples }
GtUrlStringUtilityExamples >> fileNoHostAbsoluteUrl [
	<gtExample>
	| urlUtility imageReference urlString |

	urlUtility := GtUrlStringUtility rootDirectory: FileLocator imageDirectory resolve.
	imageReference := FileLocator image resolve.
	self deny: (imageReference fullName includes: Character space)
		description: 'This test assumes that image path doesn''t include spaces'.
	urlString := (imageReference asZnUrl host: 'localhost') asString.
	self
		assert: (urlUtility urlString: urlString) url asFileReference
		equals: imageReference.
	^ urlUtility 
]

{ #category : #examples }
GtUrlStringUtilityExamples >> fileNoHostRelativeUrl [
	<gtExample>
	| urlUtility imageBasename imageReference urlString |

	urlUtility := GtUrlStringUtility rootDirectory: FileLocator imageDirectory resolve.
	imageBasename := FileLocator image basename.
	imageReference := urlUtility rootDirectory / imageBasename.
	self deny: (imageReference fullName includes: Character space)
		description: 'This test assumes that image path doesn''t include spaces'.
	urlString := 'file:///', imageBasename.
	self
		assert: (urlUtility urlString: urlString) url asFileReference
		equals: imageReference.
	^ urlUtility
]

{ #category : #examples }
GtUrlStringUtilityExamples >> fileNoSchemeAbsoluteUrl [
	<gtExample>
	| urlUtility imageReference |

	urlUtility := GtUrlStringUtility rootDirectory: FileLocator imageDirectory resolve.
	imageReference := FileLocator image resolve asAbsolute.
	self
		assert: (urlUtility urlString: imageReference fullName) url asFileReference
		equals: imageReference.
	^ urlUtility 
]

{ #category : #examples }
GtUrlStringUtilityExamples >> fileNoSchemeRelativeUrl [
	<gtExample>
	| urlUtility imageName |

	urlUtility := GtUrlStringUtility rootDirectory: FileLocator imageDirectory resolve.
	imageName := FileLocator image basename.
	self
		assert: (urlUtility urlString: imageName) url asFileReference
		equals: FileLocator image resolve.
	^ urlUtility
]

{ #category : #examples }
GtUrlStringUtilityExamples >> fileRelativeUrl [
	<gtExample>
	| urlUtility imageName |

	urlUtility := GtUrlStringUtility rootDirectory: FileLocator imageDirectory resolve.
	imageName := FileLocator image basename.
	self
		assert: (urlUtility urlString: 'file:///', imageName) url asFileReference
		equals: FileLocator image resolve.
	^ urlUtility
]
