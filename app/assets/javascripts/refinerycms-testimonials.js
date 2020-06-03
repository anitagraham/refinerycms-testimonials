// NEEDS more work. but it must wait
// const fields = {
//   'enable_id': 'page_testimonials_show',
//   'all_fields_selector': '.fields input',
//   'count_group_id': 'count'
//   'show_all_id': 'count_all',
//   'show_some_id': 'count_some',
//   'testimonials_count_field_id': '#page_testimonials_count',
//   'show_recent': '',
//   'show_random': '',
//   'show_full': '',
//   'show_excerpt': ''
// }
//
// const switch_elements = (selector, enable) => {
//   elements = document.querySelectorAll(selector);
//   elements.forEach( el => el.disabled = enable)
// }
//
// countGroupElement = document.getElementById(fields.count_group_id)
// countElement.addEventListener('change', event => {
//   let show_some_input = document.getElementById(fields.show_some_id)
//   let count_input = document.getElementById(fields.testimonials_count_field_id)
//   count_input.disabled = show_some_input.checked
// })
//
// enableElement = document.getElementById(fields.enable);
// enableElement.addEventListener('change', event => {
//   switch_elements(fields.all_fields, event.target.checked )
// })
//
//
//
//
// jQuery(function() {
// 	control_field = $('input#page_testimonials_show');
// 	input_fields = $('div.fields > input');
// 	// control_field.button();
// 	input_fields.buttonset();
// 	$('input#page_testimonials_show').on('change', function(){
// 		var disabled = !this.checked
// 		input_fields.each(function() {$(this).attr('disabled', disabled)})
// 	})
// })
