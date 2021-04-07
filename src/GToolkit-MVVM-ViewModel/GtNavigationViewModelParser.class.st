Class {
	#name : #GtNavigationViewModelParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelParser class >> ambiguousTransitions [
^#(
#[ 0 34 0 81]
	).
]

{ #category : #'generated-accessing' }
GtNavigationViewModelParser class >> cacheId [
	^'2021-04-07T14:07:21.544358+02:00'
]

{ #category : #generated }
GtNavigationViewModelParser class >> definitionComment [
"%glr;
%root Program;
%prefix GtNavigationViewModel;
%suffix Node;
%hierarchy PropertyValue (SymbolPropertyValue);
%hierarchy Level (SimpleLevel CompositeLevel NestedLevel);
%hierarchy SimpleLevel (LevelForOne LevelForMany);
%hierarchy Hierarchy (HierarchyError);
%start Hierarchy FullDefinition;
%id <name><and><follows>;


default <leftBrace>
	: \{
	;
default <rightBrace>
	: \}
	;
default literalArray <name>
	:  (<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) *
	;
default literalArray <follows>
	: =>
	;
default literalArray <whitespace>
	: (\s | \x0)+
	;
default literalArray <rightParen>
	: \)
	;
default literalArray <leftParen>
	: \(
	;
default literalArray <period>
	: \.
	;
default <colon>
	: \:
	;
default literalArray <comma>
	: \,
	;
default literalArray <symbol>
	: \#{1,2} ( <name> (\:\: <name>)* | <binary> | <keyword>+ | <string> )
	;
default literalArray <binary>
	: [\~\-\!\@\%\&\*\+\=\\\|\?\/\>\<\,] +
	;
default <keyword>
	: <name> \:
	;
default literalArray <string>
	: ( \' [^\']* \' )+
	;
default literalArray <and>
	: and
	;
default <lt>
	: \<
	;
default <gt>
	: \>
	;
LevelForOne
	: <name> 'name' {{}}
	;
LevelForMany
	: <name> 'name' <leftParen><name>'suffix'<rightParen> {{}}
	;
SimpleLevel
	: LevelForOne
	| LevelForMany
	;
CompositeLevel
	: SimpleLevel'item' <and>'and' SimpleLevel 'item' {{}}
	;
NestedLevel
	: SimpleLevel'parentLevel' <follows>'follows' NestedLevel'childLevel' {{}}
	| SimpleLevel'parentLevel' <follows>'follows' SimpleLevel'childLevel' {{}}
	| SimpleLevel'parentLevel' <follows>'follows' CompositeLevel'childLevel' {{}}
	;
Level
	: SimpleLevel
	| CompositeLevel
	| NestedLevel
	| NestedBranchingLevel
	;
Hierarchy
	: Level'level'<period>? {{}}
	;
PropertyValue
	: SymbolPropertyValue
	;
SymbolPropertyValue
	: <symbol> 'value' {{}}
	;
ModelAnnotation
	: <lt><name>'name'<gt> {{}}
	;
Property
	: PropertyName'name'<colon>PropertyValue 'value' {{}}
	;
PropertiesList
	: Property 'property'
	| PropertiesList<comma>Property'property'
	;
Properties
	: PropertiesList <comma>? {{}}
	;
Definition
	: Level'level' ModelAnnotation'model'? {{}}
	| Level'level' ModelAnnotation'model'? <leftBrace>Properties'properties'<rightBrace> {{}}
	;
DefinitionList
	: Definition'definition'
	| DefinitionList <period>Definition'definition'
	;
Definitions
	: DefinitionList<period>? {{}}
	;
FullDefinition
	: Hierarchy 'hierarchy' {{}}
	| Hierarchy'hierarchy'<period>Definitions'definitions' {{}}
	;
PropertyName
	: <name> 'name' <leftParen><name>'suffix'<rightParen> {{}}
	| <name> 'name' {{}}
	;"
]

{ #category : #generated }
GtNavigationViewModelParser class >> reduceTable [
^#(
	#(17 1 #reduceActionForLevelForOne1: 1122305 false ) 
	#(22 1 #liftFirstValue: 1612804 false ) 
	#(19 1 #liftFirstValue: 1238017 false ) 
	#(19 1 #liftFirstValue: 1238018 false ) 
	#(22 1 #liftFirstValue: 1612801 false ) 
	#(22 1 #liftFirstValue: 1612802 false ) 
	#(22 1 #liftFirstValue: 1612803 false ) 
	#(23 1 #reduceActionForHierarchy1: 1695745 false ) 
	#(33 1 #reduceActionForFullDefinition1: 2377729 false ) 
	#(23 2 #reduceActionForHierarchy1: 1695746 false ) 
	#(21 3 #reduceActionForNestedLevel2: 1360898 false ) 
	#(21 3 #reduceActionForNestedLevel2: 1360899 false ) 
	#(21 3 #reduceActionForNestedLevel2: 1360897 false ) 
	#(20 3 #reduceActionForCompositeLevel1: 1285121 false ) 
	#(30 1 #reduceActionForDefinition1: 2080769 false ) 
	#(31 1 #reduceActionForDefinitionList1: 2234369 false ) 
	#(32 1 #reduceActionForDefinitions1: 2329601 false ) 
	#(33 3 #reduceActionForFullDefinition2: 2377730 false ) 
	#(18 4 #reduceActionForLevelForMany1: 1160193 false ) 
	#(30 2 #reduceActionForDefinition2: 2080770 false ) 
	#(32 2 #reduceActionForDefinitions1: 2329602 false ) 
	#(34 1 #reduceActionForPropertyName2: 2489346 false ) 
	#(28 1 #reduceActionForDefinitionList1: 1947649 false ) 
	#(29 1 #reduceActionForProperties1: 2033665 false ) 
	#(31 3 #reduceActionForDefinitionList2: 2234370 false ) 
	#(29 2 #reduceActionForProperties1: 2033666 false ) 
	#(30 4 #reduceActionForDefinition3: 2080771 false ) 
	#(26 3 #reduceActionForModelAnnotation1: 1829889 false ) 
	#(28 3 #reduceActionForDefinitionList2: 1947650 false ) 
	#(25 1 #reduceActionForSymbolPropertyValue1: 1780737 false ) 
	#(27 3 #reduceActionForProperty1: 1879041 false ) 
	#(24 1 #liftFirstValue: 1739777 false ) 
	#(30 5 #reduceActionForDefinition4: 2080772 false ) 
	#(34 4 #reduceActionForPropertyName1: 2489345 false )
	).
]

{ #category : #generated }
GtNavigationViewModelParser class >> scannerClass [
	^GtNavigationViewModelScanner
]

{ #category : #generated }
GtNavigationViewModelParser class >> startingStateForFullDefinition [
	^ 3
]

{ #category : #generated }
GtNavigationViewModelParser class >> startingStateForHierarchy [
	^ 2
]

{ #category : #generated }
GtNavigationViewModelParser class >> startingStateForLevelForOne [
	^ 1
]

{ #category : #generated }
GtNavigationViewModelParser class >> symbolNames [
	^ #('<leftBrace>' '<rightBrace>' '<name>' '<follows>' '<whitespace>' '<rightParen>' '<leftParen>' '<period>' '<colon>' '<comma>' '<symbol>' '<and>' '<lt>' '<gt>' 'B e g i n' 'NestedBranchingLevel' 'LevelForOne' 'LevelForMany' 'SimpleLevel' 'CompositeLevel' 'NestedLevel' 'Level' 'Hierarchy' 'PropertyValue' 'SymbolPropertyValue' 'ModelAnnotation' 'Property' 'PropertiesList' 'Properties' 'Definition' 'DefinitionList' 'Definitions' 'FullDefinition' 'PropertyName' 'E O F' 'error')
]

{ #category : #generated }
GtNavigationViewModelParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtNavigationViewModelLevelForOneNode #Object #GtNavigationViewModelLevelForOneNode #GtNavigationViewModelLevelForManyNode #GtNavigationViewModelSimpleLevelNode #GtNavigationViewModelCompositeLevelNode #GtNavigationViewModelNestedLevelNode #GtNavigationViewModelLevelNode #GtNavigationViewModelHierarchyNode #GtNavigationViewModelSymbolPropertyValueNode #GtNavigationViewModelSymbolPropertyValueNode #GtNavigationViewModelModelAnnotationNode #GtNavigationViewModelPropertyNode #OrderedCollection #GtNavigationViewModelPropertiesNode #GtNavigationViewModelDefinitionNode #OrderedCollection #GtNavigationViewModelDefinitionsNode #GtNavigationViewModelFullDefinitionNode #GtNavigationViewModelPropertyNameNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtNavigationViewModelParser class >> transitionTable [
^#(
#[1 0 17 0 3 0 21 0 17] 
#[1 0 25 0 3 0 53 0 16 0 41 0 17 0 41 0 18 0 41 0 19 0 53 0 20 0 53 0 21 0 53 0 22 0 57 0 23] 
#[1 0 25 0 3 0 53 0 16 0 41 0 17 0 41 0 18 0 41 0 19 0 53 0 20 0 53 0 21 0 53 0 22 0 61 0 23 0 65 0 33] 
#[0 0 6 0 35] 
#[0 0 0 0 35] 
#[1 0 6 0 1 0 6 0 4 0 69 0 7 0 6 0 8 0 6 0 12 0 6 0 13 0 6 0 35] 
#[0 0 10 0 1 0 8 0 13 0 35] 
#[0 0 14 0 1 0 4 0 8 0 12 0 13 0 35] 
#[0 0 18 0 1 0 4 0 8 0 12 0 13 0 35] 
#[1 0 22 0 1 0 73 0 4 0 22 0 8 0 77 0 12 0 22 0 13 0 22 0 35] 
#[0 0 26 0 1 0 8 0 13 0 35] 
#[0 0 30 0 1 0 8 0 13 0 35] 
#[1 0 7 0 8 0 34 0 35] 
#[0 0 0 0 35] 
#[1 0 85 0 8 0 38 0 35] 
#[0 0 0 0 35] 
#[0 0 89 0 3] 
#[1 0 25 0 3 0 93 0 17 0 93 0 18 0 93 0 19 0 97 0 20 0 101 0 21] 
#[1 0 25 0 3 0 105 0 17 0 105 0 18 0 105 0 19] 
#[0 0 42 0 8 0 35] 
#[1 0 25 0 3 0 109 0 16 0 41 0 17 0 41 0 18 0 41 0 19 0 109 0 20 0 109 0 21 0 109 0 22 0 113 0 30 0 117 0 31 0 121 0 32] 
#[0 0 125 0 6] 
#[1 0 46 0 1 0 73 0 4 0 46 0 8 0 77 0 12 0 46 0 13 0 46 0 35] 
#[0 0 50 0 1 0 8 0 13 0 35] 
#[0 0 54 0 1 0 8 0 13 0 35] 
#[0 0 58 0 1 0 8 0 13 0 35] 
#[1 0 129 0 1 0 62 0 8 0 133 0 13 0 137 0 26 0 62 0 35] 
#[0 0 66 0 8 0 35] 
#[1 0 141 0 8 0 70 0 35] 
#[0 0 74 0 35] 
#[0 0 78 0 1 0 4 0 8 0 12 0 13 0 35] 
#[1 0 145 0 3 0 149 0 27 0 153 0 28 0 157 0 29 0 161 0 34] 
#[0 0 165 0 3] 
#[1 0 169 0 1 0 82 0 8 0 82 0 35] 
#[1 0 25 0 3 0 109 0 16 0 41 0 17 0 41 0 18 0 41 0 19 0 109 0 20 0 109 0 21 0 109 0 22 0 173 0 30 0 86 0 35] 
#[1 0 177 0 7 0 90 0 9] 
#[0 0 94 0 2 0 10] 
#[1 0 98 0 2 0 181 0 10] 
#[0 0 185 0 2] 
#[0 0 189 0 9] 
#[0 0 193 0 14] 
#[1 0 145 0 3 0 149 0 27 0 153 0 28 0 197 0 29 0 161 0 34] 
#[0 0 102 0 8 0 35] 
#[0 0 201 0 3] 
#[1 0 106 0 2 0 145 0 3 0 205 0 27 0 161 0 34] 
#[0 0 110 0 8 0 35] 
#[1 0 209 0 11 0 213 0 24 0 213 0 25] 
#[0 0 114 0 1 0 8 0 35] 
#[0 0 221 0 2] 
#[0 0 225 0 6] 
#[0 0 118 0 2 0 10] 
#[0 0 122 0 2 0 10] 
#[0 0 126 0 2 0 10] 
#[0 0 130 0 2 0 10] 
#[0 0 134 0 8 0 35] 
#[0 0 138 0 9]
	).
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForCompositeLevel1: nodes [
	| result |
	result := GtNavigationViewModelCompositeLevelNode new.
	result addNode: (nodes at: 1) to: result items.
	result and: (nodes at: 2).
	result addNode: (nodes at: 3) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForDefinition1: nodes [
	| result |
	result := GtNavigationViewModelDefinitionNode new.
	result level: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForDefinition2: nodes [
	| result |
	result := GtNavigationViewModelDefinitionNode new.
	result level: (nodes at: 1).
	result model: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForDefinition3: nodes [
	| result |
	result := GtNavigationViewModelDefinitionNode new.
	result level: (nodes at: 1).
	result properties: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForDefinition4: nodes [
	| result |
	result := GtNavigationViewModelDefinitionNode new.
	result level: (nodes at: 1).
	result model: (nodes at: 2).
	result properties: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForDefinitionList1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForDefinitionList2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 3) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForDefinitions1: nodes [
	| result |
	result := GtNavigationViewModelDefinitionsNode new.
	result addNodes: (nodes at: 1) to: result definitions.
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForFullDefinition1: nodes [
	| result |
	result := GtNavigationViewModelFullDefinitionNode new.
	result hierarchy: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForFullDefinition2: nodes [
	| result |
	result := GtNavigationViewModelFullDefinitionNode new.
	result hierarchy: (nodes at: 1).
	result definitions: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForHierarchy1: nodes [
	| result |
	result := GtNavigationViewModelHierarchyNode new.
	result level: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForLevelForMany1: nodes [
	| result |
	result := GtNavigationViewModelLevelForManyNode new.
	result name: (nodes at: 1).
	result suffix: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForLevelForOne1: nodes [
	| result |
	result := GtNavigationViewModelLevelForOneNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForModelAnnotation1: nodes [
	| result |
	result := GtNavigationViewModelModelAnnotationNode new.
	result name: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForNestedLevel2: nodes [
	| result |
	result := GtNavigationViewModelNestedLevelNode new.
	result parentLevel: (nodes at: 1).
	result follows: (nodes at: 2).
	result childLevel: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForProperties1: nodes [
	| result |
	result := GtNavigationViewModelPropertiesNode new.
	result addNodes: (nodes at: 1) to: result properties.
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForProperty1: nodes [
	| result |
	result := GtNavigationViewModelPropertyNode new.
	result name: (nodes at: 1).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForPropertyName1: nodes [
	| result |
	result := GtNavigationViewModelPropertyNameNode new.
	result name: (nodes at: 1).
	result suffix: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForPropertyName2: nodes [
	| result |
	result := GtNavigationViewModelPropertyNameNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForSymbolPropertyValue1: nodes [
	| result |
	result := GtNavigationViewModelSymbolPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]
