module AtechUtilsHelper
		# Output the page title after changing >, | or - into a nice looking arrow
		def page_title(text = "")
			title = @page_title ? text + @page_title : text
			return title.gsub(/[|>-]/, "&#8250;") if @page_title
		end
		
		# Display flash messages in an appropriate div tag
		def flash_display
			flash.collect do |key,msg|
				content_tag :div, content_tag(:p, msg), :id => "flash-#{key}"
			end.join
		end
		
		# Convert minutes to a length in words
		def time_length_in_words(minutes)
			if minutes.blank? or minutes == 0
				return "no time"
			else
				hours = minutes / 60
				minutes = minutes - (hours * 60)
				rtn = []
				rtn << pluralize(hours, "hour") unless hours == 0
				rtn << pluralize(minutes, "minute") unless minutes == 0
				return rtn.join(", ")
			end
		end
		
end
