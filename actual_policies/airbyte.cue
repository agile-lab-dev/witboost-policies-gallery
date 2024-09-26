kind:                     "workload"
id:                       string
description:              string
name:                     string
fullyQualifiedName?:      null | string
version:                  string
infrastructureTemplateId: string
useCaseTemplateId:        string
dependsOn: [...string]
tags: [...#OM_Tag]
readsFrom: [...string]
specific: {
	source: {
		name: string
		connectionConfiguration: {
			url:    string
			format: "csv" | "json" | "jsonl" | "excel" | "excel_binary" | "feather" | "parquet" | "yaml"
			provider: {
				storage:    "HTTPS" | "GCS" | "S3" | "AzBlob" | "SSH" | "SCP" | "SFTP"
				user_agent: bool
			}
			dataset_name: string
		}
	}

	destination: {
		name: string
		connectionConfiguration: {
			database: string
			schema:   string
		}
	}

	connection: {
		name:       string
		dbtGitUrl?: null | string
	}
}

#OM_Tag: {
	tagFQN:       string
	description?: string | null
	source:       string & =~"(?i)^(Tag|Glossary)$"
	labelType:    string & =~"(?i)^(Manual|Propagated|Automated|Derived)$"
	state:        string & =~"(?i)^(Suggested|Confirmed)$"
	href?:        string | null
}
