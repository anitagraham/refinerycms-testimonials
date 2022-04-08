// Used on the Refinery::Page edit screen to ensure the extra tabs are initialized

const editorTabsInit = () => page_options.initialised || page_options.init(false, '', '')

$(document).ready(editorTabsInit())
