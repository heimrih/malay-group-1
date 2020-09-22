class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :switch_locale

  helper_method :mailbox, :conversation

  def default_url_options
    {locale: I18n.locale}
  end

  private

  def switch_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find_by id: params[:id]
  end
end
