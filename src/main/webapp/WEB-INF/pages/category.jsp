<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Администрирование категорий</title>

<script type="text/JavaScript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.js">
	
</script>
<script type="text/JavaScript"
	src="${pageContext.request.contextPath}/resources/js/jquery.json-2.2.js">
	
</script>

<script type="text/javascript">
	var list = [];

	function copyArray(l) {
		for ( var i = 0; i < l.length; i++) {
			list[i] = {
				id : l[i].id,
				name : l[i].name
			};
		}
	}

	function tableOut(list) {
		var out = document.getElementById("dynamic");
		var content;
		// add
		content = '<table border="1" align = "center">\
			<tr>\
				<td colspan="3">Имя новой категории: <input type="text" name="name" id="newCat"></td>\
				<td align="center"><input type="button" onclick="add()" value="Add"></td>\
			</tr>\
			<tr><td colspan="4">|</td></tr>';
		// table header
		content = content
				+ '<tr>\
				<td align="center">id</td>\
				<td align="center">Название</td>\
				<td align="center">Новое название</td>\
				<td></td>\
			</tr>';
		// content
		for ( var i = 0; i < list.length; i++) {
			content += '<tr>';
			content += '<td>';
			content += list[i].id;
			content += '</td><td>';
			content += list[i].name;
			content += '</td>\
				<td><input type="text" name="newName" id="';
				content += list[i].id;
				content += '"><input type="button" onclick="rename(';
			content += list[i].id + ', ' + i;
			content += ')" value="Rename" /></td>\
				<td><input type="button" onclick="del(';
			content += list[i].id + ', ' + i;
			content += ')" value="Delete" /></td></tr>';
		}
		content = content + '</table>';
		out.innerHTML = content;
	}

	function add() {
		var newCategory = document.getElementById('newCat').value;
		$.ajax({
			url : 'addCategory',
			type : 'POST',
			dataType : 'text',
			data : "name=" + newCategory,
			success : function(idNew) {
				if (idNew > 0) {
					list.push({
						id : idNew,
						name : newCategory
					});
					tableOut(list);
				}
			},
			error : function(e) {
				alert("error" + e);
			}
		});
	}

	function rename(categoryId, index) {
		var newName = document.getElementById(categoryId).value;
		$.ajax({
			url : 'renameCategory',
			type : 'POST',
			dataType : 'text',
			data : "id=" + categoryId + "&name=" + newName,
			success : function(confirm) {
				if (confirm = 1) {
					list[index].name=newName;
					tableOut(list);
				}
			},
			error : function(e) {
				alert("error" + e);
			}
		});
	}

	function del(categoryId, index) {
		$.ajax({
			url : 'deleteCategory',
			type : 'POST',
			dataType : 'text',
			data : "id=" + categoryId,
			success : function(confirm) {
				if (confirm == 1) {
					list.splice(index, 1);
					tableOut(list);
				}
			},
			error : function(e) {
				alert("error" + e);
			}
		});
	}

	function doRequest() {
		$.ajax({
			url : 'getCategorys',
			type : 'POST',
			dataType : 'json',
			async : 'false',
			success : function(data) {
				tableOut(data.categoryList);
				copyArray(data.categoryList);
			},
			error : function(e) {
				alert("error" + e);
			}
		});
	}
</script>
</head>

<body>
	<a href="<c:url value="/j_spring_security_logout"/>">Logout</a>
	<table border="0" width="96%" align="center">
		<tr>
			<td width="32%"><a href="index">На главную</a></td>
			<td width="32%"><h2 align="center">Редактор категорий</h2></td>
			<td width="32%"></td>
		</tr>
	</table>

	<div id="dynamic"></div>
	<script>
		doRequest();
	</script>


</body>
</html>


