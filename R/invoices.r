# --------------------------------------------------
# Invoices
# --------------------------------------------------

#' Create an Invoice. 
#'
#' @param api_key Your Stripe API Key
#' @param args A list which must contain \strong{customer}
#' It can also contain \strong{description}, \strong{metadata},
#' \strong{application_fee}, \strong{subscription},
#' and \strong{statement_description}
#' @export
#' @return A data frame with the new invoice if successful.
stripe_create_invoice <- function(api_key, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/invoices")
    .post(api_key, link, args)
}

#' Retrieve an Invoice.
#'
#' @param api_key Your Stripe API Key
#' @param invoice_id The invoice id you want to retrieve
#' @export
#' @return A data frame with the invoice if successful.
stripe_retrieve_invoice <- function(api_key, invoice_id) {
    link <- paste0("https://api.stripe.com/v1/invoices/", invoice_id)
    .get(api_key, link)
}

#' Retrieve Invoice Items.
#'
#' @param api_key Your Stripe API Key
#' @param invoice_id The invoice id with the items you want to retrieve
#' @param args An optional list that can include \strong{limit}, \strong{customer}
#' \strong{ending_before}, \strong{subscription}, and/or \strong{starting_after}
#' @export
#' @return A data frame with the invoice items if successful.
stripe_retrieve_invoice_line_items <- function(api_key, invoice_id, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/invoices/",
                              invoice_id, "/lines", args)
    .get(api_key, link)
}

#' Update an Invoice.
#'
#' @param api_key Your Stripe API Key
#' @param invoice_id The invoice id you want to update
#' @param args Can include \strong{application_fee}, \strong{description}
#' \strong{closed}, \strong{forgiven}, \strong{statement_description},
#' and/or \strong{metadata}
#' @export
#' @return A data frame with the updated invoice if successful.
stripe_update_invoice <- function(api_key, invoice_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/invoices/", invoice_id)
    .post(api_key, link, args)
}

#' Pay an Invoice.
#'
#' @param api_key Your Stripe API Key
#' @param invoice_id The invoice id you want to pay
#' @export
#' @return A data frame with the invoice if successful.
stripe_pay_invoice <- function(api_key, invoice_id) {
    link <- paste0("https://api.stripe.com/v1/invoices/", invoice_id, "/pay")
    .post(api_key, link)
}

#' List Invoices.
#'
#' @param api_key Your Stripe API Key
#' @param args An optional list that can include \strong{customer},
#' \strong{date}, \strong{ending_before}, \strong{limit}, \strong{starting_after}
#' @export
#' @return A data frame with the invoices if successful.
stripe_list_invoices <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/invoices", args)
    .get(api_key, link)
}

#' Retrieve upcoming customer's invoice.
#'
#' @param api_key Your Stripe API Key
#' @param customer_id The customer id that you want the upcoming invoice
#' @export
#' @return A data frame with the upcoming invoice if successful.
stripe_upcoming_customer_invoice <- function(api_key, customer_id) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/invoices/upcoming?customer=", customer_id)
    .get(api_key, link)
}
