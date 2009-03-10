xml.instruct!
xml.rss(:version => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
  xml.channel do
    xml.title "RailsWork - #{params[:category].capitalize} jobs"
    xml.description  "Latest job postings at RailsWork.com"
    xml.link home_url
    xml.language "en-gb"
    
   
    for job in @jobs
      xml.item do
        xml.pubDate job.created_at.rfc822
        xml.title "#{job.company_name} are looking for a #{job.title} in #{job.location}"
        xml.author job.company_name
        xml.link job_url(job)
        xml.link job_url(job)
        xml.description job.description
      end
    end
  end
end