import "list"

components: [...{
	kind:            string
	technology:      string
	outputPortType?: string | null
	if technology =~ "(?i)^(Dremio)$" {
		if kind =~ "(?i)^(outputport)$" {
			if outputPortType =~ "(?i)^(SQL view)$" {
				specific: #DremioOutputport
			}
			if outputPortType =~ "(?i)^(Consumer Views)$" {
				specific: #ConsumerView
			}
		}
		if kind =~ "(?i)^(storage)$" {
			specific: #DremioStorage
		}
		if kind =~ "(?i)^(workload)$" {
			specific: #DremioWorkload
		}
	}
	...
}]

#Name: string & =~"^[a-zA-Z0-9:._-]+$"

#MeasureFields: {
	name: #Name
	measureTypeList: [... string & =~"(?i)^(MIN|MAX|SUM|COUNT|APPROX_COUNT_DISTINCT)$"]
	...
}

#DimensionFields: {
	name:         #Name
	granularity?: string & =~"(?i)^(NORMAL|DATE)$"
	...
}

#ReflectionDefinition: {
	name: #Name
	type: string & =~"(?i)^(RAW|AGGREGATION)$"
	if type =~ "(?i)^(RAW)$" {
		displayFields: [... {
			name: #Name
		}]
	}
	distributionFields: [... {
		name: #Name
	}]
	partitionFields: [... {
		name: #Name
	}]
	sortFields?: [{
		name: #Name
		...
	}]
	if type =~ "(?i)^(AGGREGATION)$" {
		dimensionFields: [... #DimensionFields]
	}
	if type =~ "(?i)^(AGGREGATION)$" {
		measureFields: [... #MeasureFields]
	}
	partitionDistributionStrategy?: string & =~"(?i)^(CONSOLIDATED|STRIPED)$"
	...
}

#supportVds: {
	name: #Name
	sql:  string
	dependsOn?: [... string] | null
	reflectionDefinitions: [... #ReflectionDefinition]
	...
}

#supportPds: {
	name:      #Name
	location?: string | null
	reflectionRefresh?: {
		refreshEvery: string
		expireAfter:  string
		method:       string & =~"(?i)^(FULL|INCREMENTAL)$"
		...
	}
	format?: {
		type: string & =~"(?i)^(Text|Parquet|Iceberg)$"
		if type =~ "(?i)^(Text)$" {
			fieldDelimiter:          string | null
			lineDelimiter:           string | null
			escape:                  string | null
			skipFirstLine:           bool | null
			extractHeader:           bool | null
			trimHeader:              bool | null
			autoGenerateColumnNames: bool | null
		}
	}
	...
}

#DremioOutputport: {
	sql?: string | null
	dependsOn?: [...] | null
	reflectionDefinitions?: [...#ReflectionDefinition]
	supportVds?: [... #supportVds]
	supportPds?: [... #supportPds]

	_checks: {
		//check each element mentioned in dependsOn has a declaration inside supportVds, supportPds

		// 1- list of all dataset
		listDataset: list.Sort([for n in supportVds {n.name}, for x in supportPds {x.name}], list.Ascending)

		//2- list of all dependencies
		dependsOnFromVds: list.FlattenN([for z in supportVds {z.dependsOn}], 1)
		listDependsOn: list.Sort([for q in dependsOn {q}, for y in dependsOnFromVds {y}], list.Ascending)

		//3- verify each dependencies must have a related dataset
		dependsChecks: listDataset & listDependsOn
	}
	...
}

#DremioWorkload: {
	artifactVersion?:         string | null
	artifactName?:            string | null
	gcsInternalStorageAreaId: string
	targetTableStorageAreaId: string
	sqlBatches: [...]
	placeholders: [...]
	destinationPath?: string | null
	tableName?:       string | null
	sqlStatement?:    string | null
	...
}

#DremioStorage: {
	externalSourceTables: [...{
		destinationPath:   string
		tableName:         string
		columnsDefinition: string
	}]
	...
}

#ConsumerView: {
	//not needed in consumer view but left for now for backward compability with output port
	sql: string
	dependsOn?: [...] | null
	supportVds?: [] | null
	supportPds?: [] | null
	...
}
