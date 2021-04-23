Class {
	#name : #GtRobocoderMetamodelParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelParser class >> ambiguousTransitions [
^#(
#[ 0 34 0 38 0 117] 
#[ 0 34 0 38]
	).
]

{ #category : #'generated-accessing' }
GtRobocoderMetamodelParser class >> cacheId [
	^'2021-04-23T11:49:07.870324+02:00'
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> definitionComment [
"%glr;
%root Program;
%prefix GtRobocoderMetamodel;
%suffix Node;
%hierarchy PropertyValue (SymbolPropertyValue GlobalPropertyValue StringPropertyValue BooleanPropertyValue);
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
<itemsToken>
	: items
	;
<at>
	: \@
	;
<true>
	: true
	;
<false>
	: false
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
	: SimpleLevel'item' (<and>'and' SimpleLevel 'item')+ {{}}
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
	;
Hierarchy
	: Level'level'<period>? {{}}
	;
PropertyValue
	: SymbolPropertyValue
	| StringPropertyValue
	| BooleanPropertyValue
	| GlobalPropertyValue
	;
SymbolPropertyValue
	: <symbol> 'value' {{}}
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
	: Level'level' {{}}
	| Level'level' <leftBrace>Properties'properties'? <rightBrace> {{}}
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
	;
BooleanPropertyValue
	: (<true> 'value' | <false> 'value') {{}}
	;"
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> reduceTable [
^#(
	#(36 0 #reduceActionForFullDefinition3: 2578435 false ) 
	#(19 1 #reduceActionForLevelForOne1: 1332225 false ) 
	#(21 1 #liftFirstValue: 1447937 false ) 
	#(21 1 #liftFirstValue: 1447938 false ) 
	#(26 1 #liftFirstValue: 1825793 false ) 
	#(26 1 #liftFirstValue: 1825794 false ) 
	#(26 1 #liftFirstValue: 1825795 false ) 
	#(27 1 #reduceActionForHierarchy1: 1884161 false ) 
	#(33 1 #reduceActionForDefinition1: 2328577 false ) 
	#(43 1 #reduceActionForHierarchies1: 3273729 false ) 
	#(34 1 #reduceActionForDefinitionList1: 2435073 false ) 
	#(35 1 #reduceActionForDefinitions1: 2530305 false ) 
	#(36 1 #reduceActionForFullDefinition1: 2578433 false ) 
	#(36 1 #reduceActionForFullDefinition5: 2578437 false ) 
	#(36 1 #reduceActionForFullDefinition4: 2578436 false ) 
	#(41 1 #reduceActionForSettings1: 3136513 false ) 
	#(24 1 #reduceActionFor__and__and__SimpleLevel__item___1: 1531905 false ) 
	#(22 2 #reduceActionForCompositeLevel1: 1495041 false ) 
	#(27 2 #reduceActionForHierarchy1: 1884162 false ) 
	#(35 2 #reduceActionForDefinitions1: 2530306 false ) 
	#(36 2 #reduceActionForFullDefinition2: 2578434 false ) 
	#(36 2 #reduceActionForFullDefinition6: 2578438 false ) 
	#(41 2 #reduceActionForSettings2: 3136514 false ) 
	#(25 3 #reduceActionForNestedLevel2: 1573890 false ) 
	#(25 3 #reduceActionForNestedLevel2: 1573891 false ) 
	#(25 3 #reduceActionForNestedLevel2: 1573889 false ) 
	#(23 2 #reduceActionFor__and__and__SimpleLevel__item__1: 1531905 false ) 
	#(24 2 #reduceActionFor__and__and__SimpleLevel__item___2: 1531906 false ) 
	#(39 1 #reduceActionForGlobalPropertyValue1: 2912257 false ) 
	#(29 1 #reduceActionForSymbolPropertyValue1: 2040833 false ) 
	#(42 1 #reduceActionForStringPropertyValue1: 3224577 false ) 
	#(48 1 #reduceActionForBooleanPropertyValue1: 3835905 false ) 
	#(48 1 #reduceActionForBooleanPropertyValue1: 3835906 false ) 
	#(45 3 #reduceActionForGlobalSetting1: 3502081 false ) 
	#(28 1 #liftFirstValue: 1928193 false ) 
	#(28 1 #liftFirstValue: 1928196 false ) 
	#(28 1 #liftFirstValue: 1928194 false ) 
	#(28 1 #liftFirstValue: 1928195 false ) 
	#(33 3 #reduceActionForDefinition1: 2328578 false ) 
	#(37 1 #reduceActionForPropertyName1: 2797569 false ) 
	#(31 1 #reduceActionForDefinitionList1: 2139137 false ) 
	#(32 1 #reduceActionForProperties1: 2281473 false ) 
	#(30 1 #liftFirstValue: 2089986 false ) 
	#(30 1 #liftFirstValue: 2089985 false ) 
	#(31 1 #reduceActionForDefinitionList1: 2139138 false ) 
	#(34 3 #reduceActionForDefinitionList2: 2435074 false ) 
	#(43 3 #reduceActionForHierarchies2: 3273730 false ) 
	#(36 3 #reduceActionForFullDefinition7: 2578439 false ) 
	#(20 4 #reduceActionForLevelForMany1: 1370113 false ) 
	#(32 2 #reduceActionForProperties1: 2281474 false ) 
	#(33 4 #reduceActionForDefinition3: 2328579 false ) 
	#(36 4 #reduceActionForFullDefinition8: 2578440 false ) 
	#(46 1 #reduceActionForSettingPropertiesList1: 3633153 false ) 
	#(40 3 #reduceActionForItemsProperty1: 2959361 false ) 
	#(44 3 #reduceActionForLocalSetting1: 3372033 false ) 
	#(31 3 #reduceActionForDefinitionList2: 2139139 false ) 
	#(31 3 #reduceActionForDefinitionList2: 2139140 false ) 
	#(38 3 #reduceActionForGenericProperty1: 2836481 false ) 
	#(45 6 #reduceActionForGlobalSetting2: 3502082 false ) 
	#(47 3 #reduceActionForSettingProperty1: 3760129 false ) 
	#(46 3 #reduceActionForSettingPropertiesList2: 3633154 false ) 
	#(40 6 #reduceActionForItemsProperty2: 2959362 false ) 
	#(44 6 #reduceActionForLocalSetting2: 3372034 false )
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
	^ #('<leftBrace>' '<rightBrace>' '<name>' '<follows>' '<whitespace>' '<rightParen>' '<leftParen>' '<period>' '<colon>' '<comma>' '<symbol>' '<string>' '<and>' '<itemsToken>' '<at>' '<true>' '<false>' 'B e g i n' 'LevelForOne' 'LevelForMany' 'SimpleLevel' 'CompositeLevel' '(<and>''and'' SimpleLevel ''item'')' '(<and>''and'' SimpleLevel ''item'')+' 'NestedLevel' 'Level' 'Hierarchy' 'PropertyValue' 'SymbolPropertyValue' 'Property' 'PropertiesList' 'Properties' 'Definition' 'DefinitionList' 'Definitions' 'FullDefinition' 'PropertyName' 'GenericProperty' 'GlobalPropertyValue' 'ItemsProperty' 'Settings' 'StringPropertyValue' 'Hierarchies' 'LocalSetting' 'GlobalSetting' 'SettingPropertiesList' 'SettingProperty' 'BooleanPropertyValue' 'E O F' 'error')
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtRobocoderMetamodelLevelForOneNode #GtRobocoderMetamodelLevelForOneNode #GtRobocoderMetamodelLevelForManyNode #GtRobocoderMetamodelSimpleLevelNode #GtRobocoderMetamodelCompositeLevelNode #OrderedCollection #OrderedCollection #GtRobocoderMetamodelNestedLevelNode #GtRobocoderMetamodelLevelNode #GtRobocoderMetamodelHierarchyNode #GtRobocoderMetamodelPropertyValueNode #GtRobocoderMetamodelSymbolPropertyValueNode #GtRobocoderMetamodelPropertyNode #OrderedCollection #GtRobocoderMetamodelPropertiesNode #GtRobocoderMetamodelDefinitionNode #OrderedCollection #GtRobocoderMetamodelDefinitionsNode #GtRobocoderMetamodelFullDefinitionNode #GtRobocoderMetamodelPropertyNameNode #GtRobocoderMetamodelGenericPropertyNode #GtRobocoderMetamodelGlobalPropertyValueNode #GtRobocoderMetamodelItemsPropertyNode #GtRobocoderMetamodelSettingsNode #GtRobocoderMetamodelStringPropertyValueNode #GtRobocoderMetamodelHierarchiesNode #GtRobocoderMetamodelLocalSettingNode #GtRobocoderMetamodelGlobalSettingNode #GtRobocoderMetamodelSettingPropertiesListNode #GtRobocoderMetamodelSettingPropertyNode #GtRobocoderMetamodelBooleanPropertyValueNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> transitionTable [
^#(
#[1 0 17 0 3 0 21 0 19] 
#[1 0 25 0 3 0 37 0 19 0 37 0 20 0 37 0 21 0 49 0 22 0 49 0 25 0 49 0 26 0 53 0 27] 
#[1 0 25 0 3 0 57 0 15 0 37 0 19 0 37 0 20 0 37 0 21 0 61 0 22 0 61 0 25 0 61 0 26 0 65 0 27 0 69 0 33 0 73 0 34 0 77 0 35 0 81 0 36 0 85 0 41 0 89 0 43 0 93 0 45 0 6 0 49] 
#[0 0 10 0 49] 
#[0 0 0 0 49] 
#[1 0 10 0 1 0 10 0 4 0 97 0 7 0 10 0 8 0 10 0 13 0 10 0 49] 
#[0 0 14 0 1 0 4 0 8 0 13 0 49] 
#[0 0 18 0 1 0 4 0 8 0 13 0 49] 
#[1 0 22 0 1 0 101 0 4 0 22 0 8 0 105 0 13 0 109 0 23 0 113 0 24 0 22 0 49] 
#[0 0 26 0 1 0 8 0 49] 
#[0 0 30 0 1 0 8 0 49] 
#[1 0 117 0 8 0 34 0 49] 
#[0 0 0 0 49] 
#[0 0 121 0 3] 
#[1 0 125 0 1 0 7 0 8 0 11 0 49] 
#[0 0 42 0 8 0 49] 
#[0 0 46 0 8 0 49] 
#[1 0 129 0 8 0 50 0 49] 
#[0 0 54 0 49] 
#[0 0 0 0 49] 
#[1 0 25 0 3 0 57 0 15 0 37 0 19 0 37 0 20 0 37 0 21 0 61 0 22 0 61 0 25 0 61 0 26 0 65 0 27 0 69 0 33 0 73 0 34 0 133 0 35 0 137 0 43 0 141 0 45 0 58 0 49] 
#[1 0 145 0 8 0 62 0 49] 
#[0 0 66 0 3 0 15 0 49] 
#[0 0 149 0 3] 
#[1 0 25 0 3 0 153 0 19 0 153 0 20 0 153 0 21 0 157 0 22 0 161 0 25] 
#[1 0 25 0 3 0 165 0 19 0 165 0 20 0 165 0 21] 
#[0 0 70 0 1 0 8 0 13 0 49] 
#[1 0 74 0 1 0 74 0 8 0 105 0 13 0 169 0 23 0 74 0 49] 
#[0 0 78 0 8 0 49] 
#[1 0 173 0 3 0 177 0 11 0 181 0 12 0 185 0 16 0 189 0 17 0 193 0 28 0 193 0 29 0 193 0 39 0 193 0 42 0 193 0 48] 
#[1 0 213 0 2 0 217 0 3 0 221 0 14 0 225 0 15 0 229 0 30 0 233 0 31 0 237 0 32 0 241 0 37 0 229 0 38 0 229 0 40 0 253 0 44] 
#[1 0 25 0 3 0 37 0 19 0 37 0 20 0 37 0 21 1 1 0 22 1 1 0 25 1 1 0 26 1 5 0 33 0 82 0 49] 
#[0 0 86 0 49] 
#[1 1 9 0 8 0 90 0 49] 
#[0 0 94 0 3 0 15 0 49] 
#[1 0 25 0 3 0 37 0 19 0 37 0 20 0 37 0 21 0 61 0 22 0 61 0 25 0 61 0 26 1 13 0 27 0 69 0 33 0 73 0 34 1 17 0 35] 
#[0 1 21 0 6] 
#[1 0 98 0 1 0 101 0 4 0 98 0 8 0 105 0 13 0 109 0 23 0 113 0 24 0 98 0 49] 
#[0 0 102 0 1 0 8 0 49] 
#[0 0 106 0 1 0 8 0 49] 
#[0 0 110 0 1 0 8 0 13 0 49] 
#[0 0 114 0 1 0 8 0 13 0 49] 
#[0 0 118 0 2 0 3 0 6 0 7 0 10 0 15 0 49] 
#[0 0 122 0 2 0 3 0 6 0 7 0 10 0 15 0 49] 
#[0 0 126 0 2 0 3 0 6 0 7 0 10 0 15 0 49] 
#[0 0 130 0 2 0 3 0 6 0 7 0 10 0 15 0 49] 
#[0 0 134 0 2 0 3 0 6 0 7 0 10 0 15 0 49] 
#[1 0 138 0 3 1 25 0 7 0 138 0 15 0 138 0 49] 
#[0 0 142 0 2 0 3 0 6 0 7 0 10 0 15 0 49] 
#[0 0 146 0 2 0 3 0 6 0 7 0 10 0 15 0 49] 
#[0 0 150 0 2 0 3 0 6 0 7 0 10 0 15 0 49] 
#[0 0 154 0 2 0 3 0 6 0 7 0 10 0 15 0 49] 
#[0 0 158 0 8 0 49] 
#[1 1 29 0 7 0 162 0 9] 
#[0 1 33 0 9] 
#[0 1 37 0 3] 
#[0 0 166 0 2 0 10] 
#[1 0 170 0 2 1 41 0 10] 
#[0 1 45 0 2] 
#[0 1 49 0 9] 
#[0 0 174 0 2 0 10] 
#[0 0 178 0 2 0 10] 
#[0 0 182 0 2 0 10] 
#[1 0 125 0 1 0 38 0 8 0 38 0 49] 
#[0 0 186 0 8 0 49] 
#[1 0 25 0 3 0 37 0 19 0 37 0 20 0 37 0 21 0 61 0 22 0 61 0 25 0 61 0 26 1 13 0 27 0 69 0 33 0 73 0 34 1 53 0 35] 
#[0 0 190 0 8 0 49] 
#[0 0 194 0 49] 
#[0 0 198 0 1 0 4 0 8 0 13 0 49] 
#[1 1 57 0 3 1 61 0 37 1 65 0 46 1 69 0 47] 
#[0 1 73 0 3] 
#[1 0 177 0 11 1 77 0 29] 
#[1 0 173 0 3 0 177 0 11 0 181 0 12 0 185 0 16 0 189 0 17 1 81 0 28 1 81 0 29 1 81 0 39 1 81 0 42 1 81 0 48] 
#[1 0 202 0 2 0 217 0 3 0 221 0 14 0 225 0 15 1 85 0 30 0 241 0 37 1 85 0 38 1 85 0 40 1 89 0 44] 
#[0 0 206 0 8 0 49] 
#[1 0 173 0 3 0 177 0 11 0 181 0 12 0 185 0 16 0 189 0 17 1 93 0 28 1 93 0 29 1 93 0 39 1 93 0 42 1 93 0 48] 
#[0 0 210 0 49] 
#[0 0 162 0 9] 
#[0 1 97 0 9] 
#[1 1 101 0 6 1 105 0 10] 
#[0 0 214 0 6 0 10] 
#[0 1 109 0 6] 
#[0 0 218 0 2 0 10] 
#[1 0 222 0 2 1 113 0 7 0 222 0 10] 
#[0 0 226 0 2 0 10] 
#[0 0 230 0 2 0 10] 
#[0 0 234 0 2 0 10] 
#[1 0 173 0 3 0 177 0 11 0 181 0 12 0 185 0 16 0 189 0 17 1 117 0 28 1 117 0 29 1 117 0 39 1 117 0 42 1 117 0 48] 
#[0 0 238 0 3 0 15 0 49] 
#[1 1 57 0 3 1 61 0 37 1 121 0 47] 
#[0 1 125 0 9] 
#[1 1 57 0 3 1 61 0 37 1 129 0 46 1 69 0 47] 
#[0 0 242 0 6 0 10] 
#[0 0 246 0 6 0 10] 
#[1 0 177 0 11 1 133 0 29] 
#[1 1 137 0 6 1 105 0 10] 
#[0 0 250 0 2 0 10] 
#[0 0 254 0 2 0 10]
	).
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForBooleanPropertyValue1: nodes [
	| result |
	result := GtRobocoderMetamodelBooleanPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForCompositeLevel1: nodes [
	| result |
	result := GtRobocoderMetamodelCompositeLevelNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result ands.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
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
GtRobocoderMetamodelParser >> reduceActionForDefinition3: nodes [
	| result |
	result := GtRobocoderMetamodelDefinitionNode new.
	result level: (nodes at: 1).
	result properties: (nodes at: 3).
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

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionFor__and__and__SimpleLevel__item__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionFor__and__and__SimpleLevel__item___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionFor__and__and__SimpleLevel__item___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]
