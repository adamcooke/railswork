ActionView::Base.send :include, AtechUtilsHelper
ActiveRecord::Base.send :extend, PermalinkFu

ActionView::Base.field_error_proc = Proc.new {|html_tag, instance|  %(<span class="fieldWithErrors">#{html_tag}</span>)}

datetime_formats = {:shortdate => "%d %b",
	:date_with_day => "%A, %d %B",
	:fulldate => "%A, %d %B %Y",
	:full => "%e %B %Y",
	:ddmmyyyy => "%d/%m/%Y",
	:ddmmyy => "%d/%m/%y"}

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!datetime_formats
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!datetime_formats

