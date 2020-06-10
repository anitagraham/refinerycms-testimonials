const formFields = {
  testimonialsTab: {id: 'page_testimonial_control'},
  fieldsets: {
    tag: 'fieldset',
    visible_when_checked: 'page_testimonials_show'
  },
  setNumberField: {
    id: 'set_number_field',
    visible_when_checked: 'count_Some'
  }
}
const visibilityClasses = ['hide', 'show']

const has_visibility_rule = key => formFields[key].hasOwnProperty('visible_when_checked')
const handleChange = _event => { Object.keys(formFields).filter(has_visibility_rule).forEach(useRule) }

const useRule = fieldKey => {
  let masterFieldId = formFields[fieldKey].visible_when_checked
  let state = document.getElementById(masterFieldId).checked
   setVisibility(fieldKey, state)
}

const setVisibility = (key, show) => {
  let elements
  if (formFields[key].hasOwnProperty('id')) {
    elements = [document.getElementById(formFields[key].id)]
  }
  if (formFields[key].hasOwnProperty('tag')) {
    elements = Array.from(document.getElementsByTagName(formFields[key].tag))
  }
  elements.forEach( el => {
    el.classList.add(visibilityClasses[+show])
    el.classList.remove(visibilityClasses[+!show])
  })
}


$(document).ready(() => {
  handleChange  // really set up the initial state
  let testimonialTab = document.getElementById(formFields.testimonialsTab.id)
  testimonialTab.addEventListener('change', handleChange)
})
