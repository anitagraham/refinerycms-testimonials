module TestimonialsHelper

  def self.tab_classes(tab, tab_index, warnings)
    classes = ['ui-state-default']
    classes.push('ui-state-active') if tab_index==0
    if warnings.messages.count && tab.fields.present? # can signal classes by tab/field and do we have any field warnings anyway
      classes.push('ui-state-error') if tab.fields.any?{ |field| warnings.messages.keys.member?(field)}
    end
    classes.join(' ')
  end

end
