class DeleteSwiftypeDocumentJob < Struct.new(:page_id)
  def perform
    client = Swiftype::Client.new
    client.destroy_document(ENV['SWIFTYPE_ENGINE_SLUG'], Page.model_name.downcase, page_id)
  end
end
