# --------------------------------------------------
# Coupons
# --------------------------------------------------
stripe_create_coupon <- function(api_key, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/coupons")
    .post(api_key, link, args)
}

stripe_retrieve_coupon <- function(api_key, coupon_id) {
    paste0("https://api.stripe.com/v1/coupons/", coupon_id)
    .get(api_key, link)
}

stripe_update_coupon <- function(api_key, coupon_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/coupons/", coupon_id)
    .post(api_key, link, args)
}

stripe_delete_coupon <- function(api_key, coupon_id) {
    link <- paste0("https://api.stripe.com/v1/coupons/", coupon_id)
    .delete(api_key, link)
}

stripe_list_coupons <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/coupons", args)
    .get(api_key, link)
}
