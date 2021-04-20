Class {
	#name : #GtRobocoderMetamodelParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelParser class >> ambiguousTransitions [
^#(
#[ 0 38 0 42 0 113] 
#[ 0 38 0 42]
	).
]

{ #category : #'generated-accessing' }
GtRobocoderMetamodelParser class >> cacheId [
	^'2021-04-19T21:28:13.187317+02:00'
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> definitionComment [
"%glr;
%root Program;
%prefix GtRobocoderMetamodel;
%suffix Node;
%hierarchy PropertyValue (SymbolPropertyValue GlobalPropertyValue StringPropertyValue);
%hierarchy Level (SimpleLevel CompositeLevel NestedLevel);
%hierarchy SimpleLevel (LevelForOne LevelForMany);
%hierarchy Hierarchy (HierarchyError);
%start Hierarchy FullDefinition;
%id <and><follows>;
%hierarchy Property (GenericProperty ItemsProperty SettingProperty);
%hierarchy Setting (LocalSetting GlobalSetting);


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
<itemsToken>
	: items
	;
<at>
	: \@
	;
<derive>
	: derive
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
	: (Property 'property' | LocalSetting 'property')
	| PropertiesList<comma>(Property'property'| LocalSetting 'property')
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
	: Settings 'settings'? Definitions'definitions' {{}}
	| Settings 'settings'? Hierarchies 'hierarchies'? {{}}
	| Settings 'settings'? Hierarchies'hierarchies'<period>Definitions'definitions' {{}}
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
Settings
	: GlobalSetting 'setting' {{}}
	| Settings  GlobalSetting 'setting' {{}}
	;
StringPropertyValue
	: <string> 'value' {{}}
	;
Hierarchies
	: Hierarchy 'hierarchy' {{}}
	| Hierarchies <period> Hierarchy 'hierarchy' {{}}
	;
LocalSetting
	: <at>'at'<name>'name' PropertyValue'value' (<leftParen>SettingPropertiesList'properties' <rightParen>)? {{}}
	;
GlobalSetting
	: <at>'at'<name>'name' PropertyValue'value' (<leftParen>SettingPropertiesList'properties' <rightParen>)? {{}}
	;
SettingPropertiesList
	: SettingProperty 'property' {{}}
	| SettingPropertiesList<comma>(SettingProperty'property') {{}}
	;
SettingProperty
	: PropertyName'name'<colon>PropertyValue 'value' {{}}
	;"
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> reduceTable [
^#(
	#(36 0 #reduceActionForFullDefinition3: 2734083 false ) 
	#(20 1 #reduceActionForLevelForOne1: 1339393 false ) 
	#(25 1 #liftFirstValue: 1829892 false ) 
	#(22 1 #liftFirstValue: 1455105 false ) 
	#(22 1 #liftFirstValue: 1455106 false ) 
	#(25 1 #liftFirstValue: 1829889 false ) 
	#(25 1 #liftFirstValue: 1829890 false ) 
	#(25 1 #liftFirstValue: 1829891 false ) 
	#(26 1 #reduceActionForHierarchy1: 1912833 false ) 
	#(33 1 #reduceActionForDefinition1: 2437121 false ) 
	#(43 1 #reduceActionForHierarchies1: 3429377 false ) 
	#(34 1 #reduceActionForDefinitionList1: 2590721 false ) 
	#(35 1 #reduceActionForDefinitions1: 2685953 false ) 
	#(36 1 #reduceActionForFullDefinition1: 2734081 false ) 
	#(36 1 #reduceActionForFullDefinition5: 2734085 false ) 
	#(36 1 #reduceActionForFullDefinition4: 2734084 false ) 
	#(41 1 #reduceActionForSettings1: 3292161 false ) 
	#(26 2 #reduceActionForHierarchy1: 1912834 false ) 
	#(33 2 #reduceActionForDefinition2: 2437122 false ) 
	#(35 2 #reduceActionForDefinitions1: 2685954 false ) 
	#(36 2 #reduceActionForFullDefinition2: 2734082 false ) 
	#(36 2 #reduceActionForFullDefinition6: 2734086 false ) 
	#(41 2 #reduceActionForSettings2: 3292162 false ) 
	#(24 3 #reduceActionForNestedLevel2: 1577986 false ) 
	#(24 3 #reduceActionForNestedLevel2: 1577987 false ) 
	#(24 3 #reduceActionForNestedLevel2: 1577985 false ) 
	#(23 3 #reduceActionForCompositeLevel1: 1502209 false ) 
	#(39 1 #reduceActionForGlobalPropertyValue1: 3067905 false ) 
	#(28 1 #reduceActionForSymbolPropertyValue1: 2044929 false ) 
	#(42 1 #reduceActionForStringPropertyValue1: 3380225 false ) 
	#(45 3 #reduceActionForGlobalSetting1: 3657729 false ) 
	#(27 1 #liftFirstValue: 1956865 false ) 
	#(27 1 #liftFirstValue: 1956867 false ) 
	#(27 1 #liftFirstValue: 1956866 false ) 
	#(37 1 #reduceActionForPropertyName1: 2953217 false ) 
	#(31 1 #reduceActionForDefinitionList1: 2247681 false ) 
	#(32 1 #reduceActionForProperties1: 2390017 false ) 
	#(30 1 #liftFirstValue: 2198530 false ) 
	#(30 1 #liftFirstValue: 2198529 false ) 
	#(31 1 #reduceActionForDefinitionList1: 2247682 false ) 
	#(34 3 #reduceActionForDefinitionList2: 2590722 false ) 
	#(43 3 #reduceActionForHierarchies2: 3429378 false ) 
	#(36 3 #reduceActionForFullDefinition7: 2734087 false ) 
	#(21 4 #reduceActionForLevelForMany1: 1377281 false ) 
	#(32 2 #reduceActionForProperties1: 2390018 false ) 
	#(33 4 #reduceActionForDefinition3: 2437123 false ) 
	#(29 3 #reduceActionForModelAnnotation1: 2094081 false ) 
	#(36 4 #reduceActionForFullDefinition8: 2734088 false ) 
	#(46 1 #reduceActionForSettingPropertiesList1: 3788801 false ) 
	#(40 3 #reduceActionForItemsProperty1: 3115009 false ) 
	#(44 3 #reduceActionForLocalSetting1: 3527681 false ) 
	#(31 3 #reduceActionForDefinitionList2: 2247683 false ) 
	#(31 3 #reduceActionForDefinitionList2: 2247684 false ) 
	#(38 3 #reduceActionForGenericProperty1: 2992129 false ) 
	#(33 5 #reduceActionForDefinition4: 2437124 false ) 
	#(45 6 #reduceActionForGlobalSetting2: 3657730 false ) 
	#(47 3 #reduceActionForSettingProperty1: 3915777 false ) 
	#(46 3 #reduceActionForSettingPropertiesList2: 3788802 false ) 
	#(29 6 #reduceActionForModelAnnotation2: 2094082 false ) 
	#(40 6 #reduceActionForItemsProperty2: 3115010 false ) 
	#(44 6 #reduceActionForLocalSetting2: 3527682 false )
	).
]

{ #category : #'generated-accessing' }
GtRobocoderMetamodelParser class >> scannerClass [
	^GtRobocoderMetamodelScanner
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> startingStateForFullDefinition [
	^ 3
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> startingStateForHierarchy [
	^ 2
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> startingStateForLevelForOne [
	^ 1
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> symbolNames [
	^ #('<leftBrace>' '<rightBrace>' '<name>' '<follows>' '<whitespace>' '<rightParen>' '<leftParen>' '<period>' '<colon>' '<comma>' '<symbol>' '<string>' '<and>' '<lt>' '<gt>' '<itemsToken>' '<at>' 'B e g i n' 'NestedBranchingLevel' 'LevelForOne' 'LevelForMany' 'SimpleLevel' 'CompositeLevel' 'NestedLevel' 'Level' 'Hierarchy' 'PropertyValue' 'SymbolPropertyValue' 'ModelAnnotation' 'Property' 'PropertiesList' 'Properties' 'Definition' 'DefinitionList' 'Definitions' 'FullDefinition' 'PropertyName' 'GenericProperty' 'GlobalPropertyValue' 'ItemsProperty' 'Settings' 'StringPropertyValue' 'Hierarchies' 'LocalSetting' 'GlobalSetting' 'SettingPropertiesList' 'SettingProperty' 'E O F' 'error')
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtRobocoderMetamodelLevelForOneNode #Object #GtRobocoderMetamodelLevelForOneNode #GtRobocoderMetamodelLevelForManyNode #GtRobocoderMetamodelSimpleLevelNode #GtRobocoderMetamodelCompositeLevelNode #GtRobocoderMetamodelNestedLevelNode #GtRobocoderMetamodelLevelNode #GtRobocoderMetamodelHierarchyNode #GtRobocoderMetamodelPropertyValueNode #GtRobocoderMetamodelSymbolPropertyValueNode #GtRobocoderMetamodelModelAnnotationNode #GtRobocoderMetamodelPropertyNode #OrderedCollection #GtRobocoderMetamodelPropertiesNode #GtRobocoderMetamodelDefinitionNode #OrderedCollection #GtRobocoderMetamodelDefinitionsNode #GtRobocoderMetamodelFullDefinitionNode #GtRobocoderMetamodelPropertyNameNode #GtRobocoderMetamodelGenericPropertyNode #GtRobocoderMetamodelGlobalPropertyValueNode #GtRobocoderMetamodelItemsPropertyNode #GtRobocoderMetamodelSettingsNode #GtRobocoderMetamodelStringPropertyValueNode #GtRobocoderMetamodelHierarchiesNode #GtRobocoderMetamodelLocalSettingNode #GtRobocoderMetamodelGlobalSettingNode #GtRobocoderMetamodelSettingPropertiesListNode #GtRobocoderMetamodelSettingPropertyNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> transitionTable [
^#(
#[1 0 17 0 3 0 21 0 20] 
#[1 0 25 0 3 0 53 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 53 0 23 0 53 0 24 0 53 0 25 0 57 0 26] 
#[1 0 25 0 3 0 61 0 17 0 65 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 65 0 23 0 65 0 24 0 65 0 25 0 69 0 26 0 73 0 33 0 77 0 34 0 81 0 35 0 85 0 36 0 89 0 41 0 93 0 43 0 97 0 45 0 6 0 48] 
#[0 0 10 0 48] 
#[0 0 0 0 48] 
#[1 0 10 0 1 0 10 0 4 0 101 0 7 0 10 0 8 0 10 0 13 0 10 0 14 0 10 0 48] 
#[0 0 14 0 1 0 8 0 14 0 48] 
#[0 0 18 0 1 0 4 0 8 0 13 0 14 0 48] 
#[0 0 22 0 1 0 4 0 8 0 13 0 14 0 48] 
#[1 0 26 0 1 0 105 0 4 0 26 0 8 0 109 0 13 0 26 0 14 0 26 0 48] 
#[0 0 30 0 1 0 8 0 14 0 48] 
#[0 0 34 0 1 0 8 0 14 0 48] 
#[1 0 113 0 8 0 38 0 48] 
#[0 0 0 0 48] 
#[0 0 117 0 3] 
#[1 0 121 0 1 0 7 0 8 0 125 0 14 0 129 0 29 0 11 0 48] 
#[0 0 46 0 8 0 48] 
#[0 0 50 0 8 0 48] 
#[1 0 133 0 8 0 54 0 48] 
#[0 0 58 0 48] 
#[0 0 0 0 48] 
#[1 0 25 0 3 0 61 0 17 0 65 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 65 0 23 0 65 0 24 0 65 0 25 0 69 0 26 0 73 0 33 0 77 0 34 0 137 0 35 0 141 0 43 0 145 0 45 0 62 0 48] 
#[1 0 149 0 8 0 66 0 48] 
#[0 0 70 0 1 0 3 0 8 0 14 0 17 0 48] 
#[0 0 153 0 3] 
#[1 0 25 0 3 0 157 0 20 0 157 0 21 0 157 0 22 0 161 0 23 0 165 0 24] 
#[1 0 25 0 3 0 169 0 20 0 169 0 21 0 169 0 22] 
#[0 0 74 0 8 0 48] 
#[1 0 173 0 3 0 177 0 11 0 181 0 12 0 185 0 27 0 185 0 28 0 185 0 39 0 185 0 42] 
#[1 0 201 0 3 0 205 0 16 0 209 0 17 0 213 0 30 0 217 0 31 0 221 0 32 0 225 0 37 0 213 0 38 0 213 0 40 0 237 0 44] 
#[0 0 241 0 3] 
#[1 0 245 0 1 0 78 0 8 0 78 0 48] 
#[1 0 25 0 3 0 249 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 249 0 23 0 249 0 24 0 249 0 25 0 253 0 33 0 82 0 48] 
#[0 0 86 0 48] 
#[1 1 1 0 8 0 90 0 48] 
#[0 0 94 0 1 0 3 0 8 0 14 0 17 0 48] 
#[1 0 25 0 3 0 65 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 65 0 23 0 65 0 24 0 65 0 25 1 5 0 26 0 73 0 33 0 77 0 34 1 9 0 35] 
#[0 1 13 0 6] 
#[1 0 98 0 1 0 105 0 4 0 98 0 8 0 109 0 13 0 98 0 14 0 98 0 48] 
#[0 0 102 0 1 0 8 0 14 0 48] 
#[0 0 106 0 1 0 8 0 14 0 48] 
#[0 0 110 0 1 0 8 0 14 0 48] 
#[0 0 114 0 1 0 2 0 3 0 6 0 7 0 8 0 10 0 14 0 17 0 48] 
#[0 0 118 0 1 0 2 0 3 0 6 0 7 0 8 0 10 0 14 0 17 0 48] 
#[0 0 122 0 1 0 2 0 3 0 6 0 7 0 8 0 10 0 14 0 17 0 48] 
#[1 0 126 0 1 0 126 0 3 1 17 0 7 0 126 0 8 0 126 0 14 0 126 0 17 0 126 0 48] 
#[0 0 130 0 1 0 2 0 3 0 6 0 7 0 8 0 10 0 14 0 17 0 48] 
#[0 0 134 0 1 0 2 0 3 0 6 0 7 0 8 0 10 0 14 0 17 0 48] 
#[0 0 138 0 1 0 2 0 3 0 6 0 7 0 8 0 10 0 14 0 17 0 48] 
#[1 1 21 0 7 0 142 0 9] 
#[0 1 25 0 9] 
#[0 1 29 0 3] 
#[0 0 146 0 2 0 10] 
#[1 0 150 0 2 1 33 0 10] 
#[0 1 37 0 2] 
#[0 1 41 0 9] 
#[0 0 154 0 2 0 10] 
#[0 0 158 0 2 0 10] 
#[0 0 162 0 2 0 10] 
#[1 1 45 0 9 1 49 0 15] 
#[1 0 201 0 3 0 205 0 16 0 209 0 17 0 213 0 30 0 217 0 31 1 53 0 32 0 225 0 37 0 213 0 38 0 213 0 40 0 237 0 44] 
#[1 0 121 0 1 0 42 0 8 0 125 0 14 0 129 0 29 0 42 0 48] 
#[0 0 166 0 8 0 48] 
#[1 0 25 0 3 0 65 0 19 0 41 0 20 0 41 0 21 0 41 0 22 0 65 0 23 0 65 0 24 0 65 0 25 1 5 0 26 0 73 0 33 0 77 0 34 1 57 0 35] 
#[0 0 170 0 8 0 48] 
#[0 0 174 0 48] 
#[0 0 178 0 1 0 4 0 8 0 13 0 14 0 48] 
#[1 1 61 0 3 1 65 0 37 1 69 0 46 1 73 0 47] 
#[0 1 77 0 3] 
#[1 0 177 0 11 1 81 0 28] 
#[1 0 173 0 3 0 177 0 11 0 181 0 12 1 85 0 27 1 85 0 28 1 85 0 39 1 85 0 42] 
#[1 0 182 0 2 0 201 0 3 0 205 0 16 0 209 0 17 1 89 0 30 0 225 0 37 1 89 0 38 1 89 0 40 1 93 0 44] 
#[0 0 186 0 8 0 48] 
#[1 0 173 0 3 0 177 0 11 0 181 0 12 1 97 0 27 1 97 0 28 1 97 0 39 1 97 0 42] 
#[0 1 101 0 9] 
#[0 0 190 0 1 0 8 0 48] 
#[0 1 105 0 2] 
#[0 0 194 0 48] 
#[0 0 142 0 9] 
#[0 1 109 0 9] 
#[1 1 113 0 6 1 117 0 10] 
#[0 0 198 0 6 0 10] 
#[0 1 121 0 6] 
#[0 0 202 0 2 0 10] 
#[1 0 206 0 2 1 125 0 7 0 206 0 10] 
#[0 0 210 0 2 0 10] 
#[0 0 214 0 2 0 10] 
#[0 0 218 0 2 0 10] 
#[0 1 129 0 3] 
#[0 0 222 0 8 0 48] 
#[1 0 173 0 3 0 177 0 11 0 181 0 12 1 133 0 27 1 133 0 28 1 133 0 39 1 133 0 42] 
#[0 0 226 0 1 0 3 0 8 0 14 0 17 0 48] 
#[1 1 61 0 3 1 65 0 37 1 137 0 47] 
#[0 1 141 0 9] 
#[1 1 61 0 3 1 65 0 37 1 145 0 46 1 73 0 47] 
#[0 1 149 0 15] 
#[0 0 230 0 6 0 10] 
#[0 0 234 0 6 0 10] 
#[1 0 177 0 11 1 153 0 28] 
#[1 1 157 0 6 1 117 0 10] 
#[0 0 238 0 1 0 8 0 48] 
#[0 0 242 0 2 0 10] 
#[0 0 246 0 2 0 10]
	).
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForCompositeLevel1: nodes [
	| result |
	result := GtRobocoderMetamodelCompositeLevelNode new.
	result addNode: (nodes at: 1) to: result items.
	result and: (nodes at: 2).
	result addNode: (nodes at: 3) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForDefinition1: nodes [
	| result |
	result := GtRobocoderMetamodelDefinitionNode new.
	result level: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForDefinition2: nodes [
	| result |
	result := GtRobocoderMetamodelDefinitionNode new.
	result level: (nodes at: 1).
	result model: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForDefinition3: nodes [
	| result |
	result := GtRobocoderMetamodelDefinitionNode new.
	result level: (nodes at: 1).
	result properties: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForDefinition4: nodes [
	| result |
	result := GtRobocoderMetamodelDefinitionNode new.
	result level: (nodes at: 1).
	result model: (nodes at: 2).
	result properties: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForDefinitionList1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForDefinitionList2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 3) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForDefinitions1: nodes [
	| result |
	result := GtRobocoderMetamodelDefinitionsNode new.
	result addNodes: (nodes at: 1) to: result definitions.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition1: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result definitions: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition2: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result settings: (nodes at: 1).
	result definitions: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition3: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition4: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result hierarchies: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition5: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result settings: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition6: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result settings: (nodes at: 1).
	result hierarchies: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition7: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result hierarchies: (nodes at: 1).
	result definitions: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition8: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result settings: (nodes at: 1).
	result hierarchies: (nodes at: 2).
	result definitions: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForGenericProperty1: nodes [
	| result |
	result := GtRobocoderMetamodelGenericPropertyNode new.
	result name: (nodes at: 1).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForGlobalPropertyValue1: nodes [
	| result |
	result := GtRobocoderMetamodelGlobalPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForGlobalSetting1: nodes [
	| result |
	result := GtRobocoderMetamodelGlobalSettingNode new.
	result _at: (nodes at: 1).
	result name: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForGlobalSetting2: nodes [
	| result |
	result := GtRobocoderMetamodelGlobalSettingNode new.
	result _at: (nodes at: 1).
	result name: (nodes at: 2).
	result value: (nodes at: 3).
	result properties: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForHierarchies1: nodes [
	| result |
	result := GtRobocoderMetamodelHierarchiesNode new.
	result addNode: (nodes at: 1) to: result hierarchies.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForHierarchies2: nodes [
	| result |
	result := nodes at: 1.
	result addNode: (nodes at: 3) to: result hierarchies.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForHierarchy1: nodes [
	| result |
	result := GtRobocoderMetamodelHierarchyNode new.
	result level: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForItemsProperty1: nodes [
	| result |
	result := GtRobocoderMetamodelItemsPropertyNode new.
	result name: (nodes at: 1).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForItemsProperty2: nodes [
	| result |
	result := GtRobocoderMetamodelItemsPropertyNode new.
	result name: (nodes at: 1).
	result suffix: (nodes at: 3).
	result value: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForLevelForMany1: nodes [
	| result |
	result := GtRobocoderMetamodelLevelForManyNode new.
	result name: (nodes at: 1).
	result suffix: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForLevelForOne1: nodes [
	| result |
	result := GtRobocoderMetamodelLevelForOneNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForLocalSetting1: nodes [
	| result |
	result := GtRobocoderMetamodelLocalSettingNode new.
	result _at: (nodes at: 1).
	result name: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForLocalSetting2: nodes [
	| result |
	result := GtRobocoderMetamodelLocalSettingNode new.
	result _at: (nodes at: 1).
	result name: (nodes at: 2).
	result value: (nodes at: 3).
	result properties: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForModelAnnotation1: nodes [
	| result |
	result := GtRobocoderMetamodelModelAnnotationNode new.
	result name: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForModelAnnotation2: nodes [
	| result |
	result := GtRobocoderMetamodelModelAnnotationNode new.
	result name: (nodes at: 2).
	result api: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForNestedLevel2: nodes [
	| result |
	result := GtRobocoderMetamodelNestedLevelNode new.
	result parentLevel: (nodes at: 1).
	result follows: (nodes at: 2).
	result childLevel: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForProperties1: nodes [
	| result |
	result := GtRobocoderMetamodelPropertiesNode new.
	result addNodes: (nodes at: 1) to: result properties.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForPropertyName1: nodes [
	| result |
	result := GtRobocoderMetamodelPropertyNameNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForSettingPropertiesList1: nodes [
	| result |
	result := GtRobocoderMetamodelSettingPropertiesListNode new.
	result addNode: (nodes at: 1) to: result properties.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForSettingPropertiesList2: nodes [
	| result |
	result := nodes at: 1.
	result addNode: (nodes at: 3) to: result properties.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForSettingProperty1: nodes [
	| result |
	result := GtRobocoderMetamodelSettingPropertyNode new.
	result name: (nodes at: 1).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForSettings1: nodes [
	| result |
	result := GtRobocoderMetamodelSettingsNode new.
	result addNode: (nodes at: 1) to: result settings.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForSettings2: nodes [
	| result |
	result := nodes at: 1.
	result addNode: (nodes at: 2) to: result settings.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForStringPropertyValue1: nodes [
	| result |
	result := GtRobocoderMetamodelStringPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForSymbolPropertyValue1: nodes [
	| result |
	result := GtRobocoderMetamodelSymbolPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]
