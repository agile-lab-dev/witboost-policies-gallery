kind!:              "workload"
id!:                string
description!:       string
name!:              string & =~"^[ a-zA-Z0-9:._-]+$"
fullyQualifiedName: string | null
version!:           =~"^[0-9]+\\.[0-9]+\\.[0-9]+$"
dependsOn: [...string]
tags: [...#OM_Tag]
readsFrom: [...string]
specific: {
	scheduleCron!:    string
	dagName!:         string
	destinationPath!: "dags/"
	sourcePath!:      "source/"
	bucketName!:      "bucketname"
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
