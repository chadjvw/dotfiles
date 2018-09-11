#!/bin/bash

{{ansible_hostname}}

while getopts ":d:" opt; do
  case $opt in
    d)
        if [ -e /mnt/c/PCI/domain/$OPTARG]; then
            echo "Removing caches for domain $OPTARG"
            rm -rf /mnt/c/PCI/domain/$OPTARG/servers/{{ ansible_hostname }}/cache
            rm -rf /mnt/c/PCI/domain/$OPTARG/servers/{{ ansible_hostname }}/tmp
            rm -rf /mnt/c/PCI/domain/$OPTARG/servers/{{ ansible_hostname }}/data/store
            rm -rf /mnt/c/PCI/domain/$OPTARG/applications/GenPortal.ear/META-INF/.WL_internal
            echo "Finished."
        else
            echo "Domain /mnt/c/PCI/domain/$OPTARG does not exist.""
        fi
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done