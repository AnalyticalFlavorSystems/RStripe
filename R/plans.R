# --------------------------------------------------
# Plans
# --------------------------------------------------

#' Create a Plan
#'
#' Create a new plan on your stripe account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args A list which must contain 
#' \describe{
#'    \item{id} The id of the plan to use.  e.g. 'gold'}
#'    \item{amount}{\strong{required} The amount in cents to charge.}
#'    \item{currency}{\strong{required} 3-letter ISO code for currency.}
#'    \item{interval}{\strong{required} Specifies billing frequencey.  \strong{day}, \strong{week}
#'                    \strong{month}, \strong{year}.}
#'    \item{name}{\strong{required} The name of plan.  Appears on invoice.}
#'    \item{metadata}{\emph{optional} A list which can contain anything to further describe.}
#'    \item{trial_period_days}{\emph{optional} Specifies trial period in day.}
#'    \item{interval_count}{\emph{optional} intervals in billing.  e.g. 3 if interval=month}
#'    \item{statement_description}{\emph{optional} String to appear on invoice. Up to 15 characters}
#' }
#'
#' @examples stripe_create_plan("sk_test_BQokikJOvBiI2HlWgH4olfQ2",
#' list(id="example-gold", amount=3000, currency="usd", interval="month"))
#'
#' @return A data frame with the new plan info if successful.
#'
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
#'
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
#' @param args A list can contain 
#' \describe{
#'    \item{name}{\emph{optional} The name of plan.  Appears on invoice.}
#'    \item{metadata}{\emph{optional} A list which can contain anything to further describe.}
#'    \item{statement_description}{\emph{optional} String to appear on invoice. Up to 15 characters}
#' }
#'
#' @return A data frame with the updated plan info if successful.
#'
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
#'
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
#' \describe{
#'    \item{ending_before}{\emph{optional:} An object id which will show objects before}
#'    \item{limit}{\emph{optional:} A number 1 to 100 to limit the items.  Default is 10}
#'    \item{starting_after}{\emph{optional:} An object id which will show objects starting here}
#' }
#'
#' @return A data frame with plan information
#'
#' @export
#'
stripe_list_plans <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/plans", args)
    .get(api_key, link)
}
