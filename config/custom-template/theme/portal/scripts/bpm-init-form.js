/*
Usage:
<script type="text/javascript" language="javascript" src="themeResource?theme=portal&location=scripts/gsat-init-form.js"></script>
*/

$("input[gsat-endpoint]").each( function () {
	var endpoint = $(this).attr('gsat-endpoint');
	var field = $(this).attr('gsat-get');
	var type = $(this).attr('type');
	
	$(this).gsatApi({
		endpoint : endpoint,
		field : field,
		type : "suggestion",
		query : "",
		template : "<p><strong>{{"+ field +"}} </strong></p>",
		onSelected : function (obj, data) {			
			$.each(data, function (idx, val) {				
				$("input[gsat-set="+ idx +"]").val(val);
			});
	 }
	});
});
