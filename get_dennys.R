#devtools::install_github("hrbrmstr/xmlview")
#library(xmlview)

#url = "https://hosted.where2getit.com/dennys/responsive/ajax?&xml_request=%3Crequest%3E%3Cappkey%3E6B962D40-03BA-11E5-BC31-9A51842CA48B%3C%2Fappkey%3E%3Cformdata+id%3D%22locatorsearch%22%3E%3Cdataview%3Estore_default%3C%2Fdataview%3E%3Climit%3E16%3C%2Flimit%3E%3Corder%3Erank%2C_distance%3C%2Forder%3E%3Cgeolocs%3E%3Cgeoloc%3E%3Caddressline%3E90210%3C%2Faddressline%3E%3Clongitude%3E%3C%2Flongitude%3E%3Clatitude%3E%3C%2Flatitude%3E%3Ccountry%3EUS%3C%2Fcountry%3E%3C%2Fgeoloc%3E%3C%2Fgeolocs%3E%3Cstateonly%3E1%3C%2Fstateonly%3E%3Csearchradius%3E10%7C25%7C50%7C100%3C%2Fsearchradius%3E%3C%2Fformdata%3E%3C%2Frequest%3E"
#URLdecode(url)

#request = "<request><appkey>6B962D40-03BA-11E5-BC31-9A51842CA48B</appkey><formdata+id=\"locatorsearch\"><dataview>store_default</dataview><limit>16</limit><order>rank,_distance</order><geolocs><geoloc><addressline>90210</addressline><longitude></longitude><latitude></latitude><country>US</country></geoloc></geolocs><stateonly>1</stateonly><searchradius>10|25|50|100</searchradius></formdata></request>"
#xml_view(request)

library(stringr)
library(dplyr)

get_dennys_xml_url = function(limit=16, address="90210", radius = "10")
{
  base_url="https://hosted.where2getit.com/dennys/responsive/ajax?&xml_request="
  xml = paste0('<request>
    <appkey>6B962D40-03BA-11E5-BC31-9A51842CA48B</appkey>
    <formdata+id="locatorsearch">
      <dataview>store_default</dataview>
      <limit>',limit,'</limit>
      <order>rank,_distance</order>
      <geolocs>
        <geoloc>
          <addressline>',address,'</addressline>
          <longitude></longitude>
          <latitude></latitude>
          <country>US</country>
        </geoloc>
      </geolocs>
      <stateonly>1</stateonly>
      <searchradius>',radius,'</searchradius>
    </formdata>
  </request>') %>% str_replace_all('\\s+','')
               
  paste0(base_url, xml) %>% URLencode()
}

#get_dennys_xml(limit=1000, radius=1000, address="90210")



dir.create("data/dennys/", showWarnings = FALSE, recursive = TRUE)

zips = c(27705, 90210)

for(zip in zips)
{
  download.file(get_dennys_xml_url(limit=1000, radius=1000, address=zip), 
                destfile = paste0("data/dennys/",zip,".xml"),
                quiet = TRUE)
}



