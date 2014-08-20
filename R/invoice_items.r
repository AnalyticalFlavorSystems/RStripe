# --------------------------------------------------
# Invoice Items
# --------------------------------------------------

#' Create an Invoice Item.
#'
#' @param api_key Your Stripe API Key
#' @param args A list which must contain \strong{amount} and 
#' \strong{currency}.
#' It can also contain \strong{description}, \strong{metadata},
#' \strong{invoice}, \strong{subscription}.  If you leave invoice blank
#' it will be added to the next upcoming invoice
#' @export
#' @return A data frame with the new invoice item if successful.
stripe_create_invoice_item <- function(api_key, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/invoiceitems")
    .post(api_key, link, args)
}

#' Retrieve an Invoice Item.
#'
#' @param api_key Your Stripe API Key
#' @param item_id The invoice item id you want to retrieve
#' @export
#' @return A data frame with the invoice item if successful.
stripe_retrieve_invoice_item <- function(api_key, item_id) {
    link <- paste0("https://api.stripe.com/v1/invoiceitems/", item_id)
    .get(api_key, link)
}

#' Update an Invoice Item.
#'
#' @param api_key Your Stripe API Key
#' @param item_id The invoice item id you want to update
#' @param args Can include \strong{amount}, \strong{description}
#' and/or \strong{metadata}
#' @export
#' @return A data frame with the updated invoice item if successful.
stripe_update_invoice_item <- function(api_key, item_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/invoiceitems/", item_id)
    .post(api_key, link, args)
}

#' Delete an Invoice Item.
#'
#' @param api_key Your Stripe API Key
#' @param item_id The invoice item id you want to delete
#' @export
#' @return A data frame without errors if successful.
stripe_delete_invoice_item <- function(api_key, item_id) {
    link <- paste0("https://api.stripe.com/v1/invoiceitems/", item_id)
    .delete(api_key, link)
}

#' List all Invoice Item.
#'
#' @param api_key Your Stripe API Key
#' @param args A list which must contain \strong{created},
#' \strong{customer}, \strong{ending_before}, \strong{limit}
#' and \strong{starting_after}
#' @export
#' @return A data frame with the the invoice items if successful.
stripe_list_invoice_items <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/invoiceitems", args)
    .get(api_key, link)
}
