# --------------------------------------------------
# Invoice Items
# --------------------------------------------------
stripe_create_invoice_item <- function(api_key, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/invoiceitems")
    .post(api_key, link, args)
}

stripe_retrieve_invoice_item <- function(api_key, item_id) {
    link <- paste0("https://api.stripe.com/v1/invoiceitems/", item_id)
    .get(api_key, link)
}

stripe_update_invoice_item <- function(api_key, item_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/invoiceitems/", item_id)
    .post(api_key, link, args)
}

stripe_delete_invoice_item <- function(api_key, item_id) {
    link <- paste0("https://api.stripe.com/v1/invoiceitems/", item_id)
    .delete(api_key, link)
}

stripe_list_invoice_items <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/invoiceitems", args)
    .get(api_key, link)
}
