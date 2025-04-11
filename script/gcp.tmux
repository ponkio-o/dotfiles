#!/usr/bin/env bash

GCP_CONFIG_FILE=~/.config/gcloud/active_config
GCP_SYMBOL=$'☁'
GCP_PROJECT=Unknown

if [ -f $CONFIG_FILE ]; then
    GCP_PROJECT=$(cat $GCP_CONFIG_FILE)
fi

GCP_TMUX+="#[fg=blue]$GCP_SYMBOL "
GCP_TMUX+="#[fg=white]$GCP_PROJECT"

echo $GCP_TMUX
