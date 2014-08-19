# --------------------------------------------------
# Refunds
# --------------------------------------------------
stripe_create_refund <- function(api_key, charge_id, args=NULL) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/charges/",charge_id, "/refunds")
    .post(api_key, link, args)
}

stripe_retrieve_refund <- function(api_key, charge_id, refund_id) {
    link <- paste0("https://api.stripe.com/v1/charges/",
                              charge_id, "/refunds/", refund_id)
    .get(api_key, link)
}

stripe_update_refund <- function(api_key, charge_id, refund_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/charges/",
                   charge_id, "/refunds/", refund_id)
    .post(api_key, link, args)
}

stripe_list_refunds <- function(api_key, charge_id, args = NULL) {
    args <- .convert_to_url(args)
    link <-paste0("https://api.stripe.com/v1/charges/", charge_id, "/refunds", args)
    .get(api_key, link)
}

