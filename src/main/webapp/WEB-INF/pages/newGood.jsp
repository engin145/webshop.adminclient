<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Добавление товара</title>
<style>
select {
	width: 205px; /* Ширина списка в пикселах */
}
</style>

<script type="text/JavaScript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.js">
	
</script>
<script type="text/JavaScript"
	src="${pageContext.request.contextPath}/resources/js/jquery.json-2.2.js">
	
</script>

<script type="text/javascript">

	function verify() {
		var emptyField = 0;
		// Обязательные поля
		var category = $("#selectCategory").val();
		var manufacturer = $("#selectManufacturer").val();
		var unit = $("#selectUnit").val();
		var name = $("#nameGood").val();
		// Необязательные поля
		var amount = $("#amountGood").val();
		var price = $("#priceGood").val();
		var description = $("#descriptionGood").val();
		var fullDescription = $("#fullDescriptionGood").val();
		
		// проверка
		var elemCat = document.getElementById("notCategory");
		if (category == 0) {
			elemCat.innerHTML = "Выберите категорию!";
			emptyField++;
		} else
			elemCat.innerHTML = "";

		var elemManuf = document.getElementById("notManufacturer");
		if (manufacturer == 0) {
			elemManuf.innerHTML = "Выберите производителя!";
			emptyField++;
		} else
			elemManuf.innerHTML = "";

		var elemUnit = document.getElementById("notUnit");
		if (unit == 0) {
			elemUnit.innerHTML = "Укажите единицы измерения!";
			emptyField++;
		} else
			elemUnit.innerHTML = "";

		var elemName = document.getElementById("notName");
		if (name == "") {
			elemName.innerHTML = "Введите имя товара!";
			emptyField++;
		} else
			elemName.innerHTML = "";
		if (emptyField > 0)
			return;

		$.ajax({
			url : 'addGood',
			type : 'POST',
			dataType : 'json',
			async : 'false',
			data : ({
				categoryGood : category,
				manufacturerGood : manufacturer,
				unitGood : unit,
				nameGood : name,
				amountGood : amount,
				priceGood : price,
				descriptionGood : description,
				fullDescriptionGood : fullDescription
			}),
			success : function(data) {
				alert("Товар добавлен!");
				$('#res').click();
			},
			error : function(e) {
				alert("При добавлении произошла ошибка");
			}
		});
	}
</script>


</head>
<body>
	<a href="<c:url value="/j_spring_security_logout"/>">Logout</a>
	<table border="0" width="96%" align="center">
		<tr>
			<td><a href="index">На главную</a></td>
			<td><h2 align="center">Добавление товара</h2></td>
			<td><a href="good">Редактор товаров</a></td>
		</tr>
	</table>
	<br>
	<form>
		<table border="0" width="96%" align="center">
			<tr>
				<td width="50%" colspan="2" align="center"><h3>Поля для
						обязательного ввода данных</h3></td>
				<td width="50%" colspan="2" align="center"><h3>Необязательные
						поля</h3></td>
			</tr>
			<tr>
				<td></td>
				<td align="center"></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td><font color="#CC0000" id="notCategory"></font></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td align="right">Категория:</td>
				<td><select id="selectCategory">
						<option selected="selected" value="0"></option>
						<c:forEach var="category" items="${categoryMap}">
							<option value="${category.key}">${category.value}</option>
						</c:forEach>
				</select></td>
				<td align="right">Количество:</td>
				<td><input type="text" id="amountGood" /></td>
			</tr>
			<tr>
				<td></td>
				<td align="center"></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td><font color="#CC0000" id="notManufacturer"></font></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td align="right">Производитель:</td>
				<td><select id="selectManufacturer">
						<option selected="selected" value="0"></option>
						<c:forEach var="manufacturer" items="${manufacturerMap}">
							<option value="${manufacturer.key}">${manufacturer.value}</option>
						</c:forEach>
				</select></td>
				<td align="right">Цена:</td>
				<td><input type="text" id="priceGood" /></td>
			</tr>
			<tr>
				<td></td>
				<td align="center"></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td><font color="#CC0000" id="notUnit"></font></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td align="right">Единицы измерения:</td>
				<td><select id="selectUnit">
						<option selected="selected" value="0"></option>
						<c:forEach var="unit" items="${unitMap}">
							<option value="${unit.key}">${unit.value}</option>
						</c:forEach>
				</select></td>
				<td align="right">Описание товара:</td>
				<td><input type="text" id="descriptionGood" /></td>
			</tr>
			<tr>
				<td></td>
				<td align="center"></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td><font color="#CC0000" id="notName"></font></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td align="right">Название:</td>
				<td><input type="text" id="nameGood" /></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="3"><h3>Дополнительное описание товара (при
						необходимости):</h3></td>
				<td align="center"><input type="reset" id="res" value="Очистить"></td>
			</tr>
			<tr>
				<td colspan="3"><textarea cols="60" rows="3"
						id="fullDescriptionGood"></textarea></td>
				<td align="center"><input type="button" onclick="verify()"
					value="Сохранить"></td>
			</tr>
		</table>
	</form>
</body>
</html>