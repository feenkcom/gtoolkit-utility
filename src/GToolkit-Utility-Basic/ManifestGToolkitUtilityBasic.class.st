"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGToolkitUtilityBasic,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Utility-Basic-Manifest'
}

{ #category : #'code-critics' }
ManifestGToolkitUtilityBasic class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#GtMethodsSortFunction #belongsToClass: #false)) #'2020-11-26T12:54:51.370482+01:00') )
]
