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
	private String userid;
	// 修改用户信息
	private User user;
	private String username;
	private String psd;
	private int gender;
	private int state;
	private String description;
	private int permission;

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

	/**
	 * 屏蔽用户
	 * 
	 * @return
	 * @throws Exception
	 */
	public String del() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		if (ctx.getSession().get("adname") == null)
			return "login";

		User user = userDao.getUserById(userid);
		user.setState(1);
		userDao.updateUser(user);
		return userlist();
	}

	/**
	 * 恢复用户
	 * 
	 * @return
	 * @throws Exception
	 */
	public String recover() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		if (ctx.getSession().get("adname") == null)
			return "login";

		User user = userDao.getUserById(userid);
		user.setState(0);
		userDao.updateUser(user);
		return userlist();
	}

	public String userinfo() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		if (ctx.getSession().get("adname") == null)
			return "login";

		user = userDao.getUserById(userid);
		if (user == null)
			return ERROR;
		return "userinfo";
	}

	public String saveUserinfo() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		if (ctx.getSession().get("adname") == null)
			return "login";

		user = userDao.getUserById(userid);
		if (user == null)
			return ERROR;

		if (username == null || password == null 
				|| username.trim().length() == 0
				|| password.trim().length() == 0
			 ) {
			errinfo = "信息不完整";
			return userinfo();
		}
		user = new User(userid, username, password, description.trim(), gender,
				permission, state);
		userDao.updateUser(user);
		errinfo = "修改成功";
		return userinfo();
	}

	public String newuser() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		if (ctx.getSession().get("adname") == null)
			return "login";
		return "newuser";
	}

	public String saveNewuser() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		if (ctx.getSession().get("adname") == null)
			return "login";

		if (username == null || password == null  
				|| username.trim().length() == 0
				|| password.trim().length() == 0
				 ) {
			errinfo = "信息不完整";
			return newuser();
		}
		user = new User(null, username, password, description.trim(), gender,
				permission, state);
		userDao.addUser(user);
		errinfo = "添加成功";

		user = userDao.login(username, password);
		if (user == null) {
			errinfo = "添加失败";
			return "newuser";
		}
		userid = user.getUserid();
		return userinfo();
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

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPsd() {
		return psd;
	}

	public void setPsd(String psd) {
		this.psd = psd;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPermission() {
		return permission;
	}

	public void setPermission(int permission) {
		this.permission = permission;
	}

}
