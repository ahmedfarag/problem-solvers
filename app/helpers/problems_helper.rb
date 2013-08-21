module ProblemsHelper
	require 'open-uri'

	def get_name_of(url, oj)
		url = URI.parse(url)
		response = ""
		open(url) do |http|
	  		response = http.read
	  	end

		if(oj == "SPOJ")
			  match = /<h1>([^<]+)<\/h1>/.match(response)
			  match != nil ? match[1] : "temp"
		elsif oj == "Live Archive"
			match = /<h3>([^<]+)<\/h3>/.match(response)
			match != nil ? match[1] : "temp"
		elsif oj == "UVA"
			match = /<td>[^<]*<h3>([^<]+)<\/h3>[^<]*<\/td>/.match(response)
			match != nil ? match[1] : "temp"
		elsif oj == "Code Forces"
			match = /<div class="header"><div class="title">([^<]+)<\/div>/.match(response)
			match != nil ? match[1] : "temp"
		end

	end
end
