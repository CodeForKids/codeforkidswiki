class PageRepository
  PAGES_PER_PAGE = 8

  attr_accessor :params

  def initialize(params)
    self.params = params
  end

  def search
    query = params[:query]
    model.tire.search(load: true, page: params[:page], per_page: PAGES_PER_PAGE) do
      query { string query, default_operator: "AND" } if query.present?
      filter :range, published_at: { lte: Time.zone.now }
      sort { by :published_at, "desc" } if query.blank?
    end
  end

  protected

  def model
    Page
  end
end
