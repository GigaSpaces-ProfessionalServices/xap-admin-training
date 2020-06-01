#!/bin/bash

echo "**** Start Create Admin *****"
if [[ -z "${heap_size_check}" ]]; then
 export heap_size_check=30
fi

if [[ -z "${max_time_to_check}" ]]; then
  export max_time_to_check=20
fi

exec groovy -cp "target/*" admin.groovy
