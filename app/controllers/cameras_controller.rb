class CamerasController < ApplicationController
  def index
    camera = Camera.new
    file_uri = camera.take_picture
    picture = Pictures.new
    picture.get_file(file_uri)
  end
end
