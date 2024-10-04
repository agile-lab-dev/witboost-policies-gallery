name!:                     string
fullyQualifiedName?:       null | string
description!:              string
kind!:                     "storage"
version!:                  string & =~"^[0-9]+\\.[0-9]+\\..+$"
infrastructureTemplateId!: string
useCaseTemplateId!:        string
dependsOn: [...string]
platform!:    "Snowflake"
technology!:  "Snowflake"
storageType!: "Database"
tags: [...#OM_Tag]
readsFrom: [...string]
specific: {
	database!: string
	schema!:   string
	tables!: [#TablesDefinition, ...#TablesDefinition]
}

#OM_Tag: {
	tagFQN!:      string
	description?: string | null
	source!:      string & =~"(?i)^(Tag|Glossary)$"
	labelType!:   string & =~"(?i)^(Manual|Propagated|Automated|Derived)$"
	state!:       string & =~"(?i)^(Suggested|Confirmed)$"
	href?:        string | null
	...
}

#SchemaDefinition: {
	name!:       string
	dataType!:   string & =~"(?i)^(TEXT|NUMBER|DATE|BOOLEAN)$"
	constraint?: string & =~"(?i)^(PRIMARY_KEY|NOT_NULL|UNIQUE)$" | null
	if dataType =~ "(?i)^TEXT$" {
		dataLength!: int & >0 & <=16777216
	}
	if dataType =~ "(?i)^NUMBER" {
		precision!: int & >0 & <=38
		scale!:     int & >=0 & <=(precision - 1)
	}
	tags?: [...#OM_Tag]
	...
}

#TablesDefinition: {
	tableName!: string
	schema!: [#SchemaDefinition, ...#SchemaDefinition]
	...
}
