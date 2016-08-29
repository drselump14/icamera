require 'tempfile'
class Pictures
  attr_reader :file
  def get_file(file_uri)
    params = { name: 'camera.getImage',
               parameters: {
      fileUri: file_uri,
      _type: 'image'
    }}
    binary = Request.new(params).start
    @file = Tempfile.new(['preview','.jpeg'], Rails.root + 'tmp/pictures/')
    @file.binmode
    @file.write(binary)
    @file.flush
    FileUtils.cp(@file.path, Rails.root + 'app/assets/images/preview.jpeg')
  end
end
