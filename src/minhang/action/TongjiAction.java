/**
 * 
 */
package minhang.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;
import org.apache.struts2.ServletActionContext;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.servlet.ServletUtilities;

import minhang.algo.CommonService;
import minhang.dao.DimtypeDao;
import minhang.dao.OnedimstatisticDao;
import minhang.entity.Onedimstatistic;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author cyc
 * 
 */
public class TongjiAction extends ActionSupport {
	private CommonService commonService = new CommonService();
	private DimtypeDao dimtypeDao = DimtypeDao.getInstance();
	private OnedimstatisticDao onedimstatisticDao = OnedimstatisticDao
			.getInstance();
	private String msg = null;
	private String frameContent;
	
	private List<String> dimStrs = null;
	
	// OneDimTime页面输入参数
	private String dimSelect;
	private int timeSelect;
	private String barGraphURL = null, pieGraphURL = null, lineGraphURL = null;
	private String startYear = null, endYear = null, startNum = null,
			endNum = null;
	private String sy_year, ey_year, sj_jijie, ej_jijie, ss_season, es_season,
			sm_month, em_month, sx_xun, ex_xun, sw_week, ew_week;

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
		frameContent = "onedimTime";
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		setDimStrs(dimtypeDao.getAllDimtypesStr());

		System.out.println("input:dimSelect:" + dimSelect + "  timeSel:"
				+ timeSelect);
		if (timeSelect > 0 && sy_year != null && ey_year != null) {
			startYear = sy_year;
			endYear = ey_year;
			switch (timeSelect) {
			case 1:
				break;
			case 2:
				startNum = sj_jijie;
				endNum = ej_jijie;
				break;
			case 3:
				startNum = ss_season;
				endNum = es_season;
				break;
			case 4:
				startNum = sm_month;
				endNum = em_month;
				break;
			case 5:
				startNum = sx_xun;
				endNum = ex_xun;
				break;
			case 6:
				startNum = sw_week;
				endNum = ew_week;
				break;
			}

			System.out
					.println("input:startYear:" + startYear + "  endYear:"
							+ endYear + "  startNum:" + startNum + "  endNum:"
							+ endNum);
			// 数据处理
			List<Onedimstatistic> result = commonService.getOneDimResult(timeSelect,
					dimSelect, null, startYear, endYear, startNum, endNum);
			
			if(result==null|| result.size() == 0){
				msg = "抱歉， 未查询到结果。";
				return frameContent;
			}
			// 生成直方图
			JFreeChart chart = commonService.getOneDimBarChart(dimSelect,
					result);
			String bfilename = ServletUtilities.saveChartAsPNG(chart, 800, 500,
					null, session);
			barGraphURL = request.getContextPath() + "/DisplayChart?filename="
					+ bfilename;
			// 生成饼状图
			JFreeChart chart2 = commonService.getOneDimPieChart(dimSelect, result);
			String pfilename = ServletUtilities.saveChartAsPNG(chart2, 500,
					500, null, session);
			pieGraphURL = request.getContextPath() + "/DisplayChart?filename="
					+ pfilename;
			// 生成折线图
			JFreeChart chart3 = commonService.getOneDimLineChart(dimSelect, result);
			String lfilename = ServletUtilities.saveChartAsPNG(chart3, 800,
					500, null, session);
			lineGraphURL = request.getContextPath() + "/DisplayChart?filename="
					+ lfilename;
			
		}

		return frameContent;
	}

	public String showOnedimDiqu() throws Exception {
		setDimStrs(dimtypeDao.getAllDimtypesStr());

		frameContent = "onedimDiqu";
		return frameContent;
	}

	public List<String> getDimStrs() {
		return dimStrs;
	}

	public void setDimStrs(List<String> dimStrs) {
		this.dimStrs = dimStrs;
	}

	public String getFrameContent() {
		return frameContent;
	}

	public void setFrameContent(String frameContent) {
		this.frameContent = frameContent;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getDimSelect() {
		return dimSelect;
	}

	public void setDimSelect(String dimSelect) {
		this.dimSelect = dimSelect;
	}

	public int getTimeSelect() {
		return timeSelect;
	}

	public void setTimeSelect(int timeSelect) {
		this.timeSelect = timeSelect;
	}

	public String getBarGraphURL() {
		return barGraphURL;
	}

	public void setBarGraphURL(String barGraphURL) {
		this.barGraphURL = barGraphURL;
	}

	public String getPieGraphURL() {
		return pieGraphURL;
	}

	public void setPieGraphURL(String pieGraphURL) {
		this.pieGraphURL = pieGraphURL;
	}

	public String getLineGraphURL() {
		return lineGraphURL;
	}

	public void setLineGraphURL(String lineGraphURL) {
		this.lineGraphURL = lineGraphURL;
	}

	public String getStartYear() {
		return startYear;
	}

	public void setStartYear(String startYear) {
		this.startYear = startYear;
	}

	public String getEndYear() {
		return endYear;
	}

	public void setEndYear(String endYear) {
		this.endYear = endYear;
	}

	public String getStartNum() {
		return startNum;
	}

	public void setStartNum(String startNum) {
		this.startNum = startNum;
	}

	public String getEndNum() {
		return endNum;
	}

	public void setEndNum(String endNum) {
		this.endNum = endNum;
	}

	public String getSy_year() {
		return sy_year;
	}

	public void setSy_year(String sy_year) {
		this.sy_year = sy_year;
	}

	public String getEy_year() {
		return ey_year;
	}

	public void setEy_year(String ey_year) {
		this.ey_year = ey_year;
	}

	public String getSj_jijie() {
		return sj_jijie;
	}

	public void setSj_jijie(String sj_jijie) {
		this.sj_jijie = sj_jijie;
	}

	public String getEj_jijie() {
		return ej_jijie;
	}

	public void setEj_jijie(String ej_jijie) {
		this.ej_jijie = ej_jijie;
	}

	public String getSs_season() {
		return ss_season;
	}

	public void setSs_season(String ss_season) {
		this.ss_season = ss_season;
	}

	public String getEs_season() {
		return es_season;
	}

	public void setEs_season(String es_season) {
		this.es_season = es_season;
	}

	public String getSm_month() {
		return sm_month;
	}

	public void setSm_month(String sm_month) {
		this.sm_month = sm_month;
	}

	public String getEm_month() {
		return em_month;
	}

	public void setEm_month(String em_month) {
		this.em_month = em_month;
	}

	public String getSx_xun() {
		return sx_xun;
	}

	public void setSx_xun(String sx_xun) {
		this.sx_xun = sx_xun;
	}

	public String getEx_xun() {
		return ex_xun;
	}

	public void setEx_xun(String ex_xun) {
		this.ex_xun = ex_xun;
	}

	public String getSw_week() {
		return sw_week;
	}

	public void setSw_week(String sw_week) {
		this.sw_week = sw_week;
	}

	public String getEw_week() {
		return ew_week;
	}

	public void setEw_week(String ew_week) {
		this.ew_week = ew_week;
	}

}
