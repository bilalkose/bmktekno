<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.User"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<%
	User user = (User) session.getAttribute("current-user");
if (user == null) {

	session.setAttribute("message", "You are not logged in! Login first");
	response.sendRedirect("login.jsp");
	return;
} else {

	if (user.getUserType().equals("normal")) {

		session.setAttribute("message", "Bu sayfayı görebilmek için admin yetkiniz bulunmamaktadır.");
		response.sendRedirect("login.jsp");
		return;
	}

}
%>


		<%
		CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
		List<Category> list = cdao.getCategories();
		
		//saydırma işlemleri
		Map<String,Long> m = Helper.saydir(FactoryProvider.getFactory());
		%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Admin Panel</title>
<%@include file="components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>

	<div class="container admin">

		<div class="container-fluid mt-3">
			<%@include file="components/message.jsp"%>
		</div>

		<!-- first row -->
		<div class="row mt-3">
			<!-- first col -->
			<div class="col-md-4">

				<!-- first box -->
				<div class="card">
					<div class="card-body text-center">

						<div class="container">
							<img style="max-width: 100px" class="img-fluid rounded-circle"
								alt="users_icon" src="img/users.png">
						</div>

						<h1><%= m.get("userCount") %></h1>
						<h1 class="text-uppercase text-muted">Users</h1>
					</div>
				</div>

			</div>
			<!-- second col -->

			<div class="col-md-4">
				<!-- second box -->

				<div class="card">
					<div class="card-body text-center">

						<div class="container">
							<img style="max-width: 100px" class="img-fluid rounded-circle"
								alt="list_icon" src="img/list.png">
						</div>

						<h1><%=list.size() %></h1>
						<h1 class="text-uppercase text-muted">Categories</h1>
					</div>
				</div>
			</div>
			<!-- third col -->

			<div class="col-md-4">
				<!-- third box -->

				<div class="card">
					<div class="card-body text-center ">

						<div class="container">
							<img style="max-width: 100px" class="img-fluid rounded-circle"
								alt="product_icon" src="img/product.png">
						</div>

						<h1><%= m.get("productCount") %></h1>
						<h1 class="text-uppercase text-muted">Products</h1>
					</div>
				</div>
			</div>


		</div>

		<div class="row mt-3">
			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-category-modal">
					<div class="card-body text-center ">

						<div class="container">
							<img style="max-width: 100px" class="img-fluid rounded-circle"
								alt="product_icon" src="img/keys.png">
						</div>

						<p class="mt-2">Click new category</p>
						<h1 class="text-uppercase text-muted">Add Category</h1>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-product-modal">
					<div class="card-body text-center ">

						<div class="container">
							<img style="max-width: 100px" class="img-fluid rounded-circle"
								alt="product_icon" src="img/plus.png">
						</div>

						<p class="mt-2">Click new product</p>
						<h1 class="text-uppercase text-muted">Add Product</h1>
					</div>
				</div>
			</div>

		</div>




	</div>


	<!-- add category modal -->

	<!-- Modal -->
	<div class="modal fade" id="add-category-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Fill category
						details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="ProductOperationServlet" method="post">

						<input type="hidden" name="operation" value="addcategory">

						<div class="form-group">
							<input type="text" class="form-control" name="catTitle"
								placeholder="title" required />
						</div>

						<div class="form-group">
							<textarea style="height: 300px;" class="form-control"
								placeholder="desc" name="catDescription" required></textarea>
						</div>

						<div class="container text-center">
							<button class="btn btn-outline-success">Add category</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>

						</div>
					</form>
				</div>

			</div>
		</div>
	</div>

	<!-- end category modal -->

	<!-- product modal -->

	<!-- Modal -->
	<div class="modal fade" id="add-product-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="add-product-modal">Product Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form action="ProductOperationServlet" method="post" enctype="multipart/form-data">

						<input type="hidden" name="operation" value="addproduct"/>

						<div class="form-group">
							<input type="text" class="form-control" placeholder="title"
								name="pName" required />
						</div>

						<div class="form-group">
							<textarea style="height: 150px;" class="form-control"
								placeholder="enter desc" name="pDesc"></textarea>

						</div>

						<div class="form-group">
							<input type="number" class="form-control"
								placeholder="enter price" name="pPrice" required />
						</div>

						<div class="form-group">
							<input type="number" class="form-control"
								placeholder="enter discount" name="pDiscount" required />
						</div>

						<div class="form-group">
							<input type="number" class="form-control"
								placeholder="enter quantity" name="pQuantity" required />
						</div>

						<!-- product category -->



						<div class="form-group">
							<select name="catId" class="form-control" id="">

								<%
									for (Category c : list) {
								%>
								<option value="<%=c.getCategoryId()%>">
									<%=c.getCategoryTitle()%></option>

								<%
									}
								%>

							</select>
						</div>
						<!-- product file -->

						<div class="form-group">
							<label for="pPic">Select picture of product</label><br> <input
								type="file" name="pPic" required />
						</div>

						<!-- submit button -->
						<div class="containe text-center">
							<button class="btn btn-outline-success">Add product</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
						</div>

					</form>



				</div>

			</div>
		</div>
	</div>

	<!--  end product modal -->


</body>
</html>
