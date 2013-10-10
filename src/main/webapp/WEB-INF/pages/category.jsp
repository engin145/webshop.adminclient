<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Администрирование категорий</title>
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
		xmlhttp.send("categoryId=" + categoryId + "&categoryName=" + newName);
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
	
</script>

	<table border="0" width="96%" align="center">
		<tr>
			<td width="32%"><a href="index">На главную</a></td>
			<td width="32%"><h2 align="center">Редактор категорий</h2></td>
			<td width="32%"></td>
		</tr>
	</table>

	<table border="1">
		<tr>
			<td colspan="3">Имя новой категории: <input type="text" name="name" id="newCat"></td>
			<td align="center"><input type="button" onclick="add()"
				value="Add"></td>
		</tr>

		<tr>
			<td colspan="4">|</td>
		</tr>
		<tr>
			<td align="center">id</td>
			<td align="center">Название</td>
			<td align="center">Новое название</td>
			<td></td>
		</tr>
		
		<c:forEach var="category" items="${categoryList}">
			<tr>
				<td>${category.id}</td>
				<td>${category.name}</td>
				<td><input type="text" name="newName" id="${category.id}">
					<input type="button" onclick="rename(${category.id})"
					value="Rename" /></td>
				<td><input type="button" onclick="del(${category.id})"
					value="Delete" /></td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>


