# --------------------------------------------------
# Invoice Items
# --------------------------------------------------

#' Create an Invoice Item.
#'
#' Create a new invoice item with amount and attach it to a subscription or invoice. 
#'
#' @param api_key Your Stripe API Key
#'
#' @param args A list which must contain \strong{amount} and 
#' \strong{currency}.
#' It can also contain \strong{description}, \strong{metadata},
#' \strong{invoice}, \strong{subscription}.  If you leave invoice blank
#' it will be added to the next upcoming invoice
#'
#' @return A data frame with the new invoice item if successful.
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
#' @param args Can include \strong{amount}, \strong{description}
#' and/or \strong{metadata}
#'
#' @return A data frame with the updated invoice item if successful.
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
#' @param args A list which must contain \strong{created},
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
