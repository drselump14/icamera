class Request
  require 'net/http'
  URL='http://192.168.1.1/'

  attr_reader :params, :req, :res

  def initialize(params, command_uri = 'osc/commands/execute')
    @params = params
    @uri = URI(URL + command_uri)
    @req = Net::HTTP::Post.new(@uri, {'Content-Type' => 'application/json'})
    @req.body = params.deep_stringify_keys.to_json
  end

  def start
    p 'start request'
    p @req.body
    res = Net::HTTP.new(@uri.hostname, @uri.port).start do |http|
      http.request(@req)
    end
    @res = JSON.parse(res.body).deep_symbolize_keys
  end

end
