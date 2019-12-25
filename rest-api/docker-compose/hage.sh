#!/usr/bin/env bash

ROOT_DIR=$( cd $( dirname ${BASH_SOURCE:-$0} ) && pwd )

     /bin/sh -c "
        while [ `wget -O /dev/stdout http://localhost:9200/_cat/health | awk '{print $4}'` != 'greenn' ] ;
        do
          echo "come";
          sleep 3;
        done ;

        echo 'elastic search ready!'"

