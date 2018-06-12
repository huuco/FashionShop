module ApplicationHelper
  def index_for_list object, counter
    ((object.current_page - 1)  * object.limit_value) + counter + 1
  end

  def currency price
    number_to_currency(price, unit: t("currency"), separator: ",")
  end
  def datepicker_input form, field
    content_tag :td, :data => {:provide => 'datepicker', 'date-format' => 'yyyy-mm-dd', 'date-autoclose' => 'true'} do
      form.text_field field, class: 'form-control', placeholder: 'YYYY-MM-DD'
    end
  end
end
