# DigitalOcean account pruner

A shell script to delete unused resources from your DigitalOcean account.

## Usage

This script deletes all Droplets in your account that do not have a tag.

Run `./digitalocean-pruner.sh`, and confirm at the prompt that you want to delete all of the Droplets. A list of Droplet IDs and names that will be removed are given first.

**Warning**: The confirmation prompt is for collectively deleting ALL Droplets; there isn't a prompt for each individual Droplet. I've used this script for several months without problem, but the standard disclaimer for data destruction applies: removing Droplets is irreversible.

## Requirements

* [doctl](https://github.com/digitalocean/doctl)
* [jq](https://stedolan.github.io/jq/)
