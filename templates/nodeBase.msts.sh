#!/bin/bash

function msts() {

	source './templates/extraHelperFunctions.sh'

	OUTPUT=""
	IMPORTS=""
	VAR_DECLARATIONS=""
	CONSTRUCTOR_DECLARATIONS=""
	METHOD_DECLARATIONS=""
	INTERNAL_CLASS=""
	AFTER_CLASS=""
	# "${EXAMPLE_VAR#\"}"
	# import EXAMPLE_VAR from "../api-abstractions/EXAMPLE_VAR";

	# "apiNodeName": "build",
	# "docs": "This resource returns the current build id of the game. This can be used, for example, to register when event timers reset due to server restarts.",
	# "isAuthenticated": false,
	# "isLocalized": false,
	# "isDisabled": false,
	# "isVariablePath": false,
	# "isChild": true,
	# "parentNode": "root",
	# "isParent": false,
	# "isList": false,
	# "isElement": false,
	# "hasData": true,
	# "apiDataVariables": [
	# {
	# "name": "id",
	# "type": "number",
	# "isOptional": false,
	# "docs": "The current build id of the game."
	# }
	# ]


	getJSONToBashVar 'apiNodeName'
	apiNodeName="$CURRENT_JSON_TO_BASH_VAR"

	getJSONToBashVar 'docs'
	docs="$CURRENT_JSON_TO_BASH_VAR"

	getJSONToBashVar 'isAuthenticated'
	isAuthenticated="$CURRENT_JSON_TO_BASH_VAR"

	getJSONToBashVar 'isLocalized'
	isLocalized="$CURRENT_JSON_TO_BASH_VAR"

	getJSONToBashVar 'isDisabled'
	isDisabled="$CURRENT_JSON_TO_BASH_VAR"

	getJSONToBashVar 'isVariablePath'
	isVariablePath="$CURRENT_JSON_TO_BASH_VAR"

	getJSONToBashVar 'isChild'
	isChild="$CURRENT_JSON_TO_BASH_VAR"

	getJSONToBashVar 'isParent'
	isParent="$CURRENT_JSON_TO_BASH_VAR"

	getJSONToBashVar 'isList'
	isList="$CURRENT_JSON_TO_BASH_VAR"

	getJSONToBashVar 'isElement'
	isElement="$CURRENT_JSON_TO_BASH_VAR"

	getJSONToBashVar 'hasData'
	hasData="$CURRENT_JSON_TO_BASH_VAR"

	echo "$isChild"
	if [ "$isChild" = "true" ]; then
		getJSONToBashVar 'parentNode'
		parentNode="$CURRENT_JSON_TO_BASH_VAR"
		IMPORTS+='import '"$(snakeCaseToPascal ${parentNode#\"})"' from "../'"${parentNode#\"})"';'"$N"
	fi

	if [ "$hasData" = 'true' ]; then
		CURRENT_TEMPLATE_VAR_ROOT=''
		runTemplate 'nodeInternalData'
		INTERNAL_CLASS+="${CURRENT_TEMPLATE_RUN}"
	fi

	echo 'HI!'
	echo $OUTPUT
	echo $INTERNAL_CLASS
}

