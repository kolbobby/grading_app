$('#add_s_bulk').click(function() {
	if($('table#add_bulk_students > tbody#add_bulk_students_inner').html() != "") {
		if(confirm("There is existing data within the add students table, this function will override any existing data within this table; would you like to continue?")) {
			add_list(); // VARIABLE: $('#file_select').val()
		}
	} else {
		add_list(); // VARIABLE: $('#file_select').val()
	}
	$('table').show();
	$('#confirm').show();
});
$('#confirm').click(function() {
	var empty_cells = "";
	$('table#add_bulk_students > tbody#add_bulk_students_inner').children('tr').children('td').each(function() {
		if($(this).css('background-color') == "rgb(238, 44, 44)") {
			if(empty_cells.length == 0) {
				empty_cells = ($(this).parent('tr').attr('id'));
			} else {
				empty_cells = empty_cells + ", " + ($(this).parent('tr').attr('id'));
			}
		}
	});
	if(empty_cells.length > 0) {
		confirm("There are blank cells within rows:\n" + empty_cells + "\nAre you sure you want to confirm?");
	}
});

function add_list() { // VARIABLE: list
	var files = document.getElementById('file_select').files;
	if(!files.length) {
		alert("Please select a file!");
		return;
	}

	var file = files[0];
	var reader = new FileReader();
	reader.onloadend = function(evt) {
		if (evt.target.readyState == FileReader.DONE) { // DONE == 2
			processData(evt.target.result);
		}
	}
	var blob = file.slice(0, file.size);
	reader.readAsBinaryString(blob);
	//alert(document.getElementById('file_select').files[0].name);
	/*$.ajax({
		type: "GET",
		url: list,
		dataType: "text",
		success: function(data) {processData(data);}
	});*/
}

function processData(allText) {
	var allTextLines = allText.split(/\r\n|\n/);
	var headers = allTextLines[0].split(',');
	var lines = [];

	for(var i = 1;i < allTextLines.length;i++) {
		var data = allTextLines[i].split(',');
		if(data.length == headers.length) {
			var tarr = [];
			for(var j = 0;j < headers.length;j++) {
				tarr.push(headers[j]+": "+data[j]+"\n");
			}
			lines.push(tarr);
		}
	}
	var t_str = "";
	for(var i = 0;i < lines.length;i++) {
		var data = lines[i];
		t_str += "<tr id="+i+">";
		t_str += "<td class='id'>"+i+"</td>";
		for(var j = 0;j < data.length;j++) {
			var cell_f = data[j].substring(0, data[j].indexOf(':'));
			var cell_s = data[j].substring(data[j].indexOf(':') + 2, data[j].length-1);
			if(cell_s == "") {
				t_str += "<td class="+cell_f+" style='background-color:#ee2c2c;'>"+cell_s+"</td>";
			} else {
				t_str += "<td class="+cell_f+">"+cell_s+"</td>";
			}
		}
		t_str += "</tr>";
	}
	$('table#add_bulk_students > tbody#add_bulk_students_inner').html(t_str);
}