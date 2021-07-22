# searching-WebOfScience-with-R

This repository contains code to access Web of Science records with the `rwos` package. I will walk you through how to search using this package below. Visit https://github.com/juba/rwos for the package author's documentation. The author says that development of the package is stalled, so it's not actively supported or improved. There's another package, `wosr`, but I didn't have much success with that one. I may return to it since it returns more metadata on papers (e.g. keywords plus).

See `accessing-WOS-with-R_basics.R` for all the code you'll need for basic searches, and see below for how to do the searches. I put some examples of testing variations of search strings about Cumulative Effects Assessment in `testing_variations_for_CEA.R` for more searching examples.

I would love to hear if you discover anything that works better than my code! My email should be on my Github profile page.



## Access

Web of Science is very careful about who accesses it so this is probably the hardest part to figure out. **Your computer MUST be connected to your institution's network**. 
* Ethernet connection on campus is the most reliable. Make sure that you disable any proxies or VPNs.   
* I have not had much luck with a WiFi connection, but another researcher has informed me that if you connect to your institution's VPN, you will then be able to authenticate using `wos_authenticate()` (thank you @nembrown!).  


## Editions/collections

Often, universities only have subscriptions to SOME editions (AKA collections) of WOS. If this is the case, the default search will return an error, so you must specify only ones that you have access to or you will get an error saying you don't have access to a certain collection. The acronyms for the collections are SCI, SSCI, ISTP, ISSHP, IC. If you're not sure, you can test them one by one.


## Building queries

See this page for links to ALL of WOS's help pages: http://images.webofknowledge.com/images/help/WOS/

For all of the search categories/fields to use in queries (e.g. Topic is TS, Publication Type is PT), and any rules to follow when using these field tags, visit https://images.webofknowledge.com/images/help/WOS/hs_wos_fieldtags.html.

An example query is `'AU="Wickham Hadley'`. 

You can combine many queries: ` '(AU="Wickham Hadley") OR (TS="statist*")' `.

Some key operators: "AND", "OR", "NEAR/n"

Consider using quotes vs the NEAR/n operator (where n=the number of words that can separate the two terms on either side of NEAR).

Consider refining your search by topic ("TS") or Research Categories ("WC"). Research categories must the names on this webpage, and I believe it uses partial matching: https://images.webofknowledge.com/images/help/WOS/hp_subject_category_terms_tasca.html.
