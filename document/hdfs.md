
# 集群大规模数据复制
```
hadoop distcp hdfs://jx-1-7:8020/juxin/data-warehouse hdfs://jx-1-29:8020/juxin/data-warehouse
hadoop distcp -update -m 500 hdfs://jx-1-107:8020/juxin/data-warehouse hdfs://jx-1-29:8020/juxin/data-warehouse
hadoop distcp -overwrite -m 500 hdfs://jx-1-107:8020/juxin/data-warehouse hdfs://jx-1-29:8020/juxin/data-warehouse
hadoop distcp -overwrite -m 5 hdfs://jx-1-107:8020//backup/topic-har hdfs://jx-1-29:8020/backup/topic-har
```

# HDFS文件系统管理
```
#查看HDFS目录占用空间
hadoop fs -du -h /juxin/data-widetable/chat-ltp
hadoop fs -du -h /juxin/data-warehouse/
hadoop fs -du -h /backup/topic-har/
hadoop fs -du -h /hbase
#显示为目录个数，文件个数，文件总计大小，输入路径
hadoop fs -count < hdfs path >
#查看本地磁盘占用
df -lh
du -h /data12/bigwork/

#hdfs数据存储平衡
hdfs balancer -threshold 10

#关于块检查结果健康,NAMENODEUI提示块丢失的疑问:https://issues.apache.org/jira/browse/HDFS-8126

#保存NAMENODE元数据:/var/log/hadoop-hdfs
hadoop dfsadmin -metasave lyh

#归档参考:http://blog.csdn.net/knowledgeaaa/article/details/11772809
#归档还原:hadoop fs -cp /20130101.har/* /user/lyh/

hadoop fs -mkdir /backup/topic-har
hadoop fs -rm -R -f /backup/topic-har/topic-201705.har

#备份原始数据
hadoop archive -archiveName topic-201705.har -p /juxin/data-ods/flume-topic/ 2017-05-* /backup/topic-har/
hadoop archive -archiveName topic-201706.har -p /juxin/data-ods/flume-topic/ 2017-06-* /backup/topic-har/
hadoop archive -archiveName topic-201707.har -p /juxin/data-ods/flume-topic/ 2017-07-* /backup/topic-har/
hadoop archive -archiveName topic-201708.har -p /juxin/data-ods/flume-topic/ 2017-08-* /backup/topic-har/
hadoop archive -archiveName topic-201709.har -p /juxin/data-ods/flume-topic/ 2017-09-* /backup/topic-har/
hadoop archive -archiveName topic-201710.har -p /juxin/data-ods/flume-topic/ 2017-10-* /backup/topic-har/

#查看归档:
hadoop fs -ls har:///backup/topic-har/topic-201705.har
hadoop fs -ls har:///backup/topic-har/topic-data-warehouse-201709.har

#删除原始数据
hadoop fs -rm -R -f -skipTrash /juxin/data-ods/flume-topic/2017-05-*
hadoop fs -rm -R -f -skipTrash /juxin/data-ods/flume-topic/2017-06-*
hadoop fs -rm -R -f -skipTrash /juxin/data-ods/flume-topic/2017-07-*
hadoop fs -rm -R -f -skipTrash /juxin/data-ods/flume-topic/2017-08-*
hadoop fs -rm -R -f -skipTrash /juxin/data-ods/flume-topic/2017-09-*

#备份数据仓库
hadoop archive -archiveName topic-data-warehouse-201705.har -p /juxin/data-warehouse/ fact-*/2017-05-* /backup/topic-har/
hadoop archive -archiveName topic-data-warehouse-201706.har -p /juxin/data-warehouse/ fact-*/2017-06-* /backup/topic-har/
hadoop archive -archiveName topic-data-warehouse-201707.har -p /juxin/data-warehouse/ fact-*/2017-07-* /backup/topic-har/
hadoop archive -archiveName topic-data-warehouse-201708.har -p /juxin/data-warehouse/ fact-*/2017-08-* /backup/topic-har/
hadoop archive -archiveName topic-data-warehouse-201709.har -p /juxin/data-warehouse/ fact-*/2017-09-* /backup/topic-har/
hadoop archive -archiveName topic-data-warehouse-201710.har -p /juxin/data-warehouse/ fact-*/2017-10-* /backup/topic-har/

#重新设置文件备份副本数
hadoop dfs -setrep -w 3 -R /hbase/data/jxdata/userinfo/a43bcb42f39f30407f548af4b2480e27/.tmp/320457ef9679441e808e913e0605e0d6
hadoop dfs -setrep -w 3 -R /hbase/data/jxdata/userinfo/af59d472ce61e404a56c7813d5588697/.tmp/304d5c5c74ac46f08854793fe1d65939
hadoop dfs -setrep -w 3 -R /hbase/data/jxdata/userinfo/e8f2fd6d7ca1d517057c7be40ee028b0/.tmp/2ab7e3fb84d64e5583ac187556d90b6d

#删除坏块
hdfs fsck -delete

#显示损坏的文件列表
hdfs fsck -list-corruptfileblocks

hdfs fsck -racks

#允许快照,http://www.cnblogs.com/JackQ/p/4586663.html
hdfs dfsadmin -allowSnapshot /juxin/data-warehouse
hdfs dfsadmin -allowSnapshot /hbase
hdfs dfsadmin -allowSnapshot /user/hive
hdfs dfsadmin -allowSnapshot /juxin/data-ods/flume-topic
hdfs dfsadmin -allowSnapshot /juxin/data-widetable
hdfs dfsadmin -allowSnapshot /juxin/data-ml-model

#创建快照
hdfs dfs -createSnapshot /juxin/data-warehouse 20170728
hdfs dfs -createSnapshot /hbase 20170728
hdfs dfs -createSnapshot /user/hive 20170728
hdfs dfs -createSnapshot /juxin/data-ods/flume-topic 20170728
hdfs dfs -createSnapshot /juxin/data-widetable 20170728
hdfs dfs -createSnapshot /juxin/data-ml-model 20170728

#删除快照
hdfs dfs -deleteSnapshot /juxin/data-warehouse 20170728
hdfs dfs -deleteSnapshot /hbase 20170728
hdfs dfs -deleteSnapshot /user/hive 20170728
hdfs dfs -deleteSnapshot /juxin/data-ods/flume-topic 20170728
hdfs dfs -deleteSnapshot /juxin/data-widetable 20170728
hdfs dfs -deleteSnapshot /juxin/data-ml-model 20170728

#修复副本不足的文件块
hadoop fs -mkdir /user/lyh/tmpdata

hadoop fs -cp /hbase/data/jxdata/userinfo/c41df6ec51c06458c939077e23a40153/.tmp/7bfdb132dbfe45cdb840d822b03676ee /user/lyh/tmpdata/
hadoop fs -cp /hbase/data/jxdata/userinfo/4952a55b3c1795af7c42924ce3f0b94b/.tmp/ad574543e4ab4392945e8cb960294403 /user/lyh/tmpdata/
hadoop fs -cp /hbase/data/jxdata/userinfo/414f80e9bd0a60824341616849e4b4f0/.tmp/c8c587b490f84eae8499263e6fe62ff5 /user/lyh/tmpdata/

hadoop fs -rm -R -f -skipTrash /hbase/data/jxdata/userinfo/c41df6ec51c06458c939077e23a40153/.tmp/7bfdb132dbfe45cdb840d822b03676ee
hadoop fs -rm -R -f -skipTrash /hbase/data/jxdata/userinfo/4952a55b3c1795af7c42924ce3f0b94b/.tmp/ad574543e4ab4392945e8cb960294403
hadoop fs -rm -R -f -skipTrash /hbase/data/jxdata/userinfo/414f80e9bd0a60824341616849e4b4f0/.tmp/c8c587b490f84eae8499263e6fe62ff5

hadoop fs -cp /user/lyh/tmpdata/7bfdb132dbfe45cdb840d822b03676ee /hbase/data/jxdata/userinfo/c41df6ec51c06458c939077e23a40153/.tmp/7bfdb132dbfe45cdb840d822b03676ee
hadoop fs -cp /user/lyh/tmpdata/ad574543e4ab4392945e8cb960294403 /hbase/data/jxdata/userinfo/4952a55b3c1795af7c42924ce3f0b94b/.tmp/ad574543e4ab4392945e8cb960294403
hadoop fs -cp /user/lyh/tmpdata/c8c587b490f84eae8499263e6fe62ff5 /hbase/data/jxdata/userinfo/414f80e9bd0a60824341616849e4b4f0/.tmp/c8c587b490f84eae8499263e6fe62ff5

sudo -u hdfs hadoop fs -chown hbase:hbase /hbase/data/jxdata/userinfo/c41df6ec51c06458c939077e23a40153/.tmp/7bfdb132dbfe45cdb840d822b03676ee
sudo -u hdfs hadoop fs -chown hbase:hbase /hbase/data/jxdata/userinfo/4952a55b3c1795af7c42924ce3f0b94b/.tmp/ad574543e4ab4392945e8cb960294403
sudo -u hdfs hadoop fs -chown hbase:hbase /hbase/data/jxdata/userinfo/414f80e9bd0a60824341616849e4b4f0/.tmp/c8c587b490f84eae8499263e6fe62ff5

hadoop fs -rm -R -f /user/lyh/tmpdata/*

```

