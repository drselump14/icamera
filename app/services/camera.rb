class Camera
  def start_session
    params = { name: 'camera.startSession', parameters: {} }
    res = Request.new(params).start
    if res[:state] == 'done'
      res[:results][:sessionId]
    else
      nil
    end
  end

  def take_picture
    params = { name: 'camera.takePicture',
               parameters: {
                  sessionId: start_session
               }
              }
    res = Request.new(params).start
    @file_id = res[:id].to_s
    get_file_uri = Request.new( {id: @file_id}, 'osc/commands/status')
    begin
      sleep(3)
      get_file_uri.start
      p get_file_uri
    end while get_file_uri.res[:state] != 'done'
    get_file_uri.res[:results][:fileUri]
  end
end
