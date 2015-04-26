/**
 * 
 */
package minhang.action;

import minhang.dao.UserDao;
import minhang.entity.User;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author cyc
 * 
 */
public class LogoutAction extends ActionSupport {

	public String execute() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		ctx.getSession().remove("username");

		return SUCCESS;
	}

}
