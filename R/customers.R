# --------------------------------------------------
# Customers
# --------------------------------------------------

#' Create a Customer.
#'
#' Create a new customer and add information to them.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args an optional list which can contain
#' \strong{card}, \strong{account_balance}, \strong{coupon}, \strong{description},
#' \strong{metadata}, \strong{email}, \strong{plan}, \strong{quantity},
#' \strong{trial_end}
#'
#' @return A data frame with the new Customer info if successful.
#' @export
#'
stripe_create_customer <- function(api_key, args=NULL) {
    args <- .card(args)
    args <- .metadata(args)
    link <- "https://api.stripe.com/v1/customers"
    .post(api_key, link, args)
}

#' Retrieve a Customer.
#'
#' Retrieve the information about a specific customer using their id.
#'
#' @param api_key Your Stripe API Key
#'
#' @param customer_id The id of the customer you want to retrieve
#'
#' @return A data frame with the Customer info if successful.
#' @export
#'
stripe_retrieve_customer <- function(api_key, customer_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id)
    .get(api_key, link)
}

#' Update a Customer.
#'
#' Update the customer's information or add a new card to a customer.
#'
#' @param api_key Your Stripe API Key
#'
#' @param customer_id The id of the customer you want to update
#'
#' @param args an optional list which can contain
#' \strong{card}, \strong{account_balance}, \strong{coupon}, \strong{description},
#' \strong{metadata}, \strong{email}, \strong{default_card},
#'
#' @return A data frame with the updated Customer info if successful.
#' @export
#'
stripe_update_customer <- function(api_key, customer_id, args) {
    args <- .card(args)
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/customers/", customer_id)
    .post(api_key, link, args)
}

#' Delete a Customer.
#'
#' Remove a customer from your stripe account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param customer_id The id of the customer you want to delete
#'
#' @return A data frame empty if successful.
#' @export
#'
stripe_delete_customer <- function(api_key, customer_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id)
    .delete(api_key, link)
}

#' Retrieve a list of Customer.
#'
#' Retrieve a list of all customers.  Defaults up to 10.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args an optional list of arguments. Can include
#' \strong{created}, \strong{ending_before}, \strong{limit}
#' \strong{starting_after}. Limit defaults at 10.
#'
#' @return A data frame with the Customer list if successful.
#' @export
#'
stripe_list_customers <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/customers", args)
    .get(api_key, link)
}
