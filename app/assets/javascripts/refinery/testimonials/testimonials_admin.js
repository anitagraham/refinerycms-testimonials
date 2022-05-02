
const domReady = (callback, options) => {

  let ready = document.readyState === "interactive" || document.readyState === "complete"
  if (ready) {
    callback(options)
  } else {
    document.addEventListener("DOMContentLoaded", () => {
      callback(options)
    })
  }
}
const partition = (arr, condition) => {
  let results = {
    positive: [],
    negative: []
  }
  arr.forEach(el =>{
    condition(el) ? result.positive.push(el) : result.negative.push(el)
  })
  return results
}

const hiddenTab = tab => tab.classList.contains('ui-tabs-hide')
const testimonialsEditInit = () => {
  let pageTabs = document.getElementById('page-tabs')
  let pagePartFields = pageTabs.querySelectorAll('.page_part.field')
  let [hiddenTabs, _visibleTabs] = partition(pagePartFields, hiddenTab)

  // show all the tabs just to get their heights correct
  hiddenTabs.forEach(tab => tab.classList.remove('ui-tabs-hide'))
  let tabs = $(pageTabs).tabs();
  // hide hidden tabs again
  hiddenTabs.forEach(tab => tab.classList.add('ui-tabs-hide'))
}
domReady(testimonials_form_init)


