# --------------------------------------------------
# Discounts
# --------------------------------------------------

#' Delete a customer discount.
#'
#' @param api_key Your Stripe API Key
#' @param customer_id The identifier of the customer who
#' has the discount to be deleted.
#' @export
#' @return Returns a data frame deleted true if if succeeded.
stripe_delete_customer_discount <- function(api_key, customer_id) {
    link <- paste0("https://api.stripe.com/v1/customers/", customer_id, "/discount")
    .delete(api_key, link)
}

#' Delete a subscription discount.
#'
#' @param api_key Your Stripe API Key
#' @param customer_id The identifier of the customer who
#' has the discount to be deleted.
#' @param subscription_id The identifier of the subscription.
#' @export
#' @return Returns a data frame deleted true if if succeeded.
stripe_delete_subscription_discount <- function(api_key, customer_id, subscription_id) {
    link <- paste0("https://api.stripe.com/v1/customers/", customer_id,
                   "/subscriptions/", subscription_id, "/discount")
    .delete(api_key, link)
}
