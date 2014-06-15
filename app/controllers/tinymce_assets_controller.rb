class TinymceAssetsController < ApplicationController
  include ApplicationHelper
  before_action :check_admin

  # def create
  #   ftp = Net::FTP.new('codebykids.com')
  #   ftp.passive = true
  #   ftp.login 'codeforkids', 'CodeForKidsStaple!'

  #   file = params[:file]
  #   ftp.storbinary("STOR " + file.original_filename, StringIO.new(file.read), Net::FTP::DEFAULT_BLOCKSIZE)

  #   ftp.close

  #   image = 'http://codeforkids.codebykids.com/' + file.original_filename

  #   render json: { image: { url: view_context.image_url(image) } }, content_type: 'text/html'
  # end

  def create
    file = params[:file]
    @image = Image.new
    @image.update_attribute :image, params[:file]

    # tinymce_uploader = TinymceUploader.new
    # result =  tinymce_uploader.store!(File.open(file))
    # puts result.inspect + "\n\n"
    # uploaded_file = tinymce_uploader.retrieve_from_store!(file.original_filename)
    # puts "uploaded #{uploaded_file.inspect}"
    render json: { image: { url: @image.image.url } }, content_type: 'text/html'
  end
end
