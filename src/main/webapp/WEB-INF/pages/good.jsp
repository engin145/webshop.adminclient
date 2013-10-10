<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Администрирование товаров</title>
</head>

<body>

	<script type="text/javascript">
		function add() {
			var xmlhttp;
			var newCategory = document.getElementById('newCat').value;
			xmlhttp = new XMLHttpRequest();
			xmlhttp.open("POST", "addCategory", true);
			//alert(newName);
			xmlhttp.setRequestHeader("Content-type",
					"application/x-www-form-urlencoded");
			xmlhttp.send("nameCategory=" + newCategory);
			window.location.reload();
		}

		function rename(categoryId) {
			var xmlhttp;
			var newName = document.getElementById(categoryId).value;
			xmlhttp = new XMLHttpRequest();
			xmlhttp.open("POST", "renameCategory", true);
			//alert(newName);
			xmlhttp.setRequestHeader("Content-type",
					"application/x-www-form-urlencoded");
			xmlhttp.send("categoryId=" + categoryId + "&categoryName="
					+ newName);
			window.location.reload();
		}

		function del(categoryId) {
			var xmlhttp;
			xmlhttp = new XMLHttpRequest();
			xmlhttp.open("POST", "deleteCategory", true);
			xmlhttp.setRequestHeader("Content-type",
					"application/x-www-form-urlencoded");
			xmlhttp.send("categoryId=" + categoryId);
			window.location.reload();
		}
		
		function selectGood() {
			var categoryId = document.forms["reg"].elements["Category"].value;
			//alert(n);
			var xmlhttp;
			xmlhttp = new XMLHttpRequest();
			xmlhttp.open("POST", "goodSelect", true);
			xmlhttp.setRequestHeader("Content-type",
					"application/x-www-form-urlencoded");
			xmlhttp.send("categoryId="+categoryId);
			window.location.reload();
		}
		
	</script>
	<table border="0" width="96%" align="center">
		<tr>
			<td width="32%"><a href="index">На главную</a></td>
			<td width="32%"><h2 align="center">Редактор товаров</h2></td>
			<td width="32%"></td>
		</tr>
	</table>

	<div>
		<form id="reg" name="reg" method="post">
			<p>
				<select name="Category" size="1">
					<option selected="selected" value="0">Выберите
						категорию</option>
					<c:forEach var="category" items="${categoryList}">
						<option value="${category.id}">${category.name}</option>
					</c:forEach>
				</select>
			</p>
			<p>
				<input type="button" onclick="selectGood()"
					value="Выбрать" />
			</p>
		</form>
	</div>
	

	<table border="1">

		<tr>
			<td align="center">id</td>
			<td align="center">Название</td>
			<td align="center">К-во</td>
			<td></td>
		</tr>

		<c:forEach var="good" items="${goodList}">
			<tr>
				<td>${good.id}</td>
				<td>${good.name}</td>
				<td>${good.amount}</td>
				<td></td>

			</tr>
		</c:forEach>
	</table>
${massage}
</body>
</html>

