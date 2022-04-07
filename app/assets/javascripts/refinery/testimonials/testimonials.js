// Used on the Refinery::Page edit screen, to handle allocating testimonials to pages
const testimonialsSelect= 'testimonial_multiselect'

if (typeof multiSelectInit == 'undefined')
{
  const multiSelectInit = element => {

    let multiSelectOptions = {
      "enable_search": true,
      "search_placeholder": "Search...",
      "non_selected_header": 'Available',
      "selected_header": 'Selected',
      addButtonText: '>',
      removeButtonText: '<',
      addAllButtonText: '>>',
      removeAllButtonText: '<<',
      "limit": -1
    }
    multi(element, multiSelectOptions)
  };
}

const editorTabsInit = () => page_options.initialised || page_options.init(false, '', '')


const testimonialsInit = () => {
  editorTabsInit()
  let multiselect_element =  document.getElementById(testimonialsSelect)
  multiselect_element &&  multiSelectInit(multiselect_element)
}

$(document).ready(testimonialsInit)
