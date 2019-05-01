class ApplicationController < ActionController::Base
  around_action :catch_not_found

  private

    def catch_not_found
      yield
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url, :flash => { :error => t("global.record_not_found") }
    end
end
