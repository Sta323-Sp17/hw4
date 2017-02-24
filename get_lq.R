library(rvest)
library(magrittr)
library(stringr)

base_url = url = "http://www2.stat.duke.edu/~cr173/lq/www.lq.com/en/findandbook/"

page = read_html(paste0(url,"hotel-listings.html"))

links = page %>% 
  html_nodes("#hotelListing a") %>% html_attr("href") %>% 
  .[!is.na(.)] %>% 
  .[. != "#"] 
  

dir.create("data/lq/", showWarnings = FALSE, recursive = TRUE)
i=1
for(link in links)
{
  cat(link, '\n')
  download.file(paste0(base_url, link), 
                destfile = paste0("data/lq/",link),
                quiet = TRUE)
  
  i=i+1
  if (i>20)
    break
}


