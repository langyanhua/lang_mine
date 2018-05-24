package 工作.兰州大数据.二期修改.套牌车分析.原版;

import java.io.Serializable;

public class TaopaicheResult implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String plate_no;
	private Double plate_color;
	private String plate_color_name;
	private String rowkey1;
	private String indate1;
	private String section_name1;
	private Double section_id1;
	private Double section_mapx1;
	private Double section_mapy1;
	private String indate2;
	private String section_name2;
	private Double section_id2;
	private Double section_mapx2;
	private Double section_mapy2;
	private String day;


	public String getPlate_no() {
		return plate_no;
	}

	public void setPlate_no(String plate_no) {
		this.plate_no = plate_no;
	}

	public Double getPlate_color() {
		return plate_color;
	}

	public void setPlate_color(Double plate_color) {
		this.plate_color = plate_color;
	}

	public String getPlate_color_name() {
		return plate_color_name;
	}

	public void setPlate_color_name(String plate_color_name) {
		this.plate_color_name = plate_color_name;
	}
	
	public String getRowkey1() {
		return rowkey1;
	}

	public void setRowkey1(String rowkey1) {
		this.rowkey1 = rowkey1;
	}
	
	public String getIndate1() {
		return indate1;
	}

	public void setIndate1(String indate1) {
		this.indate1 = indate1;
	}

	public String getSection_name1() {
		return section_name1;
	}

	public void setSection_name1(String section_name1) {
		this.section_name1 = section_name1;
	}

	public Double getSection_id1() {
		return section_id1;
	}
	public void setSection_id1(Double section_id1) {
		this.section_id1 = section_id1;
	}
	
	public Double getSection_mapx1() {
		return section_mapx1;
	}
	public void setSection_mapx1(Double section_mapx1) {
		this.section_mapx1 = section_mapx1;
	}
	public Double getSection_mapy1() {
		return section_mapy1;
	}
	public void setSection_mapy1(Double section_mapy1) {
		this.section_mapy1 = section_mapy1;
	}
	
	public String getIndate2() {
		return indate2;
	}

	public void setIndate2(String indate2) {
		this.indate2 = indate2;
	}

	public String getSection_name2() {
		return section_name2;
	}

	public void setSection_name2(String section_name2) {
		this.section_name2 = section_name2;
	}

	public Double getSection_id2() {
		return section_id2;
	}

	public void setSection_id2(Double section_id2) {
		this.section_id2 = section_id2;
	}
	
	public Double getSection_mapx2() {
		return section_mapx2;
	}
	public void setSection_mapx2(Double section_mapx2) {
		this.section_mapx2 = section_mapx2;
	}
	public Double getSection_mapy2() {
		return section_mapy2;
	}
	public void setSection_mapy2(Double section_mapy2) {
		this.section_mapy2 = section_mapy2;
	}
	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

}
