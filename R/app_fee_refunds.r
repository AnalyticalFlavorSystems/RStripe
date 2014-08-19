
# --------------------------------------------------
# Application Fee Refunds
# --------------------------------------------------
stripe_create_app_fee_refund <- function(api_key, app_fee_id, args=NULL) {
    link <- paste0("https://api.stripe.com/v1/application_fees/", app_fee_id, "/refunds")
    .post(api_key, link, args)
}

stripe_retrieve_app_fee_refund <- function(api_key, app_fee_id, refund_id) {
    link <- paste0("https://api.stripe.com/v1/application_fees/",
                              app_fee_id, "/refunds/", refund_id)
    .get(api_key, link)
}

stripe_update_app_fee_refund <- function(api_key, app_fee_id, refund_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/application_fees/",
                   app_fee_id, "/refunds/", refund_id)
    .post(api_key, link, args)
}

stripe_list_application_fee_refunds <- function(api_key, app_fee_id, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/application-fees/",app_fee_id, "/refunds", args)
    .get(api_key, link)
}
