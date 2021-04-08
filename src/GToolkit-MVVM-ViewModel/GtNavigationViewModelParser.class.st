Class {
	#name : #GtNavigationViewModelParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelParser class >> ambiguousTransitions [
^#(
#[ 0 34 0 93]
	).
]

{ #category : #'generated-accessing' }
GtNavigationViewModelParser class >> cacheId [
	^'2021-04-07T21:56:22.682355+02:00'
]

{ #category : #generated }
GtNavigationViewModelParser class >> definitionComment [
"%glr;
%root Program;
%prefix GtNavigationViewModel;
%suffix Node;
%hierarchy PropertyValue (SymbolPropertyValue GlobalPropertyValue);
%hierarchy Level (SimpleLevel CompositeLevel NestedLevel);
%hierarchy SimpleLevel (LevelForOne LevelForMany);
%hierarchy Hierarchy (HierarchyError);
%start Hierarchy FullDefinition;
%id <name><and><follows>;
%hierarchy Property (GenericProperty NameProperty ItemsProperty);


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
default literalArray <nameToken>
	: name
	;
default literalArray <itemsToken>
	: items
	;
<at>
	: \@
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
	| GlobalPropertyValue
	;
SymbolPropertyValue
	: <symbol> 'value' {{}}
	;
ModelAnnotation
	: <lt><name>'name'<gt> {{}}
	| <lt><name>'name'<colon><colon><name>'api'<gt> {{}}
	;
Property
	: NameProperty
	| ItemsProperty
	| GenericProperty
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
	: Settings 'settings'? Hierarchy 'hierarchy' {{}}
	| Settings 'settings'? Hierarchy'hierarchy'<period>Definitions'definitions' {{}}
	;
PropertyName
	: <name> 'name' <leftParen><name>'suffix'<rightParen> {{}}
	| <name> 'name' {{}}
	;
NameProperty
	: <nameToken>'name'<colon>GlobalPropertyValue 'value' {{}}
	;
GenericProperty
	: PropertyName'name'<colon>PropertyValue 'value' {{}}
	;
GlobalPropertyValue
	: <name> 'value' {{}}
	;
ItemsProperty
	: <itemsToken>'name'<colon>SymbolPropertyValue 'value' {{}}
	;
Setting
	: <at>'at'<name>'name' PropertyValue'value' {{}}
	;
Settings
	: Setting 'setting' {{}}
	| Settings Setting 'setting' {{}}
	;"
]

{ #category : #generated }
GtNavigationViewModelParser class >> reduceTable [
^#(
	#(20 1 #reduceActionForLevelForOne1: 1316865 false ) 
	#(25 1 #liftFirstValue: 1807364 false ) 
	#(22 1 #liftFirstValue: 1432577 false ) 
	#(22 1 #liftFirstValue: 1432578 false ) 
	#(25 1 #liftFirstValue: 1807361 false ) 
	#(25 1 #liftFirstValue: 1807362 false ) 
	#(25 1 #liftFirstValue: 1807363 false ) 
	#(26 1 #reduceActionForHierarchy1: 1890305 false ) 
	#(36 1 #reduceActionForFullDefinition1: 2648065 false ) 
	#(43 1 #reduceActionForSettings1: 3246081 false ) 
	#(26 2 #reduceActionForHierarchy1: 1890306 false ) 
	#(36 2 #reduceActionForFullDefinition2: 2648066 false ) 
	#(43 2 #reduceActionForSettings2: 3246082 false ) 
	#(24 3 #reduceActionForNestedLevel2: 1555458 false ) 
	#(24 3 #reduceActionForNestedLevel2: 1555459 false ) 
	#(24 3 #reduceActionForNestedLevel2: 1555457 false ) 
	#(23 3 #reduceActionForCompositeLevel1: 1479681 false ) 
	#(40 1 #reduceActionForGlobalPropertyValue1: 3056641 false ) 
	#(28 1 #reduceActionForSymbolPropertyValue1: 1998849 false ) 
	#(42 3 #reduceActionForSetting1: 3183617 false ) 
	#(27 1 #liftFirstValue: 1934337 false ) 
	#(27 1 #liftFirstValue: 1934338 false ) 
	#(33 1 #reduceActionForDefinition1: 2351105 false ) 
	#(34 1 #reduceActionForDefinitionList1: 2504705 false ) 
	#(35 1 #reduceActionForDefinitions1: 2599937 false ) 
	#(36 3 #reduceActionForFullDefinition3: 2648067 false ) 
	#(21 4 #reduceActionForLevelForMany1: 1354753 false ) 
	#(33 2 #reduceActionForDefinition2: 2351106 false ) 
	#(35 2 #reduceActionForDefinitions1: 2599938 false ) 
	#(36 4 #reduceActionForFullDefinition4: 2648068 false ) 
	#(37 1 #reduceActionForPropertyName2: 2802690 false ) 
	#(31 1 #reduceActionForDefinitionList1: 2217985 false ) 
	#(32 1 #reduceActionForProperties1: 2304001 false ) 
	#(30 1 #liftFirstValue: 2152449 false ) 
	#(30 1 #liftFirstValue: 2152451 false ) 
	#(30 1 #liftFirstValue: 2152450 false ) 
	#(34 3 #reduceActionForDefinitionList2: 2504706 false ) 
	#(32 2 #reduceActionForProperties1: 2304002 false ) 
	#(33 4 #reduceActionForDefinition3: 2351107 false ) 
	#(29 3 #reduceActionForModelAnnotation1: 2048001 false ) 
	#(38 3 #reduceActionForNameProperty1: 2903041 false ) 
	#(41 3 #reduceActionForItemsProperty1: 3103745 false ) 
	#(31 3 #reduceActionForDefinitionList2: 2217986 false ) 
	#(39 3 #reduceActionForGenericProperty1: 2980865 false ) 
	#(33 5 #reduceActionForDefinition4: 2351108 false ) 
	#(37 4 #reduceActionForPropertyName1: 2802689 false ) 
	#(29 6 #reduceActionForModelAnnotation2: 2048002 false )
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
	^ #('<leftBrace>' '<rightBrace>' '<name>' '<follows>' '<whitespace>' '<rightParen>' '<leftParen>' '<period>' '<colon>' '<comma>' '<symbol>' '<and>' '<lt>' '<gt>' '<nameToken>' '<itemsToken>' '<at>' 'B e g i n' 'NestedBranchingLevel' 'LevelForOne' 'LevelForMany' 'SimpleLevel' 'CompositeLevel' 'NestedLevel' 'Level' 'Hierarchy' 'PropertyValue' 'SymbolPropertyValue' 'ModelAnnotation' 'Property' 'PropertiesList' 'Properties' 'Definition' 'DefinitionList' 'Definitions' 'FullDefinition' 'PropertyName' 'NameProperty' 'GenericProperty' 'GlobalPropertyValue' 'ItemsProperty' 'Setting' 'Settings' 'E O F' 'error')
]

{ #category : #generated }
GtNavigationViewModelParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtNavigationViewModelLevelForOneNode #Object #GtNavigationViewModelLevelForOneNode #GtNavigationViewModelLevelForManyNode #GtNavigationViewModelSimpleLevelNode #GtNavigationViewModelCompositeLevelNode #GtNavigationViewModelNestedLevelNode #GtNavigationViewModelLevelNode #GtNavigationViewModelHierarchyNode #GtNavigationViewModelPropertyValueNode #GtNavigationViewModelSymbolPropertyValueNode #GtNavigationViewModelModelAnnotationNode #GtNavigationViewModelPropertyNode #OrderedCollection #GtNavigationViewModelPropertiesNode #GtNavigationViewModelDefinitionNode #OrderedCollection #GtNavigationViewModelDefinitionsNode #GtNavigationViewModelFullDefinitionNode #GtNavigationViewModelPropertyNameNode #GtNavigationViewModelNamePropertyNode #GtNavigationViewModelGenericPropertyNode #GtNavigationViewModelGlobalPropertyValueNode #GtNavigationViewModelItemsPropertyNode #GtNavigationViewModelSettingNode #GtNavigationViewModelSettingsNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtNavigationViewModelParser class >> transitionTable [
^#(
#[1 0 17 0 3 0 21 0 20] 
#[1 0 25 0 3 0 53 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 53 0 23 0 53 0 24 0 53 0 25 0 57 0 26] 
#[1 0 25 0 3 0 61 0 17 0 53 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 53 0 23 0 53 0 24 0 53 0 25 0 65 0 26 0 69 0 36 0 73 0 42 0 77 0 43] 
#[0 0 6 0 44] 
#[0 0 0 0 44] 
#[1 0 6 0 1 0 6 0 4 0 81 0 7 0 6 0 8 0 6 0 12 0 6 0 13 0 6 0 44] 
#[0 0 10 0 1 0 8 0 13 0 44] 
#[0 0 14 0 1 0 4 0 8 0 12 0 13 0 44] 
#[0 0 18 0 1 0 4 0 8 0 12 0 13 0 44] 
#[1 0 22 0 1 0 85 0 4 0 22 0 8 0 89 0 12 0 22 0 13 0 22 0 44] 
#[0 0 26 0 1 0 8 0 13 0 44] 
#[0 0 30 0 1 0 8 0 13 0 44] 
#[1 0 7 0 8 0 34 0 44] 
#[0 0 0 0 44] 
#[0 0 97 0 3] 
#[1 0 101 0 8 0 38 0 44] 
#[0 0 0 0 44] 
#[0 0 42 0 3 0 8 0 17 0 44] 
#[1 0 25 0 3 0 61 0 17 0 53 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 53 0 23 0 53 0 24 0 53 0 25 0 105 0 26 0 109 0 42] 
#[0 0 113 0 3] 
#[1 0 25 0 3 0 117 0 20 0 117 0 21 0 117 0 22 0 121 0 23 0 125 0 24] 
#[1 0 25 0 3 0 129 0 20 0 129 0 21 0 129 0 22] 
#[0 0 46 0 8 0 44] 
#[1 0 133 0 3 0 137 0 11 0 141 0 27 0 141 0 28 0 141 0 40] 
#[1 0 25 0 3 0 153 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 153 0 23 0 153 0 24 0 153 0 25 0 157 0 33 0 161 0 34 0 165 0 35] 
#[1 0 169 0 8 0 50 0 44] 
#[0 0 54 0 3 0 8 0 17 0 44] 
#[0 0 173 0 6] 
#[1 0 58 0 1 0 85 0 4 0 58 0 8 0 89 0 12 0 58 0 13 0 58 0 44] 
#[0 0 62 0 1 0 8 0 13 0 44] 
#[0 0 66 0 1 0 8 0 13 0 44] 
#[0 0 70 0 1 0 8 0 13 0 44] 
#[0 0 74 0 2 0 3 0 8 0 10 0 17 0 44] 
#[0 0 78 0 2 0 3 0 8 0 10 0 17 0 44] 
#[0 0 82 0 3 0 8 0 17 0 44] 
#[0 0 86 0 2 0 3 0 8 0 10 0 17 0 44] 
#[0 0 90 0 2 0 3 0 8 0 10 0 17 0 44] 
#[1 0 177 0 1 0 94 0 8 0 181 0 13 0 185 0 29 0 94 0 44] 
#[0 0 98 0 8 0 44] 
#[1 0 189 0 8 0 102 0 44] 
#[0 0 106 0 44] 
#[1 0 25 0 3 0 153 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 153 0 23 0 153 0 24 0 153 0 25 0 157 0 33 0 161 0 34 0 193 0 35] 
#[0 0 110 0 1 0 4 0 8 0 12 0 13 0 44] 
#[1 0 197 0 3 0 201 0 15 0 205 0 16 0 209 0 30 0 213 0 31 0 217 0 32 0 221 0 37 0 209 0 38 0 209 0 39 0 209 0 41] 
#[0 0 237 0 3] 
#[1 0 241 0 1 0 114 0 8 0 114 0 44] 
#[1 0 25 0 3 0 153 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 153 0 23 0 153 0 24 0 153 0 25 0 245 0 33 0 118 0 44] 
#[0 0 122 0 44] 
#[1 0 249 0 7 0 126 0 9] 
#[0 0 253 0 9] 
#[0 1 1 0 9] 
#[0 0 130 0 2 0 10] 
#[1 0 134 0 2 1 5 0 10] 
#[0 1 9 0 2] 
#[0 1 13 0 9] 
#[0 0 138 0 2 0 10] 
#[0 0 142 0 2 0 10] 
#[0 0 146 0 2 0 10] 
#[1 1 17 0 9 1 21 0 14] 
#[1 0 197 0 3 0 201 0 15 0 205 0 16 0 209 0 30 0 213 0 31 1 25 0 32 0 221 0 37 0 209 0 38 0 209 0 39 0 209 0 41] 
#[0 0 150 0 8 0 44] 
#[0 1 29 0 3] 
#[1 0 133 0 3 1 33 0 40] 
#[1 0 137 0 11 1 37 0 28] 
#[1 0 154 0 2 0 197 0 3 0 201 0 15 0 205 0 16 1 41 0 30 0 221 0 37 1 41 0 38 1 41 0 39 1 41 0 41] 
#[0 0 158 0 8 0 44] 
#[1 0 133 0 3 0 137 0 11 1 45 0 27 1 45 0 28 1 45 0 40] 
#[0 1 49 0 9] 
#[0 0 162 0 1 0 8 0 44] 
#[0 1 53 0 2] 
#[0 1 57 0 6] 
#[0 0 166 0 2 0 10] 
#[0 0 170 0 2 0 10] 
#[0 0 174 0 2 0 10] 
#[0 0 178 0 2 0 10] 
#[0 1 61 0 3] 
#[0 0 182 0 8 0 44] 
#[0 0 186 0 9] 
#[0 1 65 0 14] 
#[0 0 190 0 1 0 8 0 44]
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
	result settings: (nodes at: 1).
	result hierarchy: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForFullDefinition3: nodes [
	| result |
	result := GtNavigationViewModelFullDefinitionNode new.
	result hierarchy: (nodes at: 1).
	result definitions: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForFullDefinition4: nodes [
	| result |
	result := GtNavigationViewModelFullDefinitionNode new.
	result settings: (nodes at: 1).
	result hierarchy: (nodes at: 2).
	result definitions: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForGenericProperty1: nodes [
	| result |
	result := GtNavigationViewModelGenericPropertyNode new.
	result name: (nodes at: 1).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForGlobalPropertyValue1: nodes [
	| result |
	result := GtNavigationViewModelGlobalPropertyValueNode new.
	result value: (nodes at: 1).
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
GtNavigationViewModelParser >> reduceActionForItemsProperty1: nodes [
	| result |
	result := GtNavigationViewModelItemsPropertyNode new.
	result name: (nodes at: 1).
	result value: (nodes at: 3).
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
GtNavigationViewModelParser >> reduceActionForModelAnnotation2: nodes [
	| result |
	result := GtNavigationViewModelModelAnnotationNode new.
	result name: (nodes at: 2).
	result api: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForNameProperty1: nodes [
	| result |
	result := GtNavigationViewModelNamePropertyNode new.
	result name: (nodes at: 1).
	result value: (nodes at: 3).
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
GtNavigationViewModelParser >> reduceActionForSetting1: nodes [
	| result |
	result := GtNavigationViewModelSettingNode new.
	result _at: (nodes at: 1).
	result name: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForSettings1: nodes [
	| result |
	result := GtNavigationViewModelSettingsNode new.
	result addNode: (nodes at: 1) to: result settings.
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForSettings2: nodes [
	| result |
	result := nodes at: 1.
	result addNode: (nodes at: 2) to: result settings.
	^ result
]

{ #category : #'generated-reduction actions' }
GtNavigationViewModelParser >> reduceActionForSymbolPropertyValue1: nodes [
	| result |
	result := GtNavigationViewModelSymbolPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]
