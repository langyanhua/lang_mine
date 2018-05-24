package 业余测试.parquet测试写入本地和HDFS;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.parquet.example.data.Group;
import org.apache.parquet.example.data.simple.SimpleGroupFactory;
import org.apache.parquet.hadoop.ParquetWriter;
import org.apache.parquet.hadoop.example.GroupWriteSupport;
import org.apache.parquet.hadoop.metadata.CompressionCodecName;
import org.apache.parquet.schema.OriginalType;
import org.apache.parquet.schema.PrimitiveType;
import org.apache.parquet.schema.Types;

import java.io.IOException;


public class Parquet2HDFS {
    public static void main(String[] args) throws IOException {
        Configuration conf = new Configuration();
        conf.set("dfs.client.block.write.replace-datanode-on-failure.policy", "NEVER");
        conf.set("dfs.client.block.write.replace-datanode-on-failure.enable", "true");
        conf.set("fs.hdfs.impl", org.apache.hadoop.hdfs.DistributedFileSystem.class.getName());
        conf.set("fs.defaultFS", "");
        conf.set("dfs.nameservices", "");
        conf.set("dfs.ha.namenodes.nameservice1", "");
        conf.set("dfs.namenode.rpc-address.nameservice1.slave23", "");
        conf.set("dfs.namenode.rpc-address.nameservice1.slave2", "");
        conf.set("dfs.client.failover.proxy.provider.nameservice1", "org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider");
        org.apache.parquet.schema.MessageType scheam = new Parquet2HDFS().createParquet("feature_hive");


        GroupWriteSupport.setSchema(scheam, conf);
        SimpleGroupFactory f = new SimpleGroupFactory(scheam);
        ParquetWriter<Group> writer = new ParquetWriter<>(new Path(""), new GroupWriteSupport(),
                CompressionCodecName.SNAPPY, 1024, 1024, 512, true, false,
                org.apache.parquet.column.ParquetProperties.WriterVersion.PARQUET_2_0, conf);


    }

    private org.apache.parquet.schema.MessageType createParquet(String tableName) {
        if (tableName.equals("feature_hive")) {
            org.apache.parquet.schema.MessageType schema = Types.buildMessage().required(PrimitiveType.PrimitiveTypeName.BINARY)
                    .as(OriginalType.UTF8).named("rowkey").required(PrimitiveType.PrimitiveTypeName.BINARY).as(OriginalType.UTF8)
                    .named("indate").required(PrimitiveType.PrimitiveTypeName.BINARY).as(OriginalType.UTF8).named("feature")
                    .named("source_feature_hive");
            return schema;
        } else {
            org.apache.parquet.schema.MessageType schema = Types.buildMessage().required(PrimitiveType.PrimitiveTypeName.BINARY)
                    .as(OriginalType.UTF8).named("rowkey").required(PrimitiveType.PrimitiveTypeName.BINARY).as(OriginalType.UTF8)
                    .named("indate").required(PrimitiveType.PrimitiveTypeName.BINARY).as(OriginalType.UTF8).named("feature")
                    .named("source_detection_vehicle_all");
            return schema;
        }
    }
}