module ApplicationHelper
  def index_for_list object, counter
    ((object.current_page - 1) * object.limit_value) + counter + 1
  end
end
