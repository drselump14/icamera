class Camera
  require 'net/http'
  URL='http://192.168.1.1/'

  def start_session
    uri = URI(URL + 'osc/commands/execute')
    req = Net::HTTP::Post.new(uri, {'Content-Type' => 'application/json'})
    params = { name: 'camera.startSession', parameters: {} }
    req.body = params.deep_stringify_keys.to_json
    res = Net::HTTP.new(uri.hostname, uri.port).start do |http|
      http.request(req)
    end
    response = JSON.parse(res.body).deep_symbolize_keys
    p response
    if response[:state] == 'done'
      response[:results][:sessionId]
    else
      nil
    end
  end

  def take_picture
    uri = URI(URL + 'osc/commands/execute')
    req = Net::HTTP::Post.new(uri, {'Content-Type' => 'application/json'})
    params = { name: 'camera.takePicture',
               parameters: {
                  sessionId: start_session
               }
              }
    req.body = params.deep_stringify_keys.to_json
    res = Net::HTTP.new(uri.hostname, uri.port).start do |http|
      http.request(req)
    end
    response = JSON.parse(res.body).deep_symbolize_keys
    response
  end

  private
    def uri
      URI(URL + 'osc/commands/execute')
    end

    def req
      Net::HTTP::Post.new(uri, {'Content-Type' => 'application/json'})
    end
end
