"
I implement the Levenshtein distance metric as described in [](https://en.wikipedia.org/wiki/Levenshtein_distance#Iterative_with_two_matrix_rows) as a class-side metrics.

My implementation respects the original variable names to ease comparison. The main difference is that arrays in Smalltalk start at 1 whereas in the reference algorithm they start at 0, so some (but not all) accesses have to be offset by 1.

Usage:

```
GtLevenshtein distanceBetween: 'foo' and: 'bar'
```

"
Class {
	#name : #GtLevenshtein,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Algorithms-EditDistance'
}

{ #category : #algorithm }
GtLevenshtein class >> distanceBetween: s and: t [
	"The algorithm and variable names are taken from 
		https://en.wikipedia.org/wiki/Levenshtein_distance#Iterative_with_two_matrix_rows
	NB: in the wikpedia version arrays start from 0, but here they start from 1,
	so the lookups need to be offset by 1 is certain cases only."

	| m n v0 v1 |
	m := s size.
	n := t size.
	v0 := Array new: 1 + n.
	v1 := Array new: 1 + n.
	1 to: n + 1 do: [ :i | v0 at: i put: i - 1 ].	"NB: We start at position 1, not 0, but the values we put start with 0."
	1
		to: m
		do: [ :i | 
			| tmp |
			v1 at: 1 put: i.	"Again, starting at 1, not 0, but the values we put start with 1."
			1
				to: n
				do: [ :j | 
					| deletionCost insertionCost substitutionCost |
					deletionCost := (v0 at: j + 1) + 1.	"We still need to offset the lookup."
					insertionCost := (v1 at: j) + 1.
					(s at: i) = (t at: j)
						ifTrue: [ substitutionCost := v0 at: j ]
						ifFalse: [ substitutionCost := (v0 at: j) + 1 ].
					v1
						at: j + 1
						put: {deletionCost.
								insertionCost.
								substitutionCost} min ].
			tmp := v0.
			v0 := v1.
			v1 := tmp ].
	^ v0 at: n + 1
]
