package 工作.兰州大数据.二期修改.过滤连续重复的记录.原版;

public class QuerySort implements Comparable<QuerySort>{
	
	private String id;
	private long datetime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public long getDatetime() {
		return datetime;
	}
	public void setDatetime(long datetime) {
		this.datetime = datetime;
	}
	@Override
	public int compareTo(QuerySort o) {
		// TODO Auto-generated method stub
		if(this.datetime>o.datetime){
			return 1;
		}
		if(this.datetime<o.datetime){
			return  -1;
		}
		else return 0;
	}
	
}
