# --------------------------------------------------
# Subscriptions
# --------------------------------------------------

#' Create a Subscription
#'
#' @param api_key Your Stripe API Key
#' @param customer_id The customer id you want to add a subscription to.
#' @param args A list which must contain \strong{plan}.
#' It can also contain \strong{trial_end}, \strong{metadata},
#' \strong{coupon}, \strong{card}, \strong{application_fee_percent},
#' and \strong{quantity}
#' @export
#' @return A data frame with the new subscription info if successful.
stripe_create_subscription <- function(api_key, customer_id, args) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions")
    .post(api_key, link, args)
}

#' Retrieve a Subscription
#'
#' @param api_key Your Stripe API Key
#' @param customer_id The id of the customer with the subscription.
#' @param subscription_id The id of the subscription you want to retrieve
#' @export
#' @return A data frame with the subscription info if successful.
stripe_retrieve_subscription <- function(api_key, customer_id, subscription_id) {
    link <- paste0("https://api.stripe.com/v1/customers/", customer_id, "/subscriptions/", subscription_id)
    .get(api_key, link)
}

#' Update a subscription.
#'
#' @param api_key Your Stripe API Key
#' @param customer_id The id of the customer with the subscription.
#' @param subscription_id The id of the subscription you want to update.
#' @param args A list can contain \strong{plan}, 
#' \strong{coupon}, \strong{prorate}, \strong{trial_end},
#' \strong{application_fee_percent}, \strong{quantity}, 
#' \strong{metadata}, and \strong{card}
#' @export
#' @return A data frame with the updated subscription info if successful.
stripe_update_subscription <- function(api_key, customer_id, subscription_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions/",
                   subscription_id)
    .post(api_key, link, args)
}

#' Delete a subscription on Stripe.
#'
#' @param api_key Your Stripe API Key
#' @param customer_id The id of the customer with the subscription.
#' @param subscription_id The id for the subscription you want to delete
#' @export
#' @return A data frame with nothing if successful.
stripe_delete_subscription <- function(api_key, customer_id, subscription_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions/",
                   subscription_id)
    .delete(api_key, link)
}

#' List Subscriptions
#'
#' @param api_key Your Stripe API Key
#' @param customer_id The id of the customer with the subscriptions.
#' @param args an optional list that can contain
#' /strong{ending_before}, \strong{limit}, \strong{starting_after}
#' @export
#' @return A data frame with subscriptions information
stripe_list_subscriptions <- function(api_key, customer_id, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions", args)
    .get(api_key, link)
}
