#!/usr/bin/env bash

# run tmux-mem-cpu-load, replacing null char to avoid bash warning
stats="$(tmux-mem-cpu-load --averages-count 0 --graph-lines 0 | tr '\0' ' ')"

# extract numbers from tmux-mem-cpu-load output
used_mem_mb="$(echo $stats | sed 's/\/.*//')"
total_mem_mb="$(echo $stats | sed 's/.*\///; s/MB.*//')"
cpu_percent="$(echo $stats | sed 's/.* //; s/%//')"

# make necessary conversions
used_mem_gb="$(bc <<< "scale=1; $used_mem_mb/1024")"
used_mem_percent="$(expr $(expr $used_mem_mb \* 100) / $total_mem_mb)"
cpu_percent_int="$(echo "$cpu_percent" | sed 's/\..*//')"

# determine colors
if [ "$used_mem_percent" -lt 51 ]; then
    mem_color=green
elif [ "$used_mem_percent" -lt 76 ]; then
    mem_color=yellow
else
    mem_color=red
fi

if [ "$cpu_percent_int" -lt 51 ]; then
    cpu_color=green
elif [ "$cpu_percent_int" -lt 76 ]; then
    cpu_color=yellow
else
    cpu_color=red
fi

# make sparks
mem_spark="$(~/dotfiles/tmux/spark "$used_mem_percent" 0 100 | cut -c 1)"
cpu_spark="$(~/dotfiles/tmux/spark "$cpu_percent_int" 0 100 | cut -c 1)"

# print it out
echo "${used_mem_gb}GB #[fg=$mem_color,bright]$mem_spark#[fg=default,default]  \
$cpu_percent% #[fg=$cpu_color,bright]$cpu_spark#[fg=default,default]"