# hadoop distcp命令详解
```
usage: distcp OPTIONS [source_path...] <target_path>
              OPTIONS
 -append                       Reuse existing data in target files and
                               append new data to them if possible
 -async                        Should distcp execution be blocking
 -atomic                       Commit all changes or none
 -bandwidth <arg>              Specify bandwidth per map in MB
 -delete                       Delete from target, files missing in source
 -diff <arg>                   Use snapshot diff report to identify the
                               difference between source and target
 -f <arg>                      List of files that need to be copied
 -filelimit <arg>              (Deprecated!) Limit number of files copied
                               to <= n
 -filters <arg>                The path to a file containing a list of
                               strings for paths to be excluded from the
                               copy.
 -i                            Ignore failures during copy
 -log <arg>                    Folder on DFS where distcp execution logs
                               are saved
 -m <arg>                      Max number of concurrent maps to use for
                               copy
 -mapredSslConf <arg>          Configuration for ssl config file, to use
                               with hftps://. Must be in the classpath.
 -numListstatusThreads <arg>   Number of threads to use for building file
                               listing (max 40).
 -overwrite                    Choose to overwrite target files
                               unconditionally, even if they exist.
 -p <arg>                      preserve status (rbugpcaxt)(replication,
                               block-size, user, group, permission,
                               checksum-type, ACL, XATTR, timestamps). If
                               -p is specified with no <arg>, then
                               preserves replication, block size, user,
                               group, permission, checksum type and
                               timestamps. raw.* xattrs are preserved when
                               both the source and destination paths are
                               in the /.reserved/raw hierarchy (HDFS
                               only). raw.* xattrpreservation is
                               independent of the -p flag. Refer to the
                               DistCp documentation for more details.
 -rdiff <arg>                  Use target snapshot diff report to identify
                               changes made on target
 -sizelimit <arg>              (Deprecated!) Limit number of files copied
                               to <= n bytes
 -skipcrccheck                 Whether to skip CRC checks between source
                               and target paths.
 -strategy <arg>               Copy strategy to use. Default is dividing
                               work based on file sizes
 -tmp <arg>                    Intermediate work path to be used for
                               atomic commit
 -update                       Update target, copying only missingfiles or
                               directories
```
