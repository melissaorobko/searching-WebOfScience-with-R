library(rwos)
library(tidyverse)

# Authenticate and specify collections you have access to --------
sid <- wos_authenticate()
collections <- c('SCI', 'SSCI', 'ISTP', 'ISSHP')


# A basic search for CEA refining by topic ------------------------
res <- wos_search(sid=sid, editions = c('SCI','SSCI','ISTP','ISSHP'),
                  query='TS=((("cumulative impact*" OR "cumulative effect*") AND assess*) AND (ecolog* OR ecosystem*))')
pubs <- wos_retrieve_all(res) 
pubs %>% dplyr::select(year, authors, title, journal, everything()) %>% View()

# Test different topics to refine CEA by  ----------------------------
# CEA1 only
res <- wos_search(sid=sid, query='TS=(("cumulative impact*" OR "cumulative effect*") AND assess*)', editions = collections)
# CEA1 envt
res <- wos_search(sid=sid, query='TS=((("cumulative impact*" OR "cumulative effect*") AND assess*) AND (ecolog* OR environment*))', editions = collections)
# CEA1 ecosys
res <- wos_search(sid=sid, query='TS=((("cumulative impact*" OR "cumulative effect*") AND assess*) AND (ecolog* OR ecosys*))', editions = collections)
# CEA1 both
res <- wos_search(sid=sid, query='TS=((("cumulative impact*" OR "cumulative effect*") AND assess*) AND (ecolog* OR environment* OR ecosystem*))', editions = collections)


# Refine CEA by Research Categories ----------------------------------
res <- wos_search(sid=sid, editions = collections, 
                  query='TS=(("cumulative impact*" OR "cumulative effect*") AND assess*) AND (WC=("Environmental Sciences" OR "Environmental Studies" OR Ecology OR "Biodiversity Conservation" OR "Marine Freshwater" OR Fisheries OR "Biology" OR "Multidisciplinary Sciences" OR "Toxicology"))')

# Test the overlap of papers b/w refining by two topics (environment* & ecosystem*) and Research Categories ----
pubs.CEA1.envt <- 
  wos_retrieve_all(wos_search(sid=sid, editions=collections,
                              query='TS=(("cumulative impact*" OR "cumulative effect*") AND assess* AND (ecolog* OR environment*))'))
pubs.CEA1.ecosys <- 
  wos_retrieve_all(wos_search(sid=sid, editions=collections,
                              query='TS=(("cumulative impact*" OR "cumulative effect*") AND assess* AND (ecolog* OR ecosys*))'))
pubs.CEA1.categs <- 
  wos_retrieve_all(wos_search(sid=sid, editions=collections, 
                              query='TS=(("cumulative impact*" OR "cumulative effect*") AND assess*) AND (WC=("Environmental Sciences" OR "Environmental Studies" OR Ecology OR "Biodiversity Conservation" OR "Marine Freshwater" OR Fisheries OR "Biology" OR "Multidisciplinary Sciences" OR "Toxicology"))'))
# Overlap of envt & ecosys = 82%
nrow(semi_join(pubs.CEA1.ecosys, pubs.CEA1.envt))/nrow(pubs.CEA1.ecosys)
# Overlap of categs & ecosys = 78%
nrow(semi_join(pubs.CEA1.categs, pubs.CEA1.ecosys))/nrow(pubs.CEA1.ecosys)
# Overlap of categs & envt = 67%
nrow(semi_join(pubs.CEA1.categs, pubs.CEA1.envt))/nrow(pubs.CEA1.envt)
