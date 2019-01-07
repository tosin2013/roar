#!/bin/bash

echo "Delete the Minishift VM"
minishift delete || exit $?
rm -rf ~/.minishift
rm -rf ~/.kube
