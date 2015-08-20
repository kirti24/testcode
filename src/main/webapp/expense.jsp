<!DOCTYPE HTML>
<%@page import="com.example.ExpenseList"%>
<%@page import="com.example.DBConnect"%>
<%@page import="com.example.FlatVotes"%>
<%@page import="java.util.ArrayList"%>
<%@page session="false"%>
<%@page errorPage="error.jsp" isErrorPage="false"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Sarjan Tower | Ganpati Festival 2015</title>

<!--  <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" /> -->
<link rel="stylesheet" type="text/css"
	href="font-awesome/css/font-awesome.min.css" />

<!-- Loading Bootstrap -->
<link href="dist/css/vendor/bootstrap.min.css" rel="stylesheet">

<!-- Loading Flat UI -->
<link href="dist/css/flat-ui.css" rel="stylesheet">

<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</head>

<body id="body">

	<%
		if (request.getSession(false) == null) {
			request.getSession().invalidate();
			RequestDispatcher dispatcher = request
					.getRequestDispatcher("/index.jsp");
			if (dispatcher != null) {
				dispatcher.forward(request, response);
				return;
			}
		}

		if (!request.getSession(false).getAttribute("user").toString()
				.equalsIgnoreCase("admin")) {
			request.getSession().invalidate();
			RequestDispatcher dispatcher = request
					.getRequestDispatcher("/index.jsp");
			if (dispatcher != null) {
				dispatcher.forward(request, response);
				return;
			}
		}
	%>

	<br />
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>
		<%if(request.getAttribute("errormessage") != null){%>
			<br/><label class="alert alert-error"><%=request.getAttribute("errormessage")%></label>
		<%}%>
		<table class="table table-bordered">
			<thead>
				<tr>
					<td>Item Description</td>
					<td>Amount</td>
					<td>Paid By</td>
					<td>Category</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<form method="post" action="addexpense" id="expenseform">
					<td><input type="text" id="item" name="item" /></td>
					<td><input type="text" id="amount" name="amount" /></td>
					<td><input type="text" id="paidby" name="paidby" /></td>
					<td><input type="text" id="category" name="category" /> <a
						class="fui-plus" onclick="submit_form();" /></td>
					</form>
				</tr>

				<% ArrayList<ExpenseList> expenselist = DBConnect.getExpense();
					double total = 0;
					for(int i=0;i<expenselist.size();i++){
						total+=expenselist.get(i).getAmount();
						%>

				<tr>
					<td><%=expenselist.get(i).getItem() %></td>
					<td>Rs. <%=expenselist.get(i).getAmount() %></td>
					<td><%=expenselist.get(i).getPaidby() %></td>
					<td><span style="float:left"><%=expenselist.get(i).getCategory() %></span> 
					<span style="float:right"><a class="fui-cross" onclick="delete_record();" /></span></td>
				</tr>

				<%} %>

				<tr class="active">
					<td>TOTAL</td>
					<td colspan="3"><b>Rs. <%=total %></b></td>
				</tr>

			</tbody>
		</table>

		<form method="post"></form>

	</div>


	<script type="text/javascript">

	    function submit_form() {
	    	$("#expenseform").submit();
	    }

	</script>

	<script src="dist/js/vendor/jquery.min.js"></script>
    <script src="dist/js/vendor/video.js"></script>
    <script src="dist/js/flat-ui.min.js"></script>
    <script src="docs/assets/js/application.js"></script>
</body>
</html>