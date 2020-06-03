module MustacheTemplateHandler
  def self.call(template, source)
    if template.locals.include? :mustache
      "Mustache.render(#{source.inspect}, mustache).html_safe"
    else
      "#{source.inspect}.html_safe"
    end
  end
end

ActionView::Template.register_template_handler(:mustache, MustacheTemplateHandler)
