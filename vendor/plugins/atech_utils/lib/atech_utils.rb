module AtechUtils
	
	def invalid_route
		render_error(404)
	end
	
	protected
	# Render a nice looking error
	def render_error(code, status = '')
		
		case code
			when 404
				file_to_render = "error_404.rhtml"
				status_to_send = "404 Not Found"
			when 403
				file_to_render = "error_403.rhtml"
				status_to_send = "403 Forbidden"
			else
				@code = code
				file_to_render = "error.rhtml"
				status_to_send = status ||= "500 Errror"
		end
		
		if request.xhr?
			render :text => status_to_send, :status => status_to_send
		else
			if File.exists?("#{RAILS_ROOT}/app/views/shared/#{file_to_render}")
		    render :file => "#{RAILS_ROOT}/app/views/shared/#{file_to_render}", :status => status_to_send
		  else
			  render :file => "#{RAILS_ROOT}/vendor/plugins/atech_utils/views/#{file_to_render}", :status => status_to_send
		  end
		end
		
	end
	
	def render_generic_login
		render :file => "#{RAILS_ROOT}/vendor/plugins/atech_utils/views/generic_login.rhtml"
	end
	
	module ErrorHandling
		
	  def rescue_action_in_public(e)
		  case e when ActiveRecord::RecordNotFound
		    render_error(404, "404 Not Found")
		  else
		  	super
		  end
		end
	end


end