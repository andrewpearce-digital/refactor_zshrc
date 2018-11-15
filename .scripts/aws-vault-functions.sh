#!/bin/bash

# aws-vault for lpa-dev profile
lpa-dev() {      
aws-vault exec lpa-dev -- $@
}

# aws-vault for opg-shared profile
opg-shared() {      
aws-vault exec opg-shared -- $@
}