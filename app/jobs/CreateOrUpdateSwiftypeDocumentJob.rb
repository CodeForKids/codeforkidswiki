class CreateOrUpdateSwiftypeDocumentJob < Struct.new(:page_id)
  def perform
    page = Page.find(page_id)
    url = Rails.application.routes.url_helpers.page_path(page.category.handle, page.handle)
    client = Swiftype::Client.new
    client.create_or_update_document(ENV['SWIFTYPE_ENGINE_SLUG'],
                                      Page.model_name.name.downcase,
                                     {:external_id => page.id,
                                       :fields => [{:name => 'title', :value => page.title, :type => 'string'},
                                                   {:name => 'category', :value => page.category.name, :type => 'string'},
                                                   {:name => 'content', :value => page.content, :type => 'text'},
                                                   {:name => 'url', :value => url, :type => 'enum'},
                                                   {:name => 'updated_at', :value => page.last_updated, :type => 'date'}]})
  end
end
