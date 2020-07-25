package com.codesvila.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codesvila.bean.LibraryBean;
import com.codesvila.service.LibraryService;
import com.codesvila.utils.CommonUtility;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.ValidationAware;

public class AddBookAction extends ActionSupport implements ModelDriven<LibraryBean>, ValidationAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Autowired
	private LibraryBean libraryBean;
	@Autowired
	private LibraryService libraryService;
	private List<LibraryBean> books;

	@Override
	public LibraryBean getModel() {
		// TODO Auto-generated method stub
		return libraryBean;
	}

	public List<LibraryBean> getBooks() {
		return books;
	}

	public void setBooks(List<LibraryBean> books) {
		this.books = books;
	}

	public String execute() {
		libraryService.saveBook(CommonUtility.createLibraryModel(libraryBean));
		books = CommonUtility.createLibraryBeanList(libraryService.getBookList());

		addActionMessage("Book Added Successfully!!");
		return "success";
	}

	public void validate() {
		if (libraryBean.getName().trim().equals("") || libraryBean.getName() == null) {
			clearActionErrors();
			addActionError("Please Enter Book Name!!");
		}

		else if (libraryBean.getAuthor().trim().equals("") || libraryBean.getAuthor() == null) {
			clearActionErrors();
			addActionError("Please Enter Author Name!!");
		} else if (libraryBean.getPrice() == 0) {
			clearActionErrors();
			addActionError("Please Enter Price!!");
		}

		else if (libraryBean.getQuantity() == 0) {
			clearActionErrors();
			addActionError("Please Enter Quantity!!");
		}

		else if (libraryBean.getPrice() < 0 || libraryBean.getQuantity() < 0) {
			clearActionErrors();
			addActionError("Please Enter Valid Price / Quantity!!");
		}

	}

}
