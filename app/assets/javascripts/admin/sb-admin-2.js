jQuery(document).ready(function() {
  jQuery("#product_old_price").change(function() {
    caculator_price()
  });
  jQuery("#product_discount").change(function() {
    caculator_price();
  });

  function caculator_price() {
    var old_price = parseFloat(jQuery("#product_old_price").val());
    var discount = parseFloat(jQuery("#product_discount").val());
    if (discount>=0 && discount <= 100) {
      price = old_price * (100 - discount) / 100
      jQuery("#product_price").val(price);
    } else {
      alert(I18n.t("enter_again"));
      jQuery("#product_discount").val(0);
      caculator_price();
    }
  }

  jQuery(".active_category").click(function(){
    var active = $(this).val() == "true" ? 0 : 1;
    var url = $(this).attr("url");
    jQuery.ajax({
      url: url,
      type: "POST",
      data: {
        active: active
      },
      success: function (result){
        jQuery(".active_category_" + result.id).val(result.active);
      }
    });
  });
});
