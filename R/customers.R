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
#' \describe{
#'    \item{account_balance}{\emph{optional} In cents starting account balance. Positive means
#'                           amount to be paid off. Negative is credit used towards charge.}
#'    \item{card}{\emph{optional} Either token from Stripe.js or card details.}
#'    \item{description}{\emph{optional} The description of the transfer.}
#'    \item{metadata}{\emph{optional} A list which can contain anything to further describe.}
#'    \item{coupon}{\emph{optional} A coupon code for a discount applied on all charges.}
#'    \item{email}{\emph{optional} Customer's email address.}
#'    \item{plan}{\emph{optional} A plan id to subscribe the customer to.}
#'    \item{quantity}{\emph{optional} The amount of plans to subscribe them to.} 
#'    \item{trial_end}{\emph{optional} Timestamp for end of trial period. Overrides plan trial.}
#' }
#'
#' @return A data frame with the new Customer info if successful.
#'
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
#'
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
#' @param args an optional list which can contain:
#' \describe{
#'    \item{account_balance}{\emph{optional} In cents starting account balance. Positive means
#'                           amount to be paid off. Negative is credit used towards charge.}
#'    \item{card}{\emph{optional} Either token from Stripe.js or card details.}
#'    \item{description}{\emph{optional} The description of the transfer.}
#'    \item{default_card}{\emph{optional} The id of a card to use as default.}
#'    \item{metadata}{\emph{optional} A list which can contain anything to further describe.}
#'    \item{coupon}{\emph{optional} A coupon code for a discount applied on all charges.}
#'    \item{email}{\emph{optional} Customer's email address.}
#' }
#'
#' @return A data frame with the updated Customer info if successful.
#'
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
#'
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
#' \describe{
#'    \item{ending_before}{\emph{optional:} An object id which will show objects before}
#'    \item{limit}{\emph{optional:} A number 1 to 100 to limit the items.  Default is 10}
#'    \item{starting_after}{\emph{optional:} An object id which will show objects starting here}
#' }
#'
#' @return A data frame with the Customer list if successful.
#'
#' @export
#'
stripe_list_customers <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/customers", args)
    .get(api_key, link)
}
