module JobsHelper
  
  def c(data, default = '')

    content = data.blank? ? default : data
    
    content = sanitize(content)
    content = auto_link(content, :all, :rel => "external nofollow")
    
    return content
  end

end
