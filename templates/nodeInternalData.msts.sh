#!/bin/bash

function msts() {

	INTERNAL_DATA_OUTPUT=""
	INTERNAL_DATA_VARIABLES=""
	INTERNAL_DATA_CONSTRUCTOR=""
	INTERNAL_CLASS_INTERNAL_CLASS=""
	STARTING_POINT=$CURRENT_TEMPLATE_VAR_ROOT


	

	if [ "$STARTING_POINT" = '' ]; then
		dataName="$apiNodeName"'Data'
	else
		getJSONToBashVar "$STARTING_POINT"'name'
		dataName=$CURRENT_JSON_TO_BASH_VAR
	fi
	getJSONToBashArray "$STARTING_POINT"'apiDataVariables'
	apiDataVariables=("${CURRENT_JSON_TO_BASH_ARRAY[@]}")
	length=${#apiDataVariables[@]}

	for ((i=1;i<length;i++)); do

		getJSONToBashVar "$STARTING_POINT"'apiDataVariables['"$i"'].name'
		currentVarName=$CURRENT_JSON_TO_BASH_VAR

		getJSONToBashVar "$STARTING_POINT"'apiDataVariables['"$i"'].type'
		currentVarType=$CURRENT_JSON_TO_BASH_VAR

		getJSONToBashVar "$STARTING_POINT"'apiDataVariables['"$i"'].isOptional'
		currentVarIsOptional=$CURRENT_JSON_TO_BASH_VAR

		getJSONToBashVar "$STARTING_POINT"'apiDataVariables['"$i"'].docs'
		currentVarDocs=$CURRENT_JSON_TO_BASH_VAR

		getJSONToBashVar "$STARTING_POINT"'apiDataVariables['"$i"'].subTypes'
		currentVarSub=$CURRENT_JSON_TO_BASH_VAR

		if [ "$currentVarSub" != 'null' ]; then

			getJSONToBashArray "$STARTING_POINT"'apiDataVariables['"$i"'].subTypes'
			dataSubtypes=("${CURRENT_JSON_TO_BASH_ARRAY[@]}")
			lengthSub=${#dataSubtypes[@]}

			for ((j=1;j<length;j++)); do

				CURRENT_TEMPLATE_VAR_ROOT = "$STARTING_POINT"'apiDataVariables['"$i"'].subTypes['"$j"'].'
				runTemplate 'nodeInternalData'
				INTERNAL_CLASS_INTERNAL_CLASS+="$CURRENT_TEMPLATE_RUN"

			done
		fi

		prepVarForDeclaration "$currentVarName" "$currentVarType" "$currentVarIsOptional" "$currentVarDocs"

		INTERNAL_DATA_VARIABLES+="${N}${retval}${N}"

		prepVarForConstructionInternal "$currentVarName" "$currentVarType" "$currentVarIsOptional" "$currentVarDocs"

		INTERNAL_DATA_CONSTRUCTOR+="${N}${T}${retval}${N}"

	done

	prepVarForDeclaration 'raw' 'object' 'false' 'The raw input data from the endpoint'
	INTERNAL_DATA_VARIABLES+="${N}${retval}${N}"


	INTERNAL_DATA_OUTPUT+="$T"'class '"$dataName"' {'"$N"
	INTERNAL_DATA_OUTPUT+="${INTERNAL_DATA_VARIABLES}${N}"

	# constructor(rawData: object) {
	# 	this.raw = rawData;
	# 	let useData = rawData as KeyValueInterface;

	INTERNAL_DATA_OUTPUT+="$N"'constructor(rawData: object) {'"$N"
	INTERNAL_DATA_OUTPUT+="$T"'this.raw = rawData;'"$N"
	INTERNAL_DATA_OUTPUT+="$T"'let useData = rawData as KeyValueInterface;'"$N"
	INTERNAL_DATA_OUTPUT+="${INTERNAL_DATA_CONSTRUCTOR}${N}"
	INTERNAL_DATA_OUTPUT+='}'"$N"
	INTERNAL_DATA_OUTPUT+="${N}${INTERNAL_CLASS_INTERNAL_CLASS}${N}"'}'

	echo "$INTERNAL_DATA_OUTPUT"

}