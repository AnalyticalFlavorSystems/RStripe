% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/application_fee_refunds.R
\name{stripe_list_application_fee_refunds}
\alias{stripe_list_application_fee_refunds}
\title{List all refunds for an Application Fee.}
\usage{
stripe_list_application_fee_refunds(api_key, application_fee_id, args = NULL)
}
\arguments{
\item{api_key}{Your Stripe API Key}

\item{application_fee_id}{The id for the Application Fee
you want to refund}

\item{args}{An optional list which can contain
\describe{
   \item{ending_before}{\emph{optional:} An object id which will show objects before}
   \item{limit}{\emph{optional:} A number 1 to 100 to limit the items.  Default is 10}
   \item{starting_after}{\emph{optional:} An object id which will show objects starting here}
}}
}
\value{
A data frame with application fee refund object if succeeded
}
\description{
List all refunds associated with a specific application fee.
}
\examples{
\dontrun{stripe_list_application_fee_refunds("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "fee_4cbC9iLv8PdUnk",
list(limit=3))} #returns 3 refunds

}

