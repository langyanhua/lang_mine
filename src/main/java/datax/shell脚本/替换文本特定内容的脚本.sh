#!/bin/bash
#将 hdfs://192.168.1.16:8020 替换为 $url
for file in `ls /data/bigwork/lang/job`
    do
        sed -i 's/hdfs:\/\/192.168.1.16:8020/$url/' /data/bigwork/lang/job/$file
    done