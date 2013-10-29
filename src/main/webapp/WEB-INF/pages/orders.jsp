<%@page import="com.algo.webshop.adminclient.good.OrderFull"%>
<%@page import="com.algo.webshop.common.domain.Order"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<style type="text/css">
td {
	padding: 10px;
}

table {
	border-collapse: collapse;
	text-align: center;
	margin: 0 auto;
}

td {
	border: 1px solid #000;
}
.info {
	border: none;
}

</style>
<body>
	<p>
		<a href="index">На главную</a>
	</p>
	<c:choose>
		<c:when test="${not empty orderList}">
			<table>
				<tr>
					<td>Номер</td>
					<td>Псевдоним</td>
					<td>Дата заказа</td>
					<td>Статус оплаты</td>
					<td>Статус отправки</td>
				</tr>
				<%
					List<OrderFull> orderList = (List<OrderFull>) request
									.getAttribute("orderList");
							for (OrderFull order : orderList) {
								SimpleDateFormat formatter = new SimpleDateFormat(
										"yyyy-MM-dd hh.mm.ss");
								String time = formatter.format(order.getDate_order()
										.getTime());
								out.println("<tr><td><a href=orderFull?order="+order.getNumber()+">" + order.getNumber()
										+ "</a></td><td>" + order.getUserName()
										+ "</td><td>" + time + "</td>");
								if (order.getDate_pay() != null) {
									out.println("<td><img src="+request.getContextPath()+"/resources/picture/tick.png></td>");
								} else {
									out.println("<td><img src="+request.getContextPath()+"/resources/picture/error.png></td>");
								}
								if (order.getDate_release() != null) {
									out.println("<td><img src="+request.getContextPath()+"/resources/picture/tick.png></td>");
								} else {
									out.println("<td><img src="+request.getContextPath()+"/resources/picture/error.png></td>");
								}
		
							}
				%>
			</table>
		</c:when>
		<c:otherwise><p/>Заказов не найдено!<p></c:otherwise>
	</c:choose>
</body>
</html>