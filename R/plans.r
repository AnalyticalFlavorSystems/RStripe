# --------------------------------------------------
# Plans
# --------------------------------------------------
stripe_create_plan <- function(api_key, args) {
    link <- paste0("https://api.stripe.com/v1/plans")
    .post(api_key, link, args)
}

stripe_retrieve_plan <- function(api_key, plan_id) {
    link <- paste0("https://api.stripe.com/v1/plans/", plan_id)
    .get(api_key, link)
}

stripe_update_plan <- function(api_key, plan_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/plans/", plan_id)
    .post(api_key, link, args)
}

stripe_delete_plan <- function(api_key, plan_id) {
    link <- paste0("https://api.stripe.com/v1/plans/",plan_id)
    .delete(api_key, link)
}

stripe_list_plans <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/plans", args)
    .get(api_key, link)
}
