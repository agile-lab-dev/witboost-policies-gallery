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
   bucketName: "aws-ia-mwaa-eu-west-1-621415221771"
}