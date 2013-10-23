<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Администрирование товаров</title>

<script type="text/JavaScript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.js">
	
</script>
<script type="text/JavaScript"
	src="${pageContext.request.contextPath}/resources/js/jquery.json-2.2.js">
	
</script>

<script type="text/javascript">
	var manufacturerMap = [];
	var unitMap = [];
	var listGoods = [];

	function copyArray(l) {
		for ( var i = 0; i < l.length; i++) {
			listGoods[i] = {
				id : l[i].id,
				name : l[i].name,
				description : l[i].description,
				category_id : l[i].category_id,
				manufacturers_id : l[i].manufacturers_id,
				amount : l[i].amount,
				units_id : l[i].units_id,
				price : l[i].price
			};
		}
	}

	function addManufacturer(key, value) {
		manufacturerMap[key] = value;
	}

	function addUnit(key, value) {
		unitMap[key] = value;
	}

	function tableOut(list) {
		var out = document.getElementById("dynamic");
		var content;

		// table header
		content = '<table border="1" align = "center"><tr>\
			<td align="center">id</td>\
			<td align="center">Название</td>\
			<td align="center">Производитель</td>\
			<td align="center">Цена</td>\
			<td align="center">К-во</td>\
			<td align="center"></td>\
			<td width="100"></td>\
		</tr>';
		// content
		for ( var i = 0; i < list.length; i++) {
			content += '<tr>';
			//field id
			content += '<td>';
			content += list[i].id;
			content += '</td><td><input type="text" id="newName" value="';
			content += list[i].name;
			//field manufacturer 
			content += '" id="25"></td><td>';
			content += manufacturerMap[list[i].manufacturers_id];
			//field price
			content += '</td><td><input type="text"  size="4" style="text-align:right" value="';
			if (list[i].price !== 0)
				content += list[i].price;
			else
				content += '----';
			//field amount
			content += '" id="25"></td><td><input type="text" style="text-align:right" size="4" value="';
			content += list[i].amount;
			//field unit
			content += '" id="25"></td><td>';
			content += unitMap[list[i].units_id];
			// button изменить
			content += '</td><td><input type="button" value="Изменить" onclick="edit('
			content += list[i].id;
			content += ')" /></td>';
			// button удалить
			content += '<td><input type="button" value="Delete" onclick="del(';
			content += list[i].id;
			content += ', ' + i;
			content += ')" /></td></tr>';
		}
		content = content + '</table>';

		out.innerHTML = content;
	}

	function edit (goodId) {
		//alert (goodId);
		
		$.ajax({
			url : 'editGood',
			type : 'POST',
			dataType : 'text',
			data : "id=" + goodId,
		});
	}
	
	function del(goodId, index) {
		$.ajax({
			url : 'deleteGood',
			type : 'POST',
			dataType : 'text',
			data : "id=" + goodId,
			success : function(confirm) {
				if (confirm == 1) {
					listGoods.splice(index, 1);
					tableOut(listGoods);
				}
				else {
					alert ('Этот товар нельзя удалить!');
				}
			},
			error : function(e) {
				alert("error" + e);
			}
		});
	}

	function doRequest() {
		var category = $("#selectCategory").val();
		var manufacturer = $("#selectManufacturer").val();
		var min = $("#min").val();
		var max = $("#max").val();
		if (min == '')
			min = -1;
		if (max == '')
			max = -1;
		$.ajax({
			url : 'getGoods',
			type : 'POST',
			dataType : 'json',
			async : 'false',
			data : ({
				categoryId : category,
				manufacturerId : manufacturer,
				minAmount : min,
				maxAmount : max
			}),
			success : function(data) {
				tableOut(data.goods);
				copyArray(data.goods);
				//alert(data.goods[2].name);
			},
			error : function(e) {
				alert("error" + e);
			}
		});
	}
</script>
</head>

<body>

	<table border="0" width="96%" align="center">
		<tr>
			<td width="32%"><a href="index">На главную</a></td>
			<td width="32%"><h2 align="center">Редактор товаров</h2></td>
			<td width="32%" align="right"><input type="button"
				onclick='window.location.href="newGood"' value="Добавить товар" /></td>
		</tr>
	</table>

	<table border="1" width="96%" align="center">
		<tr align="center">
			<td>Выберите категорию</td>
			<td>Выберите производителя</td>
			<td>min к-во</td>
			<td>max к-во</td>
			<td></td>
		</tr>
		<tr align="center">
			<td><select id="selectCategory">
					<option selected="selected" value="0"></option>
					<c:forEach var="category" items="${categoryMap}">
						<option value="${category.key}">${category.value}</option>
					</c:forEach>
			</select></td>
			<td><select id="selectManufacturer">
					<option selected="selected" value="0">Все</option>
					<c:forEach var="manufacturer" items="${manufacturerMap}">
						<option value="${manufacturer.key}">${manufacturer.value}</option>
						<script>
							addManufacturer("${manufacturer.key}",
									"${manufacturer.value}")
						</script>
					</c:forEach>
			</select></td>

			<c:forEach var="unit" items="${unitMap}">
				<script>
					addUnit("${unit.key}", "${unit.value}")
				</script>
			</c:forEach>

			<td><input type="text" id="min" size="3" /></td>
			<td><input type="text" id="max" size="3" /></td>
			<td><input type="button" onclick="doRequest()" value="Выбрать" /></td>
		</tr>
	</table>
	<br>
	<div id="dynamic"></div>
</body>
</html>

