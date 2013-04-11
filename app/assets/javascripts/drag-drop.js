$('.draggable').click(function(event) {
	if(event.ctrlKey)
		$(this).toggleClass('grouped');
});
$('.draggable').draggable({
	start: function(event, ui) {
		count = 0;
		if($(this).hasClass('grouped')) {
			collectedData = "<div id='grouped-drags' style='display:none;'>";
			$('.grouped').each(function() {
				count++;
				collectedData += $(this).html();
			});
			collectedData += "</div>";

			prevData = $(this).html();
			$(this).html(count + " " + collectedData);

			prevDropHeight = $('li.droppable').height();
			$('li.droppable').animate({ height: '50px' }, 300);
			$('li.droppable').append("<div class='drag-here'><em>drag here</em></div>");
			prevWidth = $(this).width();
			$(this).css({ width: '15px' });

			$(this).addClass('selected');
		}
		prevPos = $(this).offset();
	},
	stop: function(event, ui) {
		if($(this).hasClass('grouped')) {
			$(this).html(prevData);

			$(this).css({ width: prevWidth });
			$('li.droppable').animate({ height: prevDropHeight }, 300);

			$('li.droppable').children('.drag-here').remove();
			$(this).removeClass('selected');
		}
		$(this).offset({ top: prevPos.top, left: prevPos.left });
	}
});
$('.droppable').droppable({
	drop: function(event, ui) {
		$.ajaxSetup({async:false});
		var draggable = ui.draggable;
		if(draggable.hasClass('grouped')) {
			var str = "";
			$.post('/get_activity', { coach: $(this).prop('id'), act: sec.substring(sec.length - 1, sec.length), mp: prim.substring(prim.length - 1, prim.length) }, function(r) { str = "The following students will be added to <strong>"+ r +"</strong>:\n"; });
			draggable.children('#grouped-drags').children('span').each(function() {
				str += $(this).html() + "\n";
			});
			str += "\nIs this correct?";

			if(confirm(str)) {
				//ADD STUDENTS TO ACTIVITY
				alert("ADDED TO ACTIVITY!");
			}
		}
		$.ajaxSetup({async:true});
	}
});