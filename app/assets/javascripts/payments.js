jQuery(function($) {
  $('#new_user').submit(function(event) {
    var $form = $(this);
    $form.find('.btn').prop('disabled', true);
    Stripe.createToken($form, stripeResponseHandler);
    return false;
  });

  var stripeResponseHandler = function(status, response) {
    var $form = $('#new_user');

    if (response.error) {
      $form.find('.payments-errors').text(response.error.message);
      $form.find('.btn').prop('disabled', false);
    } else {
      var token = response['id'];
      $form.append("<input type='hidden' name='stripeToken' value='" + token + "'/>");
      $form.get(0).submit();
      }
    }

});
