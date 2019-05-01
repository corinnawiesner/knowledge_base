class BaseForm
  include ActiveModel::Model

  def save
    if valid?
      persist!
    else
      false
    end
  end

  private

    def persist!
      raise "implement #{__method__} in sub class"
    end
end
