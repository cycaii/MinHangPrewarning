/**
 * 
 */
package minhang.action;

import java.util.Collections;
import java.util.Comparator;
import java.util.Vector;

import minhang.dao.DBWorker;
import minhang.entity.*;
import minhang.util.GlobalConstant;
import minhang.util.MyComparator;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author cyc
 * 
 */
public class PinfaAction extends ActionSupport {
	DBWorker dbworker = new DBWorker();
	private String frameContent;

	private String[] years = GlobalConstant.years;
	private Vector<String> duibijizhunNames;
	// 频发指数 参数
	private String year;
	private String accordingSel;
	private String numSel;
	private String duibijizhun;
	//结果
	private Vector<YiweiResult> yiweiResults;
	private String msg = null;
	
	public String show() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		String username = (String) ctx.getSession().get("username");
		 if (username == null || username.equals("")) {
		 return LOGIN;
		 }

		frameContent = "pinfaZhishu";
		return SUCCESS;
	}

	public String showPinfaZhishu() throws Exception {
		duibijizhunNames = dbworker.getNames();

		System.out.println("showPinfaZhishu--year:" + year + "  xuhao:"
				+ numSel + "  leixing:" + accordingSel + "   duibijizhun:"
				+ duibijizhun);
		if (year != null && numSel != null && accordingSel != null
				&& duibijizhun != null) {
			yiweiResults= dbworker.getVector(year, accordingSel,numSel, 
					duibijizhun);

			Comparator mycomp = new MyComparator();
			Collections.sort(yiweiResults, mycomp);

		 
			if (yiweiResults==null  || yiweiResults.size() == 0) {
				msg = "您好，" + duibijizhun + "("+year + "年第" + numSel + accordingSel
						+ ")没有查询结果";
			}
		}
		frameContent = "pinfaZhishu";
		return frameContent;
	}

	public String getFrameContent() {
		return frameContent;
	}

	public void setFrameContent(String frameContent) {
		this.frameContent = frameContent;
	}

	public String[] getYears() {
		return years;
	}

	public void setYears(String[] years) {
		this.years = years;
	}

	public Vector<String> getDuibijizhunNames() {
		return duibijizhunNames;
	}

	public void setDuibijizhunNames(Vector<String> duibijizhunNames) {
		this.duibijizhunNames = duibijizhunNames;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getAccordingSel() {
		return accordingSel;
	}

	public void setAccordingSel(String accordingSel) {
		this.accordingSel = accordingSel;
	}

	public String getNumSel() {
		return numSel;
	}

	public void setNumSel(String numSel) {
		this.numSel = numSel;
	}

	public String getDuibijizhun() {
		return duibijizhun;
	}

	public void setDuibijizhun(String duibijizhun) {
		this.duibijizhun = duibijizhun;
	}

	public Vector<YiweiResult> getYiweiResults() {
		return yiweiResults;
	}

	public void setYiweiResults(Vector<YiweiResult> yiweiResults) {
		this.yiweiResults = yiweiResults;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}
