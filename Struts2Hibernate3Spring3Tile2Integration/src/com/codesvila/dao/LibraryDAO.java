package com.codesvila.dao;

import java.util.List;

import com.codesvila.bean.LibraryBean;
import com.codesvila.model.Library;

public interface LibraryDAO {
	void saveBook(Library library);

	List<Library> getBookList();

	void deleteBook(int id);

	void updateBook(int id, LibraryBean libraryBean);
}
