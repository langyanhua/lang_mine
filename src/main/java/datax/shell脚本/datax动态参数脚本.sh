#!/bin/bash
t=`date +%F`
echo -e "+++++++++++++++++++++++++++++++++++++\n$t\n+++++++++++++++++++++++++++++++++++++" >> /data/bigwork/lang/error.txt
`hadoop fs -rm -r -f /user/hive/warehouse/juxin_ods_mysql.db/*/*`
#获取192.168.1.16的状态
s=`hdfs haadmin -getServiceState namenode117`
if [ $s = active ]
then
    url="-Durl=hdfs://192.168.1.16:8020"
else
    url="-Durl=hdfs://192.168.1.7:8020"
fi
#执行每个datax脚本,如果出错，就把出错的日期和文件名追加到error.txt
for file in `ls /data/bigwork/lang/job`
    do
        /data/juxin/com.juxin.etl/datax/bin/datax.py -p $url /data/bigwork/lang/dingshi/job/$file
        if [ $? -eq 1 ]
        then
            echo $file >> /data/bigwork/lang/error.txt
        fi
    done
echo -e "+++++++++++++++++++++++++++++++++++++\n$t\n+++++++++++++++++++++++++++++++++++++" >> /data/bigwork/lang/error.txt