class SearchController < ApplicationController
  def index
    @search = params[:search]

    if @search.present?
      @products = Product.search(@search).page(params[:page]).
        per(Settings.products.record_per_page)
    else
      flash.now[:warning] = t "search.empty_search"
    end
  end
end
