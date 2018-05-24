package 工作.兰州大数据.二期修改.套牌车分析.原版;

import java.io.Serializable;

public class Log implements Serializable{
	private String project;
	private String table_name;
	private String data_time;
	private String run_time;
	private String run_type;
	public String getProject(){
		return project;
	}
	public void setProject(String project){
		this.project=project;
	}
	
	public String getTable_name(){
		return table_name;
	}
	public void setTable_name(String table_name){
		this.table_name=table_name;
	}
	public String getData_time(){
		return data_time;
	}
	public void setData_time(String data_time){
		this.data_time=data_time;
	}
	
	public String getRun_time(){
		return run_time;
	}
	public void setRun_time(String run_time){
		this.run_time=run_time;
	}
	
	public String getRun_type(){
		return run_type;
	}
	public void setRun_type(String run_type){
		this.run_type=run_type;
	}
}
