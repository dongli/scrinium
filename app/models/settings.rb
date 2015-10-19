class Settings < Settingslogic
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env

  def self.smtp_settings_symbol_hash
    if Settings.smtp_settings.present?
      Settings.smtp_settings.to_hash.inject({}){|s, h| s.merge!(h[0].to_sym => h[1]) }
    end
  end

  load! unless Rails.env.production?
end
