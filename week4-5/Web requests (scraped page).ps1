$scrapedPage = Invoke-WebRequest -Timeout 10 http://localhost/ToBeScraped.html

#gets count of links
$scrapedPage.Count

#Displays links as HTML elements
$scrapedPage.Links

#gets outer text of every element with the tag 'h2'
$h2s = $scrapedPage.ParsedHtml.getElementsByTagName("h2") | Select outertext
$h2s

# Prints innertext of every div element that has the same class as "div-1"
$div1 = $scrapedPage.ParsedHtml.getElementsByTagName("div") | where { $_.getAttributeNode("class").Value -ilike "div-1" } | select innerText
$div1