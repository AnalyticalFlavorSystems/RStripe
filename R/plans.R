# --------------------------------------------------
# Plans
# --------------------------------------------------

#' Create a Plan
#'
#' @param api_key Your Stripe API Key
#' @param args A list which must contain \strong{id}, \strong{amount},
#' \strong{currency}, \strong{interval}, and \strong{name}. 
#' It can also contain \strong{description}, \strong{metadata},
#' \strong{interval_count}, \strong{trial_period_days},
#' and \strong{statement_description}
#' @export
#' @examples stripe_create_plan("sk_test_BQokikJOvBiI2HlWgH4olfQ2",
#' list(id="example-gold", amount=3000, currency="usd", interval="month"))
#' @return A data frame with the new plan info if successful.
stripe_create_plan <- function(api_key, args) {
    link <- paste0("https://api.stripe.com/v1/plans")
    .post(api_key, link, args)
}

#' Retrieve a Plan
#'
#' @param api_key Your Stripe API Key
#' @param plan_id The id of the plan you want to retrieve
#' @export
#' @return A data frame with the plan info if successful.
stripe_retrieve_plan <- function(api_key, plan_id) {
    link <- paste0("https://api.stripe.com/v1/plans/", plan_id)
    .get(api_key, link)
}

#' Update a Plan
#'
#' @param api_key Your Stripe API Key
#' @param plan_id The id of the plan you want to update
#' @param args A list can contain \strong{statement_description}, 
#' \strong{metadata}, and \strong{name}
#' @export
#' @return A data frame with the updated plan info if successful.
stripe_update_plan <- function(api_key, plan_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/plans/", plan_id)
    .post(api_key, link, args)
}

#' Delete a plan on Stripe.
#'
#' @param api_key Your Stripe API Key
#' @param plan_id The id for the plan you want to delete
#' @export
#' @return A data frame with nothing if successful.
stripe_delete_plan <- function(api_key, plan_id) {
    link <- paste0("https://api.stripe.com/v1/plans/",plan_id)
    .delete(api_key, link)
}

#' List Plans.
#'
#' @param api_key Your Stripe API Key
#' @param args an optional list that can contain
#' /strong{ending_before}, \strong{limit}, \strong{starting_after}
#' @export
#' @return A data frame with plan information
stripe_list_plans <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/plans", args)
    .get(api_key, link)
}
