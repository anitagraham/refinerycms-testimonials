module Refinery
  module Pages
    class TestimonialsSectionPresenter < Refinery::Pages::CollectionPresenter
      include ActiveSupport::Configurable
      # A presenter which knows how to render a single testimonial

      attr_accessor :output_buffer
      config_accessor :item_class, :item_tag, :quote_includes_cite, :date_tag, :name_tag, :quote_tag, :cite_tag

      self.item_class = :received_channel
      self.item_tag = :li
      self.date_tag = :p
      self.name_tag = :p
      self.quote_tag = :blockquote
      self.cite_tag = :cite
      self.quote_includes_cite = true

      def initialize(page_part)
        # return if page_part.nil?
        super
        self.fallback_html = ""
      end

     def content_html(can_use_fallback)
        override_html.present? ? override_html : collection_markup()
      end

      private

      def item_markup(item)
        ic = item.respond_to?(item_class) ? item.send(item_class) : item_class
        content_tag(item_tag.to_sym, id: item.id, class: ic) do
          buffer = ActiveSupport::SafeBuffer.new
          buffer << date_markup(item.received_date)  << quote_markup(item.quote, item.name, item.job_title, item.company, item.website)
        end
      end

      def date_markup(date)
        content_tag(date_tag, date, class: "date")
      end

      def name_markup(name)
        content_tag(name_tag, name, class: 'testimonial_name' )
      end

      def quote_markup(quote, name, job_title, company, website)
        c = cite_markup(name, job_title, company, website)
        if quote_includes_cite
          content_tag(quote_tag) {
            quote.html_safe << c
          }
        else
          content_tag(quote_tag, quote.html_safe) << c
        end
      end

      def cite_markup(name, job_title, company, website)
        #        combine job job_title, company, website (all optional)
        #        from original refinery-testimonial, restored to life
        citation = [content_tag(:b, name), job_title,  website_or_company(company, website) ].reject(&:blank?).join(", ").sub(/,\s/, ": ")
        content_tag(cite_tag, citation.html_safe)
      end

      def website_or_company(company, website)
        link = content_tag(:a, company.blank? ? website : company, href: website)
        website.blank? ? company : link
      end

      def html_from_fallback(can_use_fallback)
        fallback_html if fallback_html.present? && can_use_fallback
      end

    end
  end
end
