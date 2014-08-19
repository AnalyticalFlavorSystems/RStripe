# --------------------------------------------------
# Invoices
# --------------------------------------------------
stripe_create_invoice <- function(api_key, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/invoices")
    .post(api_key, link, args)
}

stripe_retrieve_invoice <- function(api_key, invoice_id) {
    link <- paste0("https://api.stripe.com/v1/invoices/", invoice_id)
    .get(api_key, link)
}

stripe_retrieve_invoice_line_items <- function(api_key, invoice_id, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/invoices/",
                              invoice_id, "/lines", args)
    .get(api_key, link)
}

stripe_update_invoice <- function(api_key, invoice_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/invoices/", invoice_id)
    .post(api_key, link, args)
}

stripe_pay_invoice <- function(api_key, invoice_id) {
    link <- paste0("https://api.stripe.com/v1/invoices/", invoice_id, "/pay")
    .post(api_key, link)
}

stripe_list_invoices <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/invoices", args)
    .get(api_key, link)
}

stripe_upcoming_customer_invoice <- function(api_key, customer_id) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/invoices/upcoming?customer=", customer_id)
    .get(api_key, link)
}
