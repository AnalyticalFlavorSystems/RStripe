# --------------------------------------------------
# Invoice Items
# --------------------------------------------------

#' Create an Invoice Item.
#'
#' Create a new invoice item with amount and attach it to a subscription or invoice. 
#' If you leave invoice blank it will be added to the next upcoming invoice.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args A list which must contain 
#' \describe{
#'    \item{amount}{\strong{required} In cents how much for item.}
#'    \item{currency}{\strong{required} 3-letter ISO code for currency.}
#'    \item{description}{\emph{optional} A string to attach to item for easy tracking.}
#'    \item{metadata{\emph{optional} key/value pairs that you can attach to an invoice item.}
#'    \item{invoice}{\emph{optional} Add to this invoice or leave blank for next invoice.}
#'    \item{subscription}{\emph{optional} Add to a specific subscriptions invoice.}
#' }
#'
#' @return A data frame with the new invoice item if successful.
#'
#' @export
#'
stripe_create_invoice_item <- function(api_key, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/invoiceitems")
    .post(api_key, link, args)
}

#' Retrieve an Invoice Item.
#'
#' Retrieve a specific invoice item's info using it's id.
#'
#' @param api_key Your Stripe API Key
#'
#' @param item_id The invoice item id you want to retrieve
#'
#' @return A data frame with the invoice item if successful.
#'
#' @export
#'
stripe_retrieve_invoice_item <- function(api_key, item_id) {
    link <- paste0("https://api.stripe.com/v1/invoiceitems/", item_id)
    .get(api_key, link)
}

#' Update an Invoice Item.
#'
#' Update the information or amount of an invoice item.
#'
#' @param api_key Your Stripe API Key
#'
#' @param item_id The invoice item id you want to update
#'
#' @param args Can include 
#' \describe{
#'    \item{amount}{\emph{optional} Amount in cents for item.}
#'    \item{description}{\emph{optional} A string to attach to item for easy tracking.}
#'    \item{metadata{\emph{optional} key/value pairs that you can attach to an invoice item.}
#' }
#'
#' @return A data frame with the updated invoice item if successful.
#'
#' @export
#'
stripe_update_invoice_item <- function(api_key, item_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/invoiceitems/", item_id)
    .post(api_key, link, args)
}

#' Delete an Invoice Item.
#'
#' Remove an invoice item from an invoice.
#'
#' @param api_key Your Stripe API Key
#'
#' @param item_id The invoice item id you want to delete
#'
#' @return A data frame without errors if successful.
#'
#' @export
#'
stripe_delete_invoice_item <- function(api_key, item_id) {
    link <- paste0("https://api.stripe.com/v1/invoiceitems/", item_id)
    .delete(api_key, link)
}

#' List all Invoice Item.
#'
#' List all the invoice items in your account.  This can be limited by customer, date, etc.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args A list which can contain:
#' \describe{
#'    \item{ending_before}{\emph{optional:} An object id which will show objects before}
#'    \item{customer}{\emph{optional:} The customer ID whose invoice items to return}
#'    \item{limit}{\emph{optional:} A number 1 to 100 to limit the items.  Default is 10}
#'    \item{starting_after}{\emph{optional:} An object id which will show objects starting here}
#' }
#' \strong{customer}, \strong{ending_before}, \strong{limit}
#' and \strong{starting_after}
#'
#' @return A data frame with the the invoice items if successful.
#' @export
#'
stripe_list_invoice_items <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/invoiceitems", args)
    .get(api_key, link)
}
