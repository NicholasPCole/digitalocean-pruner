#!/bin/bash

ALL_DROPLETS=$(doctl compute droplet list -o json)
untagged_droplet_count=$(echo "${ALL_DROPLETS}" | jq '[.[] | select (.tags | length == 0)] | length')

if [ "${untagged_droplet_count}" == 0 ]; then
    echo "All Droplets are tagged."
    exit
fi

echo "Droplets found untagged:"
echo "${ALL_DROPLETS}" | jq -c '.[] | select (.tags | length == 0) | {id: .id, name: .name}'
echo "Destroy these ${untagged_droplet_count} Droplets?"

select confirmation in "Yes" "No"; do
    case $confirmation in
        "Yes")
            untagged_droplet_id_list=$(echo "${ALL_DROPLETS}" | jq '.[] | select (.tags | length == 0) | .id')
            for droplet_id in ${untagged_droplet_id_list}; do
                #echo "Deleting ${droplet_id}..."
                doctl compute droplet delete --force ${droplet_id}
            done
            break;;
        "No")
            exit;;
        *)
            echo "Please choose Yes or No.";;
    esac
done
