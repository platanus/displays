class DisplayDecorator < Draper::Decorator
  delegate_all

  def present_url
    url.blank? ? h.setup_display_path(host_uuid) : url
  end
end
