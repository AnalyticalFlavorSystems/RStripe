# --------------------------------------------------
# Plans
# --------------------------------------------------

#' Create a Plan
#'
#' Create a new plan on your stripe account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args A list which must contain \strong{id}, \strong{amount},
#' \strong{currency}, \strong{interval}, and \strong{name}. 
#' It can also contain \strong{description}, \strong{metadata},
#' \strong{interval_count}, \strong{trial_period_days},
#' and \strong{statement_description}
#'
#' @examples stripe_create_plan("sk_test_BQokikJOvBiI2HlWgH4olfQ2",
#' list(id="example-gold", amount=3000, currency="usd", interval="month"))
#'
#' @return A data frame with the new plan info if successful.
#' @export
#'
stripe_create_plan <- function(api_key, args) {
    link <- paste0("https://api.stripe.com/v1/plans")
    .post(api_key, link, args)
}

#' Retrieve a Plan
#'
#' Retrieve the information on a particular plan on your account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param plan_id The id of the plan you want to retrieve
#'
#' @return A data frame with the plan info if successful.
#' @export
#'
stripe_retrieve_plan <- function(api_key, plan_id) {
    link <- paste0("https://api.stripe.com/v1/plans/", plan_id)
    .get(api_key, link)
}

#' Update a Plan
#'
#' Update the information about a particular plan on your stripe account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param plan_id The id of the plan you want to update
#'
#' @param args A list can contain \strong{statement_description}, 
#' \strong{metadata}, and \strong{name}
#'
#' @return A data frame with the updated plan info if successful.
#' @export
#'
stripe_update_plan <- function(api_key, plan_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/plans/", plan_id)
    .post(api_key, link, args)
}

#' Delete a plan on Stripe.
#'
#' Delete a plan in your system.  Only able to do this if you have no subscriptions on it.
#'
#' @param api_key Your Stripe API Key
#'
#' @param plan_id The id for the plan you want to delete
#'
#' @return A data frame with nothing if successful.
#' @export
#'
stripe_delete_plan <- function(api_key, plan_id) {
    link <- paste0("https://api.stripe.com/v1/plans/",plan_id)
    .delete(api_key, link)
}

#' List Plans.
#'
#' List all the plans in your system. It defaults to showing 10 unless you change the limit.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args an optional list that can contain
#' /strong{ending_before}, \strong{limit}, \strong{starting_after}
#'
#' @return A data frame with plan information
#' @export
#'
stripe_list_plans <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/plans", args)
    .get(api_key, link)
}
