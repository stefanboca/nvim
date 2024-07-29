export SPINNAKER_GENTL64_CTI=/opt/spinnaker/lib/spinnaker-gentl/Spinnaker_GenTL.cti
if [[ -d /opt/spinnaker/lib/spinnaker-gentl ]] then
	if [[ -z $GENICAM_GENTL64_PATH ]] then
		export GENICAM_GENTL64_PATH=/opt/spinnaker/lib/spinnaker-gentl
	elif [[ $GENICAM_GENTL64_PATH != *"/opt/spinnaker/lib/spinnaker-gentl"* ]] then
		export GENICAM_GENTL64_PATH=/opt/spinnaker/lib/spinnaker-gentl:$GENICAM_GENTL64_PATH
	fi
fi
if [[ -d /opt/spinnaker/bin ]] then
	if ! [[ $PATH =~ "/opt/spinnaker/bin" ]] then
		PATH="$PATH:/opt/spinnaker/bin"
	fi
fi

export PATH
