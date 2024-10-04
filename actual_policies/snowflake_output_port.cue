name!:                     string
fullyQualifiedName?:       null | string
description!:              string
kind!:                     "outputport"
version!:                  string & =~"^[0-9]+\\.[0-9]+\\..+$"
infrastructureTemplateId!: string
useCaseTemplateId!:        string
dependsOn: [...string]
platform!:            "Snowflake"
technology!:          "Snowflake"
outputPortType!:      "SQL"
dataContract:         #DataContract
dataSharingAgreement: #DataSharingAgreement
tags: [...#OM_Tag]
readsFrom: [...string]
dependsOn: [string, ...string]
specific: {
	schema!:    string
	database!:  string
	tableName!: string
	viewName!:  string
}

#DataContract: {
	schema: [#SchemaDefinition, ...#SchemaDefinition]
	SLA: {
		intervalOfChange?: string | null
		timeliness?:       string | null
		upTime?:           string | null
		...
	}
	termsAndConditions?: string | null
	endpoint?:           #URL | null
	biTempBusinessTs?:   string | null
	biTempWriteTs?:      string | null
	...
}

#DataSharingAgreement: {
	purpose?:         string | null
	billing?:         string | null
	security?:        string | null
	intendedUsage?:   string | null
	limitations?:     string | null
	lifeCycle?:       string | null
	confidentiality?: string | null
	...
}

#URL: string & =~"^https?://[a-zA-Z0-9@:%._~#=&/?]*$"
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
