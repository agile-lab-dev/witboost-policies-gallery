name!: string
fullyQualifiedName?: null | string
description: string
kind: "workload"
version: string
infrastructureTemplateId: string
useCaseTemplateId: string
dependsOn: [...string]
tags: [...string]
readsFrom: [...string]
specific: {
	dbtProjectName!: string
	gitUrl: string
	cloudStorage: {
		storageProvider!: string
		bucketURI!: string
		region!: string
		secretString!: string
	}
}