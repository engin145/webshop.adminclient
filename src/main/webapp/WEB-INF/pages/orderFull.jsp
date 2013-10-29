<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Заказ № ${num}</title>

<script type="text/javascript">
var sum = 0;

function multiplication(x,y) {
	x=x*y;
	x=Number(x).toFixed(2);
	sum += parseFloat(x);
	return x;
}

</script>

</head>
<body>
	<a href="<c:url value="/j_spring_security_logout"/>">Logout</a>
	<table border="0" width="96%" align="center">
		<tr>
			<td width="32%"><a href="index">На главную</a></td>
			<td width="32%"><h2 align="center">Заказ № ${num}</h2></td>
			<td width="32%" align="right"><a href="user">Список клиентов</a></td>
		</tr>
	</table>

	<br>
	<table border="0">
		<tr>
			<td>Имя заказчика:</td>
			<td>${userName}</td>
		</tr>
		<tr>
			<td>Дата заказа:</td>
			<td>${date}</td>
		</tr>
		<tr>
			<td>Дата оплаты:</td>
			<td>${pay}</td>
		</tr>
		<tr>
			<td>Товар отпущен:</td>
			<td>${release}</td>
		</tr>
	</table>

	<p>${confirm}</p>
	<p>${cansel}</p>
	<br>
	<table width="96%" align="center" border="1">
		<caption>Список товаров</caption>
		<tr>
			<td align="center">id</td>
			<td align="center">Товар</td>
			<td align="center">К-во</td>
			<td align="center">Цена</td>
			<td align="center">Сумма, грн</td>
		</tr>
		<c:forEach var="basketList" items="${position.basketList}">
			<tr>
				<td align="center">${basketList.goodId}</td>
				<td align="center">${basketList.nameGood}</td>
				<td align="center">${basketList.value}</td>
				<td align="right"><script>document.write(Number(${basketList.price}).toFixed(2));</script></td>
				<td align="right"><script>
				document.write(multiplication(${basketList.value}, ${basketList.price}));
				</script></td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="4">Сумма:</td>
			<td align="right"><script>document.write(Number(sum).toFixed(2));</script></td>
		</tr>
	</table>

</body>
</html>