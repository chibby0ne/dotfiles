#!/bin/bash

# Gets the id of the Touchpad. This may change between boots/starts of X
id=$(xinput | grep Touchpad | sed 's/.*id=\([0-9]\+\).*/\1/')

# returns 1 if it's disabled, 0 if it's enabled
ret=$(xinput list $id | grep -c disabled)

if [[ $ret -eq 0 ]]; then
    # it is enabled, let's disable it
    xinput disable $id
else
    # it is disabled, let's enable it
    xinput enable $id
fi
