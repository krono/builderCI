#!/bin/bash -x
#
# Test driver script for builderCI itself
#
# Copyright (c) 2012 VMware, Inc. All Rights Reserved <dhenrich@vmware.com>.
#
./build.sh -i $ST -m -f "$BUILDER_CI_HOME/tests/travisCI.st" -o travisCI
if [[ $? != 0 ]] ; then exit 1; fi
cd "${BUILD_PATH}/travisCI/"
$BUILDER_CI_HOME/buildImageErrorCheck.sh # dump Transcript on error and exit
if [[ $? != 0 ]] ; then exit 1; fi
$BUILDER_CI_HOME/buildTravisStatusCheck.sh # dump Transcript on failed tests and exit
if [[ $? != 0 ]] ; then exit 1; fi
cat TravisTranscript.txt

./build.sh -i $ST -X -f "$BUILDER_CI_HOME/tests/skipMetacelloBootstrap.st" -o travisCI
if [[ $? != 0 ]] ; then exit 1; fi
cd "${BUILD_PATH}/travisCI/"
$BUILDER_CI_HOME/buildImageErrorCheck.sh
if [[ $? != 0 ]] ; then exit 1; fi
$BUILDER_CI_HOME/buildTravisStatusCheck.sh 
if [[ $? != 0 ]] ; then exit 1; fi
cat TravisTranscript.txt
