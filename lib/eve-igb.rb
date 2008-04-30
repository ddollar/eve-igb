ActionController::MimeResponds::Responder.send :alias_method, :old_initialize, :initialize
ActionController::MimeResponds::Responder.class_eval do
  def initialize(block_binding)
    old_initialize(block_binding)
    user_agent = eval "request.env['HTTP_USER_AGENT']", block_binding
    if user_agent.match(/^EVE-minibrowser/)
      @mime_type_priority = [ Mime::Type.lookup('text/x-eve-igb') ]
    end
  end
end

Mime::Type.register "text/x-eve-igb", :eve
ActionController::MimeResponds::Responder::DEFAULT_BLOCKS[:eve] = %(Proc.new { render :action => "\#{action_name}.reve", :content_type => Mime::HTML })

ActionController::Base.class_eval do
  def eve_trust_required
    if request.cgi.env_table['HTTP_EVE_TRUSTED'] != 'yes'
      trust_uri = "http://#{request.env['HTTP_HOST']}/"
      headers['eve.trustme'] = "#{trust_uri}::This page requires trust to view."
      return false
    end
  end
end



