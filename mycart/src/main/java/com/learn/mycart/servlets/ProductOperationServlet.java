package com.learn.mycart.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.learn.mycart.dao.CategoryDao;
import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import com.learn.mycart.helper.FactoryProvider;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			// servlet 2:
			// add category
			// add product
			String op = request.getParameter("operation");
			if (op.trim().equals("addcategory")) {
				// add category
				// fetching category data
				String title = request.getParameter("catTitle");
				String description = request.getParameter("catDescription");
				
				Category category = new Category();
				category.setCategoryTitle(title);
				category.setCategoryDescription(description);
				
				//category database save:
				CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
				int catId=categoryDao.saveCategory(category);
				/* out.println("category saved"); */
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Category added successfully: " +catId);;
				response.sendRedirect("admin.jsp");
				return;
				
				
			} else if (op.trim().equals("addproduct")) {
				// add product
				String pName=request.getParameter("pName");
				String pDesc=request.getParameter("pDesc");
				int pPrice=Integer.parseInt(request.getParameter("pPrice"));
				int pDiscount=Integer.parseInt(request.getParameter("pDiscount"));
				int pQuantity=Integer.parseInt(request.getParameter("pQuantity"));
				int catId=Integer.parseInt(request.getParameter("catId"));
				Part part = request.getPart("pPic");
				
				Product p = new Product();
				p.setpName(pName);
				p.setpDesc(pDesc);
				p.setpPrice(pPrice);
				p.setpDiscount(pDiscount);
				p.setpQuantity(pQuantity);
				p.setpPhoto(part.getSubmittedFileName());
				
				//get category by id
				CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
				Category category = cdao.getCategoryById(catId);
				p.setCategory(category);
				
				//product save..
				ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
				pdao.saveProduct(p);
				/*
				 * request.setCharacterEncoding("UTF-8");
				 * response.setCharacterEncoding("UTF-8");
				 */
				
				//picture upload
				//find out the path to upload photo
				String path = request.getRealPath("img")+ File.separator+"products"+File.separator+part.getSubmittedFileName();
				System.out.println(path);
				
				//uploading code..
				try {
					
				
				FileOutputStream fos = new FileOutputStream(path);
				InputStream is = part.getInputStream();
				
				//reading data
				byte[] data = new byte[is.available()];
				is.read(data);
				
				//writing the data
				fos.write(data);
				fos.close();
				
} catch (Exception e) {
					e.printStackTrace();
				}
				
				/* out.println("product save success.."); */
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Prodcut is added successfully: ");;
				response.sendRedirect("admin.jsp");
				return;

			}

		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

}
