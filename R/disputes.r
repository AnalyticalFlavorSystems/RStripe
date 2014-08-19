# --------------------------------------------------
# Displutes
# --------------------------------------------------
stripe_update_dispute <- function(api_key, charge_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/charges/", charge_id, "/dispute")
    .post(api_key, link, args)
}

stripe_close_dispute <- function(api_key, charge_id) {
    link <- paste0("https://api.stripe.com/v1/charges/",
                   charge_id, "/dispute/close")
    .post(api_key, link)
}
