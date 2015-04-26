/**
 * 
 */
package minhang.action;

import java.util.List;

import minhang.dao.UserDao;
import minhang.entity.User;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author cyc
 * 
 */
public class AdminAction extends ActionSupport {
	private String adname;
	private String password;
	private String errinfo = "";
	private UserDao userDao = new UserDao();
	private List<User> allusers;

	public String login() throws Exception {
		ActionContext ctx = ActionContext.getContext();

		if (ctx.getSession().get("adname") != null)
			return userlist();

		if (adname == null || "".endsWith(adname) || password == null
				|| "".endsWith(password)) {
			errinfo = "";
			return "login";
		}

		User user = userDao.login(adname, password);
		if (user == null) {
			errinfo = "用户名或密码不正确";
			return "login";
		}

		if (user.getState() == 1) {
			errinfo = "账号被屏蔽";
			return "login";
		}
		if (user.getPermission() != 0) {
			errinfo = "无管理员权限";
			return "login";
		}
		ctx.getSession().put("adname", adname);
		return userlist();
	}

	public String userlist() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		if (ctx.getSession().get("adname") == null)
			return "login";
			
		allusers = userDao.getAllUsers();
		return "userlist";
	}

	public String logout() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		ctx.getSession().remove("adid");
		ctx.getSession().remove("adname");
		ctx.getSession().remove("adloginid");
		ctx.getSession().remove("flag");

		return "login";
	}

	public String getAdname() {
		return adname;
	}

	public void setAdname(String adname) {
		this.adname = adname;
	}

	public List<User> getAllusers() {
		return allusers;
	}

	public void setAllusers(List<User> allusers) {
		this.allusers = allusers;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getErrinfo() {
		return errinfo;
	}

	public void setErrinfo(String errinfo) {
		this.errinfo = errinfo;
	}

}
