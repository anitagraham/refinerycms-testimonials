(Refinery.i18n_enabled? ? Refinery::I18n.frontend_locales : [:en]).each do |lang|
  I18n.locale = lang

  if defined?(Refinery::User)
    Refinery::User.all.each do |user|
      if user.plugins.where(:name => 'refinerycms-testimonials').blank?
        user.plugins.create(:name => 'refinerycms-testimonials',
                            :position => (user.plugins.maximum(:position) || -1) +1)
      end
    end
  end
end