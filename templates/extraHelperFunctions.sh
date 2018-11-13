#!/bin/bash

function prepVarForDeclaration() {
	local name=$1
	local type=$2
	local option=$3
	local docs=$4
	
	retval=''
	retval+='/**'"$N"
	retval+=' * '"$docs $N"
	retval+=' */'"$N"
	if [ "$option" = 'true' ]; then
		retval+="$name"'?:'"$type"';'"$N"
	else
		retval+="$name"':'"$type"';'"$N"
	fi
}

# function prepVarForConstruction() {
	
# }

function prepVarForConstructionInternal() {
	local name=$1
	local type=$2
	local option=$3
	local docs=$4

	retval=''
	if [ "$option" = 'true' ]; then
		retval+='if (useData.'"$name"' !== undefined) {'"$N"
		retval+="$T"'this.'"$(snakeCaseToPascal ${name#\"})"' = useData.'"$name"';'"$N"
		retval+='}'"$N"
	else
		retval+='this.'"$(snakeCaseToPascal ${name#\"})"' = useData.'"$name"';'"$N"
	fi
}
