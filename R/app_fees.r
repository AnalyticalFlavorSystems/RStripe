# --------------------------------------------------
# Application Fees
# --------------------------------------------------
stripe_retrieve_app_fee <- function(api_key, app_fee_id) {
    link <- paste0("https://api.stripe.com/v1/application_fees/", app_fee_id)
    .get(api_key, link)
}

stripe_list_app_fees <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/application_fees", args)
    .get(api_key, link)
}
