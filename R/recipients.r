# --------------------------------------------------
# Recipients
# --------------------------------------------------
stripe_create_recipient <- function(api_key, args) {
    link <- paste0("https://api.stripe.com/v1/recipients")
    .post(api_key, link, args)
}

stripe_retrieve_recipient <- function(api_key, recipient_id) {
    link <- paste0("https://api.stripe.com/v1/recipients/", recipient_id)
    .get(api_key, link)
}

stripe_update_recipient <- function(api_key, recipient_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/recipients/", recipient_id)
    .post(api_key, link, args)
}

stripe_delete_recipient <- function(api_key, recipient_id) {
    link <- paste0("https://api.stripe.com/v1/recipients/", recipient_id)
    .delete(api_key, link)
}

stripe_list_recipients <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/recipients", args)
    .get(api_key, link)
}
