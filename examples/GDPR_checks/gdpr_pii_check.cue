package generic_dp

// All the data types that starts with OM_ are imported from OpenMetadata definitions

import "strings"
import "list"

#DPVersion:        string & =~"^([0-9]+\\.[0-9]+\\-SNAPSHOT\\-[0-9]+|[0-9]+\\.[0-9]+\\..+)$"
#ComponentVersion: string & =~"^([0-9]+\\.[0-9]+\\..+)$"
#Id:               string & =~"^[a-zA-Z0-9:._-]+$"
#DataProductId:    #Id & =~"^urn:dmb:dp:\(domain):[a-zA-Z0-9_-]+:\(majorVersion)$"
#ComponentId:      #Id & =~"^urn:dmb:cmp:\(domain):[a-zA-Z0-9_-]+:\(majorVersion):[a-zA-Z0-9_-]+$"
#URL:              string & =~"^https?://[a-zA-Z0-9@:%._~#=&/?]*$"
#OM_DataType:      string & =~"(?i)^(NUMBER|TINYINT|SMALLINT|INT|BIGINT|BYTEINT|BYTES|FLOAT|DOUBLE|DECIMAL|NUMERIC|TIMESTAMP|TIME|DATE|DATETIME|INTERVAL|STRING|MEDIUMTEXT|TEXT|CHAR|VARCHAR|BOOLEAN|BINARY|VARBINARY|ARRAY|BLOB|LONGBLOB|MEDIUMBLOB|MAP|STRUCT|UNION|SET|GEOGRAPHY|ENUM|JSON)$"
#OM_Constraint:    string & =~"(?i)^(NULL|NOT_NULL|UNIQUE|PRIMARY_KEY)$"



#OM_Tag: {
	tagFQN:       string
	description?: string | null
	source:       string & =~"(?i)^(Tag|Glossary)$"
	labelType:    string & =~"(?i)^(Manual|Propagated|Automated|Derived)$"
	state:        string & =~"(?i)^(Suggested|Confirmed)$"
	href?:        string | null
}

#OM_Column: {
	name:     string
	dataType: #OM_DataType
	if dataType =~ "(?i)^(ARRAY)$" {
		arrayDataType: #OM_DataType
	}
	if dataType =~ "(?i)^(CHAR|VARCHAR|BINARY|VARBINARY)$" {
		dataLength: number
	}
	dataTypeDisplay?:    string | null
	description?:        string
	fullyQualifiedName?: string | null
	tags:               [... #OM_Tag]
	constraint?:         #OM_Constraint | null
	ordinalPosition?:    number | null
	if dataType =~ "(?i)^(JSON)$" {
		jsonSchema: string
	}
	if dataType =~ "(?i)^(MAP|STRUCT|UNION)$" {
		children: [... #OM_Column]
	}
	...
}

#DataContract: {
	schema: [... #OM_Column]
	...
}


#OutputPort: {
	id:                       #ComponentId
	name:                     string
	fullyQualifiedName?:      string | null
	description:              string
	version:                  #ComponentVersion & =~"^\(majorVersion)+\\..+$"
	infrastructureTemplateId: string
	useCaseTemplateId?:       string | null
	dependsOn:                [...#ComponentId] | null
	platform?:                string | null
	technology?:              string | null
	outputPortType:           string
	creationDate?:            string | null
	startDate?:               string | null
	processDescription?:      string | null
	dataContract:             #DataContract
	tags: [... #OM_Tag]
	...
}


#Component: {
	kind: string & =~"(?i)^(outputport|workload|storage|observability)$"
	if kind != _|_ {
		if kind =~ "(?i)^(outputport)$" {
			#OutputPort
		}
	}
	...
}

id:                  #DataProductId
name:                string
fullyQualifiedName?: string | null
description:         string
kind:                string & =~"(?i)^(dataproduct)$"
domain:              string
version:             #DPVersion
let majorVersion = strings.Split(version, ".")[0]
environment:                 string
dataProductOwner:            string
dataProductOwnerDisplayName: string
devGroup:                    string
ownerGroup:                  string
email?:                      string | null
informationSLA?:             string | null
status?:                     string & =~"(?i)^(draft|published|retired)$" | null
maturity?:                   string & =~"(?i)^(tactical|strategic)$" | null
billing?:                    {...} | null
tags: [... #OM_Tag]
specific: {...}
components: [#Component, ...#Component]
...

checks: {

	if len(tags) != 0 {	
		gdprTags: [ for n in tags if n.tagFQN =~ "(?i)^(GDPR)$" {n.tagFQN} ]
		
		if len(gdprTags) != 0 {
			columns: list.FlattenN([ for n in components if n.kind =~ "(?i)^(outputport)$" {n.dataContract.schema} ],1)
			allTags: list.FlattenN([ for n in columns {n.tags} ],1)
			piiColumns: [ for n in allTags if n.tagFQN =~ "(?i)^(PII)$" {n.tagFQN} ]

			test: len(piiColumns) &>= 1
		}

	}

}
