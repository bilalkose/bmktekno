<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>New User</title>
<%@include file="components/common_css_js.jsp"%>

</head>
<body>
	<%@include file="components/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row mt-1">

			<div class="col-md-4 offset-md-4">
				<%@include file="components/message.jsp" %>
				<h3 class="text-center my-3">BMK Teknoloji'ye Kaydol!</h3>

				<form action="RegisterServlet" method="post">
					<div class="form-group">
						<label for="name">Username</label> <input name="user_name" type="text"
							class="form-control" id="name" placeholder="enter here"
							aria-describedby="emailHelp">
					</div>

					<div class="form-group">
						<label for="email">Email</label> <input name="user_email" type="email"
							class="form-control" id="email" placeholder="enter here"
							aria-describedby="emailHelp">
					</div>

					<div class="form-group">
						<label for="password">Password</label> <input name="user_password" type="password"
							class="form-control" id="password" placeholder="enter here"
							aria-describedby="emailHelp">
					</div>

					<div class="form-group">
						<label for="phone">Phone</label> <input name="user_phone" type="number"
							class="form-control" id="phone" placeholder="enter here"
							aria-describedby="emailHelp">
					</div>

					<div class="form-group">
						<label for="adress">Address</label>
						<textarea name="user_address" class="form-control" placeholder="enter address"></textarea>
					</div>

					<div class="container text-center">
						<button class="btn btn-outline-success">Register</button>
						<button class="btn btn-outline-warning">Reset</button>
					</div>

				</form>
			</div>
		</div>
	</div>
</body>
</html>