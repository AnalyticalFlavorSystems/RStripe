# --------------------------------------------------
# Cards
# --------------------------------------------------

#' Add a credit card to Stripe.
#'
#' @param api_key Your Stripe API Key
#' @param customer_id The id for the customer you want the credit card
#' added to.
#' @param args A required list of either contains a token,
#' or a card dictionary. /href{https://stripe.com/docs/api#create_card}{more info here}
#' @export
#' @examples 
#' \dontrun{stripe_create_card("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "cus_4cb7HNjNSqqV2H", 
#' list(card="tok_14SsjM2eZvKYlo2CCtdx2AvO")}
#' 
#' \dontrun{stripe_create_card("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "cus_4cb7HNjNSqqV2H", 
#' list(card=list(number="4242424242424242", exp_month="03", exp_year="2018")))}
#' @return A data frame with card information
stripe_create_card <- function(api_key, customer_id, args) {
    args <- .card(args)
    link <- paste0("https://api.stripe.com/v1/customers/",
                   customer_id, "/cards")
    .post(api_key, link, args)
}

#' Retrieve a card from a customer
#'
#' @param api_key Your Stripe API Key
#' @param card_id The id for the card you want to retrieve
#' @param customer_id The id for the customer where the card is
#' added to.
#' @export
#' @return A data frame with card information
stripe_retrieve_card <- function(api_key, card_id, customer_id) {
     link <- paste0("https://api.stripe.com/v1/customers/",
                              customer_id, "/cards/", card_id) 
     .get(api_key, link)
}


#' Update a credit card on Stripe.
#'
#' @param api_key Your Stripe API Key
#' @param customer_id The id for the customer you want the credit card
#' added to.
#' @param card_id The id for the card you want to update
#' @param args A list that can contain the following
#' \strong{address_city}, \strong{address_country}, 
#' \strong{address_line1}, \strong{address_line2}, 
#' \strong{address_state}, \strong{address_zip},
#' \strong{exp_month}, \strong{exp_year},
#' \strong{name}
#' @export
#' @examples 
#' \dontrun{stripe_update_card("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "cus_4cb7HNjNSqqV2H",
#' "card_14TLyd2eZvKYloc2C9PXnfFmi", list(exp_year="04"))}
#' @return A data frame with card information
stripe_update_card <- function(api_key, customer_id, card_id, args) {
    link <- paste0("https://api.stripe.com/v1/customers/",
                   customer_id, "/cards/", card_id)
    .post(api_key, link, args)
}

#' Delete a credit card on Stripe.
#'
#' @param api_key Your Stripe API Key
#' @param customer_id The id for the customer where the card is.
#' @param card_id The id for the card you want to delete
#' @export
#' @return A data frame with card information
stripe_delete_card <- function(api_key, customer_id, card_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",
                   customer_id, "/cards/", card_id)
    .delete(api_key, link)
}

#' List credit card on customers. 
#'
#' @param api_key Your Stripe API Key
#' @param customer_id The id for the customer you want to list the cards
#' @param args an optional list that can contain
#' /strong{ending_before}, \strong{limit}, \strong{starting_after}
#' @export
#' @return A data frame with card information
stripe_list_cards <- function(api_key, customer_id, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/customers/",
                              customer_id, "/cards", args)
    .get(api_key, link)
}
