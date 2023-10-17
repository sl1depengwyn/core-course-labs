#!/bin/bash
TERRAFORM_INVENTORY=`which terraform-inventory`
"$TERRAFORM_INVENTORY" "$@" "terraform/"