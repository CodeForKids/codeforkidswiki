namespace :swifttype do

  task :index_posts => :environment do
    if ENV['SWIFTYPE_API_KEY'].blank?
      abort("SWIFTYPE_API_KEY not set")
    end

    if ENV['SWIFTYPE_ENGINE_SLUG'].blank?
      abort("SWIFTYPE_ENGINE_SLUG not set")
    end

    client = Swiftype::Client.new

    Page.find_in_batches(:batch_size => 100) do |pages|
      documents = pages.map do |page|
        url = Rails.application.routes.url_helpers.page_url(page.category.handle, page.handle)
        {:external_id => page.id,
         :fields => [{:name => 'title', :value => page.title, :type => 'string'},
                     {:name => 'category', :value => page.category.name, :type => 'string'},
                     {:name => 'content', :value => page.content, :type => 'text'},
                     {:name => 'url', :value => url, :type => 'enum'},
                     {:name => 'updated_at', :value => page.last_updated, :type => 'date'}]}
      end

      results = client.create_or_update_documents(ENV['SWIFTYPE_ENGINE_SLUG'], Page.model_name.name.downcase, documents)

      results.each_with_index do |result, index|
        puts "Could not create #{posts[index].title} (##{posts[index].id})" if result == false
      end
    end
  end

end
