# Use the rwos package to access Web of Science records

# Install the rwos package from github:
devtools::install_github("juba/rwos")
library(rwos)

# Authenticate
#   This is where you *should* be able to specify your WOS username and password 
#   that are connected to your institutional access for remote access, but it's never 
#   worked for me. I'd love to hear if it does work for you!
sid <- wos_authenticate

# Specify which collections/editions you have access to
collections <- c('SCI', 'SSCI', 'ISTP', 'ISSHP')



# The basic search functions --------------------------------------------------------

# wos_search() returns the number of papers matching the query.
res <- wos_search(sid, 'AU=Wickham Hadley', editions = collections)

# wos_retrieve_all() takes the wos_search() results and returns a table of all the
#   papers in the search, which can then very easily be worked with in R (e.g. filter 
#   out papers that are before a certain year)
pubs <- wos_retrieve_all(res)


# Test using Research Categories ----------------------------------------------------

res <- wos_search(sid, "AU=Wickham Hadley AND WC=('Biology' OR 'Ecology')", editions = collections)
pubs <- wos_retrieve_all(res)
