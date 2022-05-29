#!/bin/bash

# Switch between core18 and core20 base snaps by updating snapcraft.yaml.
# If base is not given as an argument, switch to base snap not currently being used.

scripts_dir="$(dirname "$0")"
root_dir="$(dirname "$scripts_dir")"
snapcraft_yaml="${root_dir}/snap/snapcraft.yaml"
current_base=$(grep '^base:' "$snapcraft_yaml" | awk '{print $2}')
echo "current base: $current_base"

change_to_base() {
    # Places to change info:
    # base: core20
    # apps:
    #   map-creator:
    #     extensions: [gnome-3-38] # core20
    #   init:
    #     extensions: [gnome-3-38] # core20
    #   wine:
    #     extensions: [gnome-3-38] # core20
    #   winecfg:
    #     extensions: [gnome-3-38] # core20
    #   winetricks:
    #     extensions: [gnome-3-38] # core20
    # plugs:
    #   wine-7-stable:
    #     default-provider: wine-platform-7-stable
    # parts:
    #   sommelier-core:
    #     source-branch: "master"
    new_base="$1"
    echo "new base: $new_base"
    ext18='gnome-3-28'
    ext20='gnome-3-38'
    plug18='wine-6-stable'
    plug20='wine-7-stable'
    dp18='wine-platform-6-stable'
    dp20='wine-platform-7-stable-core20'
    br18='1.0'
    br20='master'
    if [[ "$new_base" == 'core18' ]]; then
        old_base='core20'
        old_extension=$ext20
        new_extension=$ext18
        old_wine_plug=$plug20
        new_wine_plug=$plug18
        old_default_provider=$dp20
        new_default_provider=$dp18
        old_source_branch=$br20
        new_source_branch=$br18
    elif [[ "$new_base" == 'core20' ]]; then
        old_base='core18'
        old_extension=$ext18
        new_extension=$ext20
        old_wine_plug=$plug18
        new_wine_plug=$plug20
        old_default_provider=$dp18
        new_default_provider=$dp20
        old_source_branch=$br18
        new_source_branch=$br20
    fi
    if [[ -z "$new_extension" ]]; then
        echo "ERROR: something went wrong"
        exit 1
    fi
    sed -i "s/$old_default_provider/$new_default_provider/g" "$snapcraft_yaml"
    sed -i "s/$old_base/$new_base/g" "$snapcraft_yaml"
    sed -i "s/$old_extension/$new_extension/g" "$snapcraft_yaml"
    sed -i "s/$old_wine_plug/$new_wine_plug/g" "$snapcraft_yaml"
    sed -i "s/$old_source_branch/$new_source_branch/g" "$snapcraft_yaml"
    exit 0
}

if [[ -z "$1" ]]; then
    if [[ "$current_base" == 'core18' ]]; then
        change_to_base core20
    elif [[ "$current_base" == 'core20' ]]; then
        change_to_base core18
    fi
elif [[ -n "$1" && "$1" != "$current_base" ]]; then
    if [[ "$1" == 'core18' ]]; then
        change_to_base core18
    elif [[ "$1" == 'core20' ]]; then
        change_to_base core20
    else
        echo "ERROR: bad argument: $1"
        exit 1
    fi
fi
