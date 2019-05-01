module ApplicationHelper
  def render_form_field_errors(errors)
    return if errors.blank?

    content_tag(:div, class: "error-list") do
      errors.join('. ').html_safe
    end
  end
end
