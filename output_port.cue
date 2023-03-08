#OM_DataType:   string & =~"(?i)^(NUMBER|TINYINT|SMALLINT|INT|BIGINT|BYTEINT|BYTES|FLOAT|DOUBLE|DECIMAL|NUMERIC|TIMESTAMP|TIME|DATE|DATETIME|INTERVAL|STRING|MEDIUMTEXT|TEXT|CHAR|VARCHAR|BOOLEAN|BINARY|VARBINARY|ARRAY|BLOB|LONGBLOB|MEDIUMBLOB|MAP|STRUCT|UNION|SET|GEOGRAPHY|ENUM|JSON)$"
#OM_Constraint: string & =~"(?i)^(NULL|NOT_NULL|UNIQUE|PRIMARY_KEY)$"


#OM_TableData: {
	columns: [... string]
	rows: [... [...]]
}

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
	description?:        string | null
	fullyQualifiedName?: string | null
	tags?: [... #OM_Tag]
	constraint?:      #OM_Constraint | null
	ordinalPosition?: number | null
	if dataType =~ "(?i)^(JSON)$" {
		jsonSchema: string
	}
	if dataType =~ "(?i)^(MAP|STRUCT|UNION)$" {
		children: [... #OM_Column]
	}
}
 
 
#DataContract: {
	schema: [... #OM_Column]
	...
}


#OutputPort: {
	dataContract:     #DataContract
	sampleData?:      #OM_TableData | null
	...
	
	
	checks: {
        
        
        schemaColumns: [ for n in dataContract.schema {n.name} ]
        #mustHave: schemaColumns
        
        //sampleColumns should be exactly the same of data contract
        sampleColumns: [ for n in sampleData.columns {n} ]
        //create an array with the same size of sampleColumns
        #columnsMask: [ for n in sampleColumns {_} ]
        sampleColumnsCheck: sampleColumns & #mustHave
        
        //we want minimum 5 rows in the sample data
        #minRows: [_,_,_,_,_]
        rows: [for n in sampleData.rows {n}] & #minRows
        
        //Let's check all the rows have the same size of columns
        rows: [...#columnsMask]
        
    }
}



#Component: {
	kind: string & =~"(?i)^(outputport|_)$"
	if kind != _|_ {
		if kind =~ "(?i)^(outputport)$" {
			#OutputPort
		}
	}
	...
}