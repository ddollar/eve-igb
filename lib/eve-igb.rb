Mime::Type.register "text/x-eve-igb", :eve

ActionController::MimeResponds::Responder.class_eval do
  def initialize_with_eve_minibrowser(controller)
    initialize_without_eve_minibrowser(controller)
    if controller.request.user_agent.match(/^EVE-minibrowser/)
      @mime_type_priority = [ Mime::Type.lookup('text/x-eve-igb') ]
    end
  end
  alias_method_chain :initialize, :eve_minibrowser
end

ActionController::Base.class_eval do
  def eve_trust_required
    if request.cgi.env_table['HTTP_EVE_TRUSTED'] != 'yes'
      trust_uri = "http://#{request.env['HTTP_HOST']}/"
      headers['eve.trustme'] = "#{trust_uri}::This page requires trust to view."
      return false
    end
  end
end