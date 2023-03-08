#SchemaDefinition: {
  name: string
  dataType: string
  constraint?: string | null
}

#TablesDefinition: {
  tableName: string
  schema: [#SchemaDefinition, ...#SchemaDefinition]
}

specific: {
  tables: [#TablesDefinition, ...#TablesDefinition]
}
