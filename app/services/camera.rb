class Camera
  def start_session
    params = { name: 'camera.startSession', parameters: {} }
    response = Request.new(params).start
    if response[:state] == 'done'
      response[:results][:sessionId]
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
    Request.new(params).start
  end
end
