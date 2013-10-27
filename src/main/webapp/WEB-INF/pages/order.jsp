<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Заказы</title>
</head>
<body>
	<a href="<c:url value="/j_spring_security_logout"/>">Logout</a>
	<form action="orders" method="post"
		style="margin: 0 auto; padding: 30px; width: 300px; border: 1px solid #000;">
		<p>
			Заказы по дате: <select name="date">
				<option selected="selected" value="1">За последний день</option>
				<option value="2">Все заказы</option>
			</select>
		</p>
		<p>
			Заказы по статусу: <select name="confirm_status">
				<option value="1">Подтвержденные</option>
				<option selected="selected" value="2">Не подтвержденные</option>
			</select>

		</p>
		
		<p>
			Отменены: <select name="cansel_status">
				<option selected="selected" value="1">Не отменены</option>
				<option value="2">Отменены пользователем</option>
				<option value="3">Отменены сервером</option>
			</select>

		</p>
		<input type="submit" value="Показать">
	</form>
</body>
</html>