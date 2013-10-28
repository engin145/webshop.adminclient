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
	var categoryMap = [];
	var manufacturerMap = [];
	var unitMap = [];
	var listGoods = [];

	function addCategory(key, value) {
		categoryMap[key] = value;
	}

	function addManufacturer(key, value) {
		manufacturerMap[key] = value;
	}

	function addUnit(key, value) {
		unitMap[key] = value;
	}

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
			}
		}
	}

	function tableOut(list) {
		var out = document.getElementById("dynamic");
		var content;

		// table header
		content = '<table border="0" align = "center" id="tableGood"><tr>\
			<td align="center">id</td>\
			<td align="center">Название</td>\
			<td align="center">Производитель</td>\
			<td align="center">Цена</td>\
			<td align="center">Цена+</td>\
			<td align="center">К-во</td>\
			<td align="center">К-во+</td>\
			<td align="center"></td>\
			<td></td>\
		</tr>';
		var id;
		// idNode (id=01, name=02, manuf=03, price=04, addPrice=05, amount=06, addAmount=07, unit=08, butInfo=09)
		// idNode (del=10, categCell=11, descCell=12, longDescCell=13, selCat=14, inputDesc=15, textareaLongDesc=16)
		for ( var i = 0; i < list.length; i++) {
			content += '<tr>';
			//field id
			content += '<td>' + list[i].id + '</td>';
			//field name
			id = '"' + list[i].id + '02"';
			content += '<td><input type="text" id=' + id
					+ ' onblur=changeValue(' + id + ') onfocus=clean(' + id
					+ ') value="' + list[i].name + '"></td>';
			//field manufacturer
			id = '"' + list[i].id + '03"';
			content += '<td><select id=' + id + ' onchange=changeValue(' + id
					+ ')>' + createSelManuf(list[i].manufacturers_id)
					+ '</select></td>';
			//field price
			id = '"' + list[i].id + '04"';
			content += '<td><input type="text" id=' + id
					+ ' onblur=changeValue(' + id + ') onfocus=clean(' + id
					+ ') size="4" style="text-align:right" value="';
			if (list[i].price !== 0)
				content += list[i].price;
			else
				content += '----';
			content += '"></td>';
			//field add price
			id = '"' + list[i].id + '05"';
			content += '<td><input type="text" id=' + id + ' onblur=cleanPlus('
					+ id + ') size="4" style="text-align:right"></td>';
			//field amount
			id = '"' + list[i].id + '06"';
			content += '<td><input type="text" id=' + id
					+ ' onblur=changeValue(' + id + ') onfocus=clean(' + id
					+ ') size="4" style="text-align:right" value="'
					+ list[i].amount + '"></td>';
			//field add amount
			id = '"' + list[i].id + '07"';
			content += '<td><input type="text" id=' + id + ' onblur=cleanPlus('
					+ id + ') size="4" style="text-align:right"></td>';
			//field unit
			id = '"' + list[i].id + '08"';
			content += '<td><select id=' + id + ' onchange=changeValue(' + id
					+ ')>' + createSelUnit(list[i].units_id) + '</select></td>';

			// button изменить
			id = '"' + list[i].id + '09"';
			content += '<td><input type="button" value="+" onclick=info(' + id
					+ ') /></td>';
			// button удалить
			content += '<td><input type="button" value="Delete" onclick="del(';
			content += list[i].id;
			content += ', ' + i;
			content += ')" /></td></tr>';

			// nextRow category and description
			id = '"' + list[i].id + '11"';
			content += '<tr><td></td><td id='+id+'></td>';
			id = '"' + list[i].id + '12"';
			content += '<td id='+id+' colspan="6"></td></tr>';

			// nextRow longDescription
			id = '"' + list[i].id + '13"';
			content += '<tr><td></td><td id='+id+' colspan="7"></td></tr>';
		}
		content = content + '</table>';

		out.innerHTML = content;
	}

	function info(idElem) {
		var n = idElem.length - 2;
		var idG = idElem.substring(0, n); //id товара
		idElem++;
		idElem--;
		var idC = idElem + 2; //id ячейки куда будет вставлятся select
		var idD = idElem + 3; //id ячейки куда будет вставлятся descroption
		var idL = idElem + 4; //id ячейки куда будет вставлятся longDescroption
		var idS = idElem + 5; //id самого select
		var idDI = idElem + 6; //id input куда будет вставлятся descroption
		var idLI = idElem + 7; //id textarea куда будет вставлятся longDescroption

		var catConteiner = document.getElementById(idC);
		var descConteiner = document.getElementById(idD);
		var longDescConteiner = document.getElementById(idL);
		if (catConteiner.innerHTML == '') {
			idCat = listGoods[getIndexGood(idG)].category_id;
			var content = '<select id=' + idS + ' onchange=changeValue(' + idS
					+ ')>' + createSelCat(idCat) + '</select>';
			catConteiner.innerHTML = content;
			var desc = '';
			desc = listGoods[getIndexGood(idG)].description;
			if (desc == null)
				desc = '';
			getLongDesc(idG, idLI);
			content = '<input type="text" style="width: 100%" id=' + idDI
					+ ' value="' + desc + '" onchange=changeValue(' + idDI
					+ ') />';
			descConteiner.innerHTML = content;
			content = '<textarea rows="4" onchange=changeValue(' + idLI
					+ ') cols="60" id=' + idLI + '></textarea>';
			longDescConteiner.innerHTML = content;
		} else {
			catConteiner.innerHTML = '';
			descConteiner.innerHTML = '';
			longDescConteiner.innerHTML = '';
		}

	}

	function getLongDesc(idGood, idLI) {
		$
				.ajax({
					url : 'getLongDesc',
					type : 'POST',
					dataType : 'text',
					data : ({
						id : idGood
					}),
					success : function(data) {
						document.getElementById(idLI).innerText = data;
					},
					error : function(e) {
						document.getElementById(idLI).innerText = 'Не удалось получить данные!';
					}
				});
	}

	function clean(idElem) {
		document.getElementById(idElem).value = '';
	}

	function cleanPlus(idElem) {
		changeValue(idElem);
		clean(idElem);
	}

	function createSelCat(idCel) {
		return createSelect(categoryMap, idCel);
	}
	function createSelManuf(idManuf) {
		return createSelect(manufacturerMap, idManuf);
	}
	function createSelUnit(idUnit) {
		return createSelect(unitMap, idUnit);
	}

	function createSelect(map, id) {
		var str = '';
		for ( var key in map) {
			str += '<option value="';
			str += key;
			if (key == id)
				str += '" selected="selected';
			str += '">';
			str += map[key];
			str += '</option>';
		}
		return str;
	}

	function getIndexGood(id) {
		for ( var i = 0; i < listGoods.length; i++) {
			if (listGoods[i].id == id) {
				return i;
			}
		}
	}

	function changeValue(idElem) {
		var val = document.getElementById(idElem).value;
		if (val != '') {
			$.ajax({
				url : 'changeValue',
				type : 'POST',
				dataType : 'json',
				data : ({
					id : idElem,
					value : val
				}),
				success : function(data) {
					if (idElem % 100 == 5)
						document.getElementById(idElem - 1).value = data;
					if (idElem % 100 == 7)
						document.getElementById(idElem - 1).value = data;
					if (idElem % 100 == 14) {
						var idG = Math.ceil(idElem / 100 - 1); //id товара
						listGoods[getIndexGood(idG)].category_id = val;
					}
					if (idElem % 100 == 15) {
						var idG = Math.ceil(idElem / 100 - 1); //id товара
						listGoods[getIndexGood(idG)].description = val;
					}

				},
				error : function(e) {
					alert("Не удалось отправить изменения");
				}
			});
		}
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
				} else {
					alert('Этот товар нельзя удалить!');
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
			<td width="32%"><h2 align="center">Редактор товаров</h2></td>
			<td width="32%" align="right"><input type="button"
				onclick='window.location.href="newGood"' value="Добавить товар" /></td>
		</tr>
	</table>

	<table border="0" width="96%" align="center">
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
						<script>
							addCategory("${category.key}", "${category.value}");
						</script>
					</c:forEach>
			</select></td>
			<td><select id="selectManufacturer">
					<option selected="selected" value="0">Все</option>
					<c:forEach var="manufacturer" items="${manufacturerMap}">
						<option value="${manufacturer.key}">${manufacturer.value}</option>
						<script>
							addManufacturer("${manufacturer.key}",
									"${manufacturer.value}");
						</script>
					</c:forEach>
			</select></td>

			<c:forEach var="unit" items="${unitMap}">
				<script>
					addUnit("${unit.key}", "${unit.value}");
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

