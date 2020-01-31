### article URI identifier with trustyURI
```
http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1
```


### Q1: number of review comments per article, per reviewer

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer (COUNT(?reviewComment) AS ?article)
WHERE {
  ?reviewComment linkflows:refersTo <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1> .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ORDER BY ASC(?reviewer)
```

### Q2: number of review comments per section, per reviewer

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?section
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?section .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?section .
  ?section a doco:Section .
} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q3: number of review comments per paragraph, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?paragraphs
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?paragraph .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?paragraph .
  ?paragraph a doco:Paragraph .
} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q4: number of review comments per syntax, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?syntax
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .
  ?reviewComment a linkflows:SyntaxComment .

} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q5: number of review comments per style, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?style
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .
  ?reviewComment a linkflows:StyleComment .

} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q6: number of review comments per content, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?content
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .
  ?reviewComment a linkflows:ContentComment .

} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q7: number of review comments per negative comment, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?content
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .
  ?reviewComment a linkflows:NegativeComment .

} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```
