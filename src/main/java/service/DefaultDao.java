package service;

import java.util.HashMap;
import java.util.Map;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;

public class DefaultDao {

	private JdbcTemplate jt;
	
	public DefaultDao(DataSource dataSource) {
		this.jt = new JdbcTemplate(dataSource);
	}
	
	public Map<String, Integer> paging(int totalpage, Map<String, Object> requestValues) {
		int page = requestValues.get("page") == null ? 1 : Integer.valueOf((String)requestValues.get("page"));
		int min = 0;
		int max = 5;
		if (page > 3) {
			min = page - 3;
			max = page + 2;
		}
		if (max > (totalpage / 10) + 1) {
			max = (totalpage / 10) + 1;
		}
		if (totalpage % 10 == 0) {
			max -= 1;
		}
		if (totalpage == 0) {
			max = 1;
		}
		if (max < 5) {
			min = 0;
		}
		Map<String, Integer> result = new HashMap<String, Integer>();
	
		result.put("max", max);
		result.put("min", min);
		result.put("total", totalpage);
		result.put("page", page);
		return result;
	}
	
	   public Map<String, Integer> paging(int totalpage, int page) {
		      
		      int min = 0;
		      int max = 5;
		      if (page > 3) {
		         min = page - 3;
		         max = page + 2;
		      }
		      if (max > (totalpage / 10) + 1) {
		         max = (totalpage / 10) + 1;
		      }
		      if (totalpage % 10 == 0) {
		         max -= 1;
		      }
		      if (totalpage == 0) {
		         max = 1;
		      }
		      if (max < 5) {
		         min = 0;
		      }
		      Map<String, Integer> result = new HashMap<String, Integer>();
		   
		      result.put("max", max);
		      result.put("min", min);
		      result.put("total", totalpage);
		      result.put("page", page);
		      return result;
		   }
}
