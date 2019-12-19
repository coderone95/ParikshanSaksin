package com.codesvila.interceptor;

import org.apache.struts2.dispatcher.SessionMap;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class AuthorizationInterceptor implements Interceptor {

	private static final long serialVersionUID = 1841289944579731267L;

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void init() {
		// TODO Auto-generated method stub

	}

	@Override
	public String intercept(ActionInvocation inv) throws Exception {
		ActionContext context = inv.getInvocationContext();

		// for login and register actions ignore checking
		if (context.getName().equalsIgnoreCase("login") || context.getName().equalsIgnoreCase("registerUser")) {
			return inv.invoke();
		}
		SessionMap<String, Object> map = (SessionMap<String, Object>) inv.getInvocationContext().getSession();
		if (map == null) {
			return "login";
		}
		Object user = map.get("username");
		if (user == null || user.equals("") || map.isEmpty() || map == null) {
			return "login";
		}

		return inv.invoke();
	}

}