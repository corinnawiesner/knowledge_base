class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def cache_key
    super + '-' + Globalize.locale.to_s
  end
end
