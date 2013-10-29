<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">
.users {
	width: 100%; /* Ширина таблицы */
	border-collapse: collapse; /* Убираем двойные линии между ячейками */
}

.users {
	padding: 3px; /* Поля вокруг содержимого таблицы */
	border: 1px solid #000; /* Параметры рамки */
}

tbody .user:hover {
	background: #afd792; /* Цвет фона при наведении */
}
</style>
<title>Клиенты</title>
<script type="text/JavaScript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.js">
	
</script>
<script type="text/JavaScript"
	src="${pageContext.request.contextPath}/resources/js/jquery.json-2.2.js">
	
</script>

<script type="text/javascript">
	function getInfo(id) {
		//document.location.href = "userOrders?id="+id;
		document.location.href = "orderFull?num="+id;
	}
</script>


</head>
<body>
	<a href="<c:url value="/j_spring_security_logout"/>">Logout</a>

	<table border="0" width="96%" align="center">
		<tr>
			<td width="32%"><a href="index">На главную</a></td>
			<td width="32%"><h2 align="center">Список
					зарегистрированных клиентов</h2></td>
			<td width="32%"></td>
		</tr>
	</table>
	<br>
	<table class="users" border="1" width="96%" align="center">
		<tr align="center">
			<td>id</td>
			<td><a href="q1.html" target="quest">Имя</a></td>
			<td>e-mail</td>
			<td>телефон</td>
			<td>Login</td>
			<td>Пароль</td>
			<td>Купил на</td>
		</tr>
		<c:forEach var="user" items="${userList}">
			<tr class="user" onclick="getInfo(${user.id})" align="center">
				<td>${user.id}</td>
				<td>${user.name}</td>
				<td>${user.email}</td>
				<td>${user.phone}</td>
				<td>${user.login}</td>
				<td>${user.pass}</td>
				<td>Купил на</td>
			</tr>
		</c:forEach>
	</table>



	<div id="dynamic"></div>
	<script>
		doRequest();
	</script>
</body>
</html>