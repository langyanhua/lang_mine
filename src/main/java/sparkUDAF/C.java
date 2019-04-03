package com.zhuoshi.jcbigdata.spark.history_dataclean;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SQLContext;
import org.apache.spark.sql.expressions.MutableAggregationBuffer;
import org.apache.spark.sql.expressions.UserDefinedAggregateFunction;
import org.apache.spark.sql.hive.HiveContext;
import org.apache.spark.sql.types.DataType;
import org.apache.spark.sql.types.DataTypes;
import org.apache.spark.sql.types.StructType;

import scala.collection.Seq;
import scala.collection.mutable.Buffer;

public class C {
	public static void main(String[] args) {
		SparkConf conf = new SparkConf().setAppName("jcbigdata-dataclean");
		// conf.set("spark.storage.memoryFraction", "0.4");
		// conf.set("spark.shuffle.memoryFraction", "0.4");
		// conf.set("spark.shuffle.file.buffer", "96k");
		// conf.set("spark.reducer.maxSizeInFlight", "48m");
		// conf.set("spark.shuffle.io.retryWait", "10s");
		conf.set("spark.sql.shuffle.partitions", "400");
		conf.set("spark.serializer", "org.apache.spark.serializer.KryoSerializer");
		conf.registerKryoClasses(new Class[] { DataClean.class });
		JavaSparkContext jsc = new JavaSparkContext(conf);
		SQLContext sqlContext = new HiveContext(jsc);
		// sqlContext.udf().register("asd", new UserDefinedAggregateFunction() {
		//
		// /**
		// *
		// */
		// private static final long serialVersionUID = 1L;
		//
		// @Override
		// public void update(MutableAggregationBuffer arg0, Row arg1) {
		// // TODO Auto-generated method stub
		// Map<Double, Integer> map = arg0.getAs(0);
		// double addv = arg1.getDouble(0);
		// if (map.containsKey(addv)) {
		// Integer v = map.get(arg1.getDouble(0));
		// map.put(arg1.getDouble(0), v + 1);
		// } else {
		// map.put(addv, 0);
		// }
		// arg0.update(0, map);
		// }
		//
		// @Override
		// public void merge(MutableAggregationBuffer arg0, Row arg1) {
		// Map<Double, Integer> map0 = arg0.getAs(0);
		// Map<Double, Integer> map1 = arg1.getAs(0);
		// // TODO Auto-generated method stub
		// for (Double key : map1.keySet()) {
		// if (map0.containsKey(key))
		// map0.put(key, map0.get(key) + map1.get(key));
		// else
		// map0.put(key, 0);
		// }
		// arg0.update(0, map0);
		// }
		//
		// @Override
		// public StructType inputSchema() {
		// // TODO Auto-generated method stub
		// return new StructType().add("v", DataTypes.DoubleType);
		// }
		//
		// @Override
		// public void initialize(MutableAggregationBuffer arg0) {
		// // TODO Auto-generated method stub
		// Map<Double, Integer> map = new HashMap<>();
		// arg0.update(0, map);
		// }
		//
		// @Override
		// public Object evaluate(Row arg0) {
		// // TODO Auto-generated method stub
		// Map<Double, Integer> map = arg0.getAs(0);
		// double key = 0;
		// int v = 0;
		// int tmp = 0;
		// for (Entry<Double, Integer> entry : map.entrySet()) {
		// tmp = entry.getValue();
		// if (tmp > v) {
		// v = tmp;
		// key = entry.getKey();
		// }
		// }
		// return key;
		// }
		//
		// @Override
		// public boolean deterministic() {
		// // TODO Auto-generated method stub
		// return true;
		// }
		//
		// @Override
		// public DataType dataType() {
		// // TODO Auto-generated method stub
		// return DataTypes.DoubleType;
		// }
		//
		// @Override
		// public StructType bufferSchema() {
		// // TODO Auto-generated method stub
		// return new StructType().add("s",DataTypes.createMapType(DataTypes.DoubleType,
		// DataTypes.IntegerType));
		// }
		// });

		sqlContext.udf().register("asd", new UserDefinedAggregateFunction() {

			/**
			*
			*/
			private static final long serialVersionUID = 1L;

			@Override
			public void update(MutableAggregationBuffer arg0, Row arg1) {
				// TODO Auto-generated method stub
				int a[] = arg0.getAs(0);
				int index = new Double(arg1.getDouble(0)).intValue() - 1;
				a[index] = a[index] + 1;
				arg0.update(0, a);
			}

			@Override
			public void merge(MutableAggregationBuffer arg0, Row arg1) {
				// TODO Auto-generated method stub
				Seq<Integer> s = arg0.getAs(0);
				Seq<Integer> n = arg1.getAs(0);
				for (int i = 0; i < 10; i++) {
//					s.updated(i,s.app)
				}
				arg0.update(0, s);
			}

			@Override
			public StructType inputSchema() {
				// TODO Auto-generated method stub
				return new StructType().add("v", DataTypes.DoubleType);
			}

			@Override
			public void initialize(MutableAggregationBuffer arg0) {
				// TODO Auto-generated method stub
				int a[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
				arg0.update(0, a);
			}

			@Override
			public Object evaluate(Row arg0) {
				// TODO Auto-generated method stub
				int a[] = arg0.getAs(0);
				int index = 0;
				int value = 0;
				int v = 0;
				for (int i = 0; i < 10; i++) {
					v = a[i];
					if (v > value) {
						index = i;
						value = v;
					}
				}
				return index + 1;
			}

			@Override
			public boolean deterministic() {
				// TODO Auto-generated method stub
				return true;
			}

			@Override
			public DataType dataType() {
				// TODO Auto-generated method stub
				return DataTypes.IntegerType;
			}

			@Override
			public StructType bufferSchema() {
				// TODO Auto-generated method stub
				return new StructType().add("s", DataTypes.createArrayType(DataTypes.IntegerType));
			}
		});
		sqlContext.sql(
				"select plate_no,asd(plate_color) co from detection_vehicle_all where ri='2018-11-27' group by plate_no")
				.show();
	}
}
