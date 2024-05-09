kind: "workload",
id: string,
description: string,
name: string & =~"^[ a-zA-Z0-9:._-]+$",
fullyQualifiedName: string | null,
version: =~"^[0-9]+\\.[0-9]+\\.[0-9]+$",
dependsOn: [...string],
tags: [...string],
readsFrom: [...string],
specific:{
   scheduleCron: string,
   dagName: string,
   destinationPath: "dags/",
   sourcePath: "source/",
   bucketName: "s3bucket"
}