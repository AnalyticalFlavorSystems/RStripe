# --------------------------------------------------
# Cards
# --------------------------------------------------
stripe_create_card <- function(api_key, customer_id, args) {
    args <- .card(args)
    link <- paste0("https://api.stripe.com/v1/customers/",
                   customer_id, "/cards")
    .post(api_key, link, args)
}

stripe_retrieve_card <- function(api_key, card_id, customer_id) {
     link <- paste0("https://api.stripe.com/v1/customers/",
                              customer_id, "/cards/", card_id) 
     .get(api_key, link)
}


stripe_update_card <- function(api_key, customer_id, card_id, args) {
    link <- paste0("https://api.stripe.com/v1/customers/",
                   customer_id, "/cards/", card_id)
    .post(api_key, link, args)
}

stripe_delete_card <- function(api_key, customer_id, card_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",
                   customer_id, "/cards/", card_id)
    .delete(api_key, link)
}

stripe_list_cards <- function(api_key, customer_id, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/customers/",
                              customer_id, "/cards", args)
    .get(api_key, link)
}
