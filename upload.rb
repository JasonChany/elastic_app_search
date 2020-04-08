require 'elastic-app-search'
require 'json'
require 'progress_bar'


API_ENDPOINT = 'http://localhost:3002/api/as/v1/'
API_KEY = 'private-ys6esbkp127i2gseyhv9tr1n'
ENGINE_NAME = 'video-games'

client = Elastic::AppSearch::Client.new( :api_key => API_KEY, :api_endpoint => API_ENDPOINT)
file = File.read('./games-array.json')
data = JSON.parse(file)
bar = ProgressBar.new(data.count / 100)

data.each_slice(100) do |slice|
	client.index_documents(ENGINE_NAME, slice)
	bar.increment!
end