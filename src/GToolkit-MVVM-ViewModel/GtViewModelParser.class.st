Class {
	#name : #GtViewModelParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelParser class >> ambiguousTransitions [
^#(
#[ 0 34 0 93]
	).
]

{ #category : #'generated-accessing' }
GtViewModelParser class >> cacheId [
	^'2021-04-12T14:23:50.19045+02:00'
]

{ #category : #generated }
GtViewModelParser class >> definitionComment [
"%glr;
%root Program;
%prefix GtViewModel;
%suffix Node;
%hierarchy PropertyValue (SymbolPropertyValue GlobalPropertyValue StringPropertyValue);
%hierarchy Level (SimpleLevel CompositeLevel NestedLevel);
%hierarchy SimpleLevel (LevelForOne LevelForMany);
%hierarchy Hierarchy (HierarchyError);
%start Hierarchy FullDefinition;
%id <and><follows>;
%hierarchy Property (GenericProperty ItemsProperty);


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
	| StringPropertyValue
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
	: ItemsProperty
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
	: <name> 'name' {{}}
	;
GenericProperty
	: PropertyName'name'<colon>PropertyValue 'value' {{}}
	;
GlobalPropertyValue
	: <name> 'value' {{}}
	;
ItemsProperty
	: <itemsToken>'name'<colon>SymbolPropertyValue 'value' {{}}
	| <name> 'name' <leftParen><name>'suffix'<rightParen> <colon>SymbolPropertyValue 'value' {{}}
	;
Setting
	: <at>'at'<name>'name' PropertyValue'value' {{}}
	;
Settings
	: Setting 'setting' {{}}
	| Settings Setting 'setting' {{}}
	;
StringPropertyValue
	: <string> 'value' {{}}
	;"
]

{ #category : #generated }
GtViewModelParser class >> reduceTable [
^#(
	#(20 1 #reduceActionForLevelForOne1: 1262593 false ) 
	#(25 1 #liftFirstValue: 1753092 false ) 
	#(22 1 #liftFirstValue: 1378305 false ) 
	#(22 1 #liftFirstValue: 1378306 false ) 
	#(25 1 #liftFirstValue: 1753089 false ) 
	#(25 1 #liftFirstValue: 1753090 false ) 
	#(25 1 #liftFirstValue: 1753091 false ) 
	#(26 1 #reduceActionForHierarchy1: 1836033 false ) 
	#(36 1 #reduceActionForFullDefinition1: 2600961 false ) 
	#(42 1 #reduceActionForSettings1: 3156993 false ) 
	#(26 2 #reduceActionForHierarchy1: 1836034 false ) 
	#(36 2 #reduceActionForFullDefinition2: 2600962 false ) 
	#(42 2 #reduceActionForSettings2: 3156994 false ) 
	#(24 3 #reduceActionForNestedLevel2: 1501186 false ) 
	#(24 3 #reduceActionForNestedLevel2: 1501187 false ) 
	#(24 3 #reduceActionForNestedLevel2: 1501185 false ) 
	#(23 3 #reduceActionForCompositeLevel1: 1425409 false ) 
	#(39 1 #reduceActionForGlobalPropertyValue1: 2870273 false ) 
	#(28 1 #reduceActionForSymbolPropertyValue1: 1968129 false ) 
	#(43 1 #reduceActionForStringPropertyValue1: 3231745 false ) 
	#(41 3 #reduceActionForSetting1: 3094529 false ) 
	#(27 1 #liftFirstValue: 1880065 false ) 
	#(27 1 #liftFirstValue: 1880067 false ) 
	#(27 1 #liftFirstValue: 1880066 false ) 
	#(33 1 #reduceActionForDefinition1: 2304001 false ) 
	#(34 1 #reduceActionForDefinitionList1: 2457601 false ) 
	#(35 1 #reduceActionForDefinitions1: 2552833 false ) 
	#(36 3 #reduceActionForFullDefinition3: 2600963 false ) 
	#(21 4 #reduceActionForLevelForMany1: 1300481 false ) 
	#(33 2 #reduceActionForDefinition2: 2304002 false ) 
	#(35 2 #reduceActionForDefinitions1: 2552834 false ) 
	#(36 4 #reduceActionForFullDefinition4: 2600964 false ) 
	#(37 1 #reduceActionForPropertyName1: 2755585 false ) 
	#(31 1 #reduceActionForDefinitionList1: 2170881 false ) 
	#(32 1 #reduceActionForProperties1: 2256897 false ) 
	#(30 1 #liftFirstValue: 2121730 false ) 
	#(30 1 #liftFirstValue: 2121729 false ) 
	#(34 3 #reduceActionForDefinitionList2: 2457602 false ) 
	#(32 2 #reduceActionForProperties1: 2256898 false ) 
	#(33 4 #reduceActionForDefinition3: 2304003 false ) 
	#(29 3 #reduceActionForModelAnnotation1: 2017281 false ) 
	#(40 3 #reduceActionForItemsProperty1: 2917377 false ) 
	#(31 3 #reduceActionForDefinitionList2: 2170882 false ) 
	#(38 3 #reduceActionForGenericProperty1: 2794497 false ) 
	#(33 5 #reduceActionForDefinition4: 2304004 false ) 
	#(29 6 #reduceActionForModelAnnotation2: 2017282 false ) 
	#(40 6 #reduceActionForItemsProperty2: 2917378 false )
	).
]

{ #category : #'generated-accessing' }
GtViewModelParser class >> scannerClass [
	^GtViewModelScanner
]

{ #category : #generated }
GtViewModelParser class >> startingStateForFullDefinition [
	^ 3
]

{ #category : #generated }
GtViewModelParser class >> startingStateForHierarchy [
	^ 2
]

{ #category : #generated }
GtViewModelParser class >> startingStateForLevelForOne [
	^ 1
]

{ #category : #generated }
GtViewModelParser class >> symbolNames [
	^ #('<leftBrace>' '<rightBrace>' '<name>' '<follows>' '<whitespace>' '<rightParen>' '<leftParen>' '<period>' '<colon>' '<comma>' '<symbol>' '<string>' '<and>' '<lt>' '<gt>' '<itemsToken>' '<at>' 'B e g i n' 'NestedBranchingLevel' 'LevelForOne' 'LevelForMany' 'SimpleLevel' 'CompositeLevel' 'NestedLevel' 'Level' 'Hierarchy' 'PropertyValue' 'SymbolPropertyValue' 'ModelAnnotation' 'Property' 'PropertiesList' 'Properties' 'Definition' 'DefinitionList' 'Definitions' 'FullDefinition' 'PropertyName' 'GenericProperty' 'GlobalPropertyValue' 'ItemsProperty' 'Setting' 'Settings' 'StringPropertyValue' 'E O F' 'error')
]

{ #category : #generated }
GtViewModelParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtViewModelLevelForOneNode #Object #GtViewModelLevelForOneNode #GtViewModelLevelForManyNode #GtViewModelSimpleLevelNode #GtViewModelCompositeLevelNode #GtViewModelNestedLevelNode #GtViewModelLevelNode #GtViewModelHierarchyNode #GtViewModelPropertyValueNode #GtViewModelSymbolPropertyValueNode #GtViewModelModelAnnotationNode #GtViewModelPropertyNode #OrderedCollection #GtViewModelPropertiesNode #GtViewModelDefinitionNode #OrderedCollection #GtViewModelDefinitionsNode #GtViewModelFullDefinitionNode #GtViewModelPropertyNameNode #GtViewModelGenericPropertyNode #GtViewModelGlobalPropertyValueNode #GtViewModelItemsPropertyNode #GtViewModelSettingNode #GtViewModelSettingsNode #GtViewModelStringPropertyValueNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtViewModelParser class >> transitionTable [
^#(
#[1 0 17 0 3 0 21 0 20] 
#[1 0 25 0 3 0 53 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 53 0 23 0 53 0 24 0 53 0 25 0 57 0 26] 
#[1 0 25 0 3 0 61 0 17 0 53 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 53 0 23 0 53 0 24 0 53 0 25 0 65 0 26 0 69 0 36 0 73 0 41 0 77 0 42] 
#[0 0 6 0 44] 
#[0 0 0 0 44] 
#[1 0 6 0 1 0 6 0 4 0 81 0 7 0 6 0 8 0 6 0 13 0 6 0 14 0 6 0 44] 
#[0 0 10 0 1 0 8 0 14 0 44] 
#[0 0 14 0 1 0 4 0 8 0 13 0 14 0 44] 
#[0 0 18 0 1 0 4 0 8 0 13 0 14 0 44] 
#[1 0 22 0 1 0 85 0 4 0 22 0 8 0 89 0 13 0 22 0 14 0 22 0 44] 
#[0 0 26 0 1 0 8 0 14 0 44] 
#[0 0 30 0 1 0 8 0 14 0 44] 
#[1 0 7 0 8 0 34 0 44] 
#[0 0 0 0 44] 
#[0 0 97 0 3] 
#[1 0 101 0 8 0 38 0 44] 
#[0 0 0 0 44] 
#[0 0 42 0 3 0 8 0 17 0 44] 
#[1 0 25 0 3 0 61 0 17 0 53 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 53 0 23 0 53 0 24 0 53 0 25 0 105 0 26 0 109 0 41] 
#[0 0 113 0 3] 
#[1 0 25 0 3 0 117 0 20 0 117 0 21 0 117 0 22 0 121 0 23 0 125 0 24] 
#[1 0 25 0 3 0 129 0 20 0 129 0 21 0 129 0 22] 
#[0 0 46 0 8 0 44] 
#[1 0 133 0 3 0 137 0 11 0 141 0 12 0 145 0 27 0 145 0 28 0 145 0 39 0 145 0 43] 
#[1 0 25 0 3 0 161 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 161 0 23 0 161 0 24 0 161 0 25 0 165 0 33 0 169 0 34 0 173 0 35] 
#[1 0 177 0 8 0 50 0 44] 
#[0 0 54 0 3 0 8 0 17 0 44] 
#[0 0 181 0 6] 
#[1 0 58 0 1 0 85 0 4 0 58 0 8 0 89 0 13 0 58 0 14 0 58 0 44] 
#[0 0 62 0 1 0 8 0 14 0 44] 
#[0 0 66 0 1 0 8 0 14 0 44] 
#[0 0 70 0 1 0 8 0 14 0 44] 
#[0 0 74 0 2 0 3 0 8 0 10 0 17 0 44] 
#[0 0 78 0 2 0 3 0 8 0 10 0 17 0 44] 
#[0 0 82 0 2 0 3 0 8 0 10 0 17 0 44] 
#[0 0 86 0 3 0 8 0 17 0 44] 
#[0 0 90 0 2 0 3 0 8 0 10 0 17 0 44] 
#[0 0 94 0 2 0 3 0 8 0 10 0 17 0 44] 
#[0 0 98 0 2 0 3 0 8 0 10 0 17 0 44] 
#[1 0 185 0 1 0 102 0 8 0 189 0 14 0 193 0 29 0 102 0 44] 
#[0 0 106 0 8 0 44] 
#[1 0 197 0 8 0 110 0 44] 
#[0 0 114 0 44] 
#[1 0 25 0 3 0 161 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 161 0 23 0 161 0 24 0 161 0 25 0 165 0 33 0 169 0 34 0 201 0 35] 
#[0 0 118 0 1 0 4 0 8 0 13 0 14 0 44] 
#[1 0 205 0 3 0 209 0 16 0 213 0 30 0 217 0 31 0 221 0 32 0 225 0 37 0 213 0 38 0 213 0 40] 
#[0 0 237 0 3] 
#[1 0 241 0 1 0 122 0 8 0 122 0 44] 
#[1 0 25 0 3 0 161 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 161 0 23 0 161 0 24 0 161 0 25 0 245 0 33 0 126 0 44] 
#[0 0 130 0 44] 
#[1 0 249 0 7 0 134 0 9] 
#[0 0 253 0 9] 
#[0 0 138 0 2 0 10] 
#[1 0 142 0 2 1 1 0 10] 
#[0 1 5 0 2] 
#[0 1 9 0 9] 
#[0 0 146 0 2 0 10] 
#[0 0 150 0 2 0 10] 
#[1 1 13 0 9 1 17 0 15] 
#[1 0 205 0 3 0 209 0 16 0 213 0 30 0 217 0 31 1 21 0 32 0 225 0 37 0 213 0 38 0 213 0 40] 
#[0 0 154 0 8 0 44] 
#[0 1 25 0 3] 
#[1 0 137 0 11 1 29 0 28] 
#[1 0 158 0 2 0 205 0 3 0 209 0 16 1 33 0 30 0 225 0 37 1 33 0 38 1 33 0 40] 
#[0 0 162 0 8 0 44] 
#[1 0 133 0 3 0 137 0 11 0 141 0 12 1 37 0 27 1 37 0 28 1 37 0 39 1 37 0 43] 
#[0 1 41 0 9] 
#[0 0 166 0 1 0 8 0 44] 
#[0 1 45 0 2] 
#[0 1 49 0 6] 
#[0 0 170 0 2 0 10] 
#[0 0 174 0 2 0 10] 
#[0 0 178 0 2 0 10] 
#[0 1 53 0 3] 
#[0 0 182 0 8 0 44] 
#[0 1 57 0 9] 
#[0 1 61 0 15] 
#[1 0 137 0 11 1 65 0 28] 
#[0 0 186 0 1 0 8 0 44] 
#[0 0 190 0 2 0 10]
	).
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForCompositeLevel1: nodes [
	| result |
	result := GtViewModelCompositeLevelNode new.
	result addNode: (nodes at: 1) to: result items.
	result and: (nodes at: 2).
	result addNode: (nodes at: 3) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForDefinition1: nodes [
	| result |
	result := GtViewModelDefinitionNode new.
	result level: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForDefinition2: nodes [
	| result |
	result := GtViewModelDefinitionNode new.
	result level: (nodes at: 1).
	result model: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForDefinition3: nodes [
	| result |
	result := GtViewModelDefinitionNode new.
	result level: (nodes at: 1).
	result properties: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForDefinition4: nodes [
	| result |
	result := GtViewModelDefinitionNode new.
	result level: (nodes at: 1).
	result model: (nodes at: 2).
	result properties: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForDefinitionList1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForDefinitionList2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 3) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForDefinitions1: nodes [
	| result |
	result := GtViewModelDefinitionsNode new.
	result addNodes: (nodes at: 1) to: result definitions.
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForFullDefinition1: nodes [
	| result |
	result := GtViewModelFullDefinitionNode new.
	result hierarchy: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForFullDefinition2: nodes [
	| result |
	result := GtViewModelFullDefinitionNode new.
	result settings: (nodes at: 1).
	result hierarchy: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForFullDefinition3: nodes [
	| result |
	result := GtViewModelFullDefinitionNode new.
	result hierarchy: (nodes at: 1).
	result definitions: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForFullDefinition4: nodes [
	| result |
	result := GtViewModelFullDefinitionNode new.
	result settings: (nodes at: 1).
	result hierarchy: (nodes at: 2).
	result definitions: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForGenericProperty1: nodes [
	| result |
	result := GtViewModelGenericPropertyNode new.
	result name: (nodes at: 1).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForGlobalPropertyValue1: nodes [
	| result |
	result := GtViewModelGlobalPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForHierarchy1: nodes [
	| result |
	result := GtViewModelHierarchyNode new.
	result level: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForItemsProperty1: nodes [
	| result |
	result := GtViewModelItemsPropertyNode new.
	result name: (nodes at: 1).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForItemsProperty2: nodes [
	| result |
	result := GtViewModelItemsPropertyNode new.
	result name: (nodes at: 1).
	result suffix: (nodes at: 3).
	result value: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForLevelForMany1: nodes [
	| result |
	result := GtViewModelLevelForManyNode new.
	result name: (nodes at: 1).
	result suffix: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForLevelForOne1: nodes [
	| result |
	result := GtViewModelLevelForOneNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForModelAnnotation1: nodes [
	| result |
	result := GtViewModelModelAnnotationNode new.
	result name: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForModelAnnotation2: nodes [
	| result |
	result := GtViewModelModelAnnotationNode new.
	result name: (nodes at: 2).
	result api: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForNestedLevel2: nodes [
	| result |
	result := GtViewModelNestedLevelNode new.
	result parentLevel: (nodes at: 1).
	result follows: (nodes at: 2).
	result childLevel: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForProperties1: nodes [
	| result |
	result := GtViewModelPropertiesNode new.
	result addNodes: (nodes at: 1) to: result properties.
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForPropertyName1: nodes [
	| result |
	result := GtViewModelPropertyNameNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForSetting1: nodes [
	| result |
	result := GtViewModelSettingNode new.
	result _at: (nodes at: 1).
	result name: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForSettings1: nodes [
	| result |
	result := GtViewModelSettingsNode new.
	result addNode: (nodes at: 1) to: result settings.
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForSettings2: nodes [
	| result |
	result := nodes at: 1.
	result addNode: (nodes at: 2) to: result settings.
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForStringPropertyValue1: nodes [
	| result |
	result := GtViewModelStringPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtViewModelParser >> reduceActionForSymbolPropertyValue1: nodes [
	| result |
	result := GtViewModelSymbolPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]
