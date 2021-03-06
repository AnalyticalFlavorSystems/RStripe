% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/charges.R
\name{stripe_list_charges}
\alias{stripe_list_charges}
\title{List all charges.}
\usage{
stripe_list_charges(api_key, args = NULL)
}
\arguments{
\item{api_key}{Your Stripe API Key}

\item{args}{an optional list that can include \strong{customer},
\describe{
   \item{customer}{\emph{optional} A customer id to show only their charges. }
   \item{ending_before}{\emph{optional} An id to show the ones before this item.}
   \item{limit}{\emph{optional} The limit to show.  Can be 1 to 100.  Default is 10.}
   \item{starting_after}{\emph{optional} An id to show the ones starting after this item.}
}}
}
\value{
Returns a data frame with all customer charges.  10 if no limit specified.
}
\description{
List all charges conducted in a time frame or on customer.  Limits to 10 originally.
}

