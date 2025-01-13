#!/bin/bash
echo "Collecting your roles and inventory"
ansible-galaxy install -r roles/requirements.yml -p roles/
git clone git@github.com:yanosliger-dev/inventories.git
