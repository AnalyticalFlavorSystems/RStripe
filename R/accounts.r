# --------------------------------------------------
# Account
# --------------------------------------------------
stripe_retrieve_account <- function(api_key) {
    link <- paste0("https://api.stripe.com/v1/account")
    .get(api_key, link)
}
