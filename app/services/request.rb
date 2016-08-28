class Request
  require 'net/http'
  URL='http://192.168.1.1/'

  attr_reader :params, :req, :response

  def initialize(params)
    @params = params
    @uri = URI(URL + 'osc/commands/execute')
    @req = Net::HTTP::Post.new(@uri, {'Content-Type' => 'application/json'})
    @req.body = params.deep_stringify_keys.to_json
  end

  def start
    res = Net::HTTP.new(@uri.hostname, @uri.port).start do |http|
      http.request(@req)
    end
    JSON.parse(res.body).deep_symbolize_keys
  end

end
