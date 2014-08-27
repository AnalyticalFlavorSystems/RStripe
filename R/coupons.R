# --------------------------------------------------
# Coupons
# --------------------------------------------------

#' Create a coupon.
#'
#' Create a new coupon in your account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args An list which must contain \strong{duration}.
#' It can also contain \strong{id}, \strong{amount_off},
#' \strong{currency} and more.  View \url{http://stripe.com/docs/api#create_coupon}.
#'
#' @examples stripe_create_coupon("sk_test_BQokikJOvBiI2HlWgH4olfQ2", 
#' list(amount_off=200, duration='forever'))
#'
#' @examples stripe_create_coupon("sk_test_BQokikJOvBiI2HlWgH4olfQ2", 
#' list(percent_off=25, duration='once'))
#'
#' @examples stripe_create_coupon("sk_test_BQokikJOvBiI2HlWgH4olfQ2", 
#' list(percent_off=25, duration='repeating', duration_in_months=3))
#'
#' @return A data frame with the coupon information
#' @export
#'
stripe_create_coupon <- function(api_key, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/coupons")
    .post(api_key, link, args)
}

#' Retrieve a coupon.
#'
#' Retrieve the information about a coupon.
#'
#' @param api_key Your Stripe API Key
#'
#' @param coupon_id The coupon you want to retrieve.
#'
#' @return A data frame with the coupon information
#' @export
#'
stripe_retrieve_coupon <- function(api_key, coupon_id) {
    link <- paste0("https://api.stripe.com/v1/coupons/", coupon_id)
    .get(api_key, link)
}

#' Update a coupon.
#'
#' Update the information about a coupon.
#'
#' @param api_key Your Stripe API Key
#'
#' @param coupon_id The coupon you want to update.
#'
#' @param args An list which can contain a \emph{list of \strong{metadata}}
#' and/or a \strong{description}
#'
#' @return A data frame with the new coupon information if succeeded.
#' @export
#'
stripe_update_coupon <- function(api_key, coupon_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/coupons/", coupon_id)
    .post(api_key, link, args)
}

#' Delete a coupon.
#'
#' Delete a specific coupon from your account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param coupon_id The coupon you want to delete
#'
#' @return A null dataframe if succeeded.
#' @export
#'
stripe_delete_coupon <- function(api_key, coupon_id) {
    link <- paste0("https://api.stripe.com/v1/coupons/", coupon_id)
    .delete(api_key, link)
}

#' List all coupons.
#'
#' List all the coupons currently in your account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args An optional list which can contain
#' \strong{ending_before}, \strong{limit}, or \strong{starting_after}
#'
#' @examples stripe_list_application_fee_refunds("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "fee_4cbC9iLv8PdUnk",
#' list(limit=3)) #returns 3 refunds
#'
#' @return A data frame with all the coupons.
#' @export
#'
stripe_list_coupons <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/coupons", args)
    .get(api_key, link)
}
