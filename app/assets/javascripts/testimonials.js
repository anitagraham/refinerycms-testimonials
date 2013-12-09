jQuery(function() {
	control_field = $('input#page_testimonials_show');
	input_fields = $('div.fields > input');
	// control_field.button();
	input_fields.buttonset();
	$('input#page_testimonials_show').on('change', function(){
		var disabled = !this.checked
		input_fields.each(function() {$(this).attr('disabled', disabled)})
	})
})