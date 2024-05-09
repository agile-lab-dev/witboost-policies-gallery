import "list"



#Component: {
	kind: string & =~"(?i)^(outputport|workload|storage|observability)$"
	if kind != _|_ {
		if kind =~ "(?i)^(outputport)$" {
			#OutputPort
		}
	}
	...
}

#OutputPort: {
    id: string
	dataContract:     #DataContract
	...
}

#OM_Column: {
	name:     string
	...
}
 
 
#DataContract: {
	schema: [... #OM_Column]
	...
}


original: { 
  components: [...#Component]
  ... 
}

current: { 
  components: [...#Component]
  ... 
}



	
	
_checks: {
    
	current_outputports: [ for n in current.components if n.kind =~ "(?i)^(outputport)$" {n} ]
    prev_outputports: [ for n in original.components if n.kind =~ "(?i)^(outputport)$" {n} ]
    
    prevOutputPortsNames: [for n in prev_outputports {n.name}]

    
    presentInBoth: [for n in current_outputports if list.Contains(prevOutputPortsNames,n.name){n} ]
    
    curr_schema: [for n in presentInBoth {n.dataContract.schema}]
    #prev_schema: [for n in prev_outputports {n.dataContract.schema}]
    
    test: curr_schema & #prev_schema
}
