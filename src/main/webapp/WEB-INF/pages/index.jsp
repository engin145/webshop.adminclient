<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Администрирование</title>
</head>
<body>
	<a href="<c:url value="/j_spring_security_logout"/>">Logout</a>
	<table border="1" width="95%" align="center">
		<tr>
			<td colspan="5" align="center"><h2>Администрирование</h2></td>
		</tr>
		<tr align="center">
			<td width="21%"><a href="good">Товары</a></td>
			<td width="21%"><a href="order">Заказы</a></td>
			<td width="21%"><a href="category">Категории</a></td>
			<td width="21%"><a href="client">Клиенты</a></td>
			<td width="21%"><a href="manager">Менеджеры</a></td>
		</tr>
	</table>
</body>
</html>