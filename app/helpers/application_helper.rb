module ApplicationHelper

	def error_messages_for(*params)
		options = params.last.is_a?(Hash) ? params.pop.symbolize_keys : {}
		objects = params.collect {|object_name| instance_variable_get("@#{object_name}") }.compact
	     count   = objects.inject(0) {|sum, object| sum + object.errors.count }
	     unless count.zero?
	       html = {}
	       [:id, :class].each do |key|
	         if options.include?(key)
	           value = options[key]
	           html[key] = value unless value.blank?
	         else
	           html[key] = 'errorExplanation'
	         end
	       end
	       if count == 1
	       		error_msg = "was an error"
	       		thesethis = "field has a problem (it has"
       	else 
       			error_msg = "were #{pluralize(count, 'error')}"
       			thesethis = "fields have problems (they have"
     		end
	       header_message = "Oops, looks like there #{error_msg} while saving. Have another go..."
	       error_messages = objects.map {|object| object.errors.full_messages.map {|msg| content_tag(:li, msg) } }
	       content_tag(:div,
	         content_tag(options[:header_tag] || :h2, header_message) <<
	           content_tag(:p, 'The following '+ thesethis + ' also been highlighed for your viewing pleasure)') <<
	           content_tag(:ul, error_messages),
	         html
	       )
	     else
	       ''
	     end
	end

end
