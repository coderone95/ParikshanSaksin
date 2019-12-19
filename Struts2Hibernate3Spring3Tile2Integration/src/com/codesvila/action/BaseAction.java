package com.codesvila.action;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.JSONUtil;
import org.apache.struts2.util.ServletContextAware;
import org.json.JSONObject;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport implements SessionAware, ServletRequestAware, ServletResponseAware, ServletContextAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected Map<String,Object> sessionMap ;
	
	  protected HttpServletRequest request;
	  protected HttpServletResponse response;
	  protected HttpSession session;
	  protected Map<String,Object> contextSession = ActionContext.getContext().getSession();
	  

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}

	@Override
	public void setSession(Map<String, Object> sessionMap) {
		// TODO Auto-generated method stub
		this.sessionMap = sessionMap;
	}
	
	@Override
	public void setServletContext(ServletContext arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		
	}

	 public Map<String, Object> getContextSession() {
		return contextSession;
	}

	public void setContextSession(Map<String, Object> contextSession) {
		this.contextSession = contextSession;
	}

	protected String writeJsonResponse(Object result) {
	      // HttpServletResponse response = (HttpServletResponse)
	      // ActionContext.getContext().get(StrutsStatics.HTTP_RESPONSE);
	      response.setHeader("Cache-Control", "no-cache");
	      response.setHeader("Pragma", "no-cache");
	      response.setDateHeader("Expires", 0);
	      this.response.setContentType("application/json");
	      this.response.setCharacterEncoding("UTF-8");
	      try {
	        String responseStr = "";
	        if (result instanceof JSONObject) {
	          responseStr = String.valueOf(result);
	        } else {
	          responseStr = JSONUtil.serialize(result);
	        }
	        this.response.getOutputStream().write(responseStr.getBytes("UTF-8"));
	        
	      } catch (Exception e) {
	        if (LOG.isDebugEnabled()) {
	          LOG.error("BaseAction.writeResponse - Error - ", e);
	        } else {
	          LOG.error("BaseAction.writeResponse - Error - " + e);
	        }
	        return ERROR;
	      }
	      return null;
	    }
	
}

