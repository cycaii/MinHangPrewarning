/**
 * 
 */
package minhang.action;

import java.util.List;

import minhang.algo.CommonService;
import minhang.dao.DimtypeDao;
import minhang.dao.OnedimstatisticDao;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author cyc
 * 
 */
public class TongjiAction extends ActionSupport {
	private CommonService commonService= new CommonService();
	private DimtypeDao dimtypeDao = DimtypeDao.getInstance();
	private OnedimstatisticDao onedimstatisticDao = OnedimstatisticDao.getInstance();
	private List<String> dimStrs = null;

	private String frameContent;

	public String show() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		String username = (String) ctx.getSession().get("username");
		if (username == null || username.equals("")) {
		 return LOGIN;
		 }

		frameContent = "onedimTime";
		return SUCCESS;
	}

	public String showOnedimTime() throws Exception {
		dimStrs = dimtypeDao.getAllDimtypesStr();
		
		
		frameContent = "onedimTime";
		return frameContent;
	}
}
