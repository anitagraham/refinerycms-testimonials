const testimonialsEnabled = document.getElementById('page_testimonials_show').checked
const formFields = {
  containerId:          'page_testimonial_control',
  enableTestimonialsId: 'page_testimonials_control',
  groupIds:             ['count', 'select', 'format'],
  setCountFieldId:      'set_count_field',
  countOptionIds:       ['count_All', 'count_Some']
  visibilityClasses:    ['hide', 'show'],
}

const setState = () => {
  formFields.groupIds.forEach(id => setVisibility(id, testimonialsEnabled))
}

const setVisibility = (id, show) => {
  element = document.getElementById(id)
  element.classList.add(formFields.visibilityClasses[+show])
  element.classList.remove(formFields.visibilityClasses[+!show])
}

changeHandler = event => {
  switch (event.target.id) case formFields.containerId:
    showOptions = event.target.checked
    formFields.groupIds.forEach(id => setVisibility(id, showOptions))
    break;
    case 'count_All', 'count_Some'
      let showCountFields = event.target.value === 'Some'
      setVisibility(formFields.setCountFieldId, showCountFields)
      break;
    default
      ;
}
const initTestimonials = () => {
  setState;
  document.getElementById('page_testimonial_control').addEventListener('change', changeHandler)
}
export default initTestimonials
