#SchemaDefinition: {
  name: string
  dataType: string & =~"(?i)^(TEXT|NUMBER|DATE|BOOLEAN)$"
  constraint?: string & =~"(?i)^(PRIMARY_KEY|NOT_NULL|UNIQUE)$" | null
  if dataType =~ "(?i)^TEXT$" {
    dataLength: int & >0 & <=16777216
  }
  if dataType =~ "(?i)^NUMBER" {
    precision: int & >0 & <=38
    scale: int & >=0 & <=(precision-1)
  }
}

dependsOn: [string, ...string]

dataContract: {
  schema: [#SchemaDefinition, ...#SchemaDefinition]
  ...
}

specific: {
  schema: string
  database: string
  tableName: string
  viewName: string
}
