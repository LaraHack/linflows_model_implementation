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

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?negative
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .
  ?reviewComment a linkflows:NegativeComment .

} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q8: number of review comments per neutral comment, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?neutral
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .
  ?reviewComment a linkflows:NeutralComment .

} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q9: number of review comments per positive comment, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?positive
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .
  ?reviewComment a linkflows:PositiveComment .

} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```


### Q10: number of review comments with impact=1, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?I1
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment ; linkflows:hasImpact ?impact . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .
  FILTER (?impact = "1"^^xsd:positiveInteger) .


} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```


### Q11: number of review comments with impact=2, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?I2
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment ; linkflows:hasImpact ?impact . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .
  FILTER (?impact = "2"^^xsd:positiveInteger) .


} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q12: number of review comments with impact=3, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?I3
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment ; linkflows:hasImpact ?impact . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .
  FILTER (?impact = "3"^^xsd:positiveInteger) .


} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q13: number of review comments with impact=4, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?I4
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment ; linkflows:hasImpact ?impact . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .
  FILTER (?impact = "4"^^xsd:positiveInteger) .


} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q14: number of review comments with impact=5, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?I5
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment ; linkflows:hasImpact ?impact . }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .
  FILTER (?impact = "5"^^xsd:positiveInteger) .


} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q15: number of review comments that are compulsory, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?compulsory
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment, linkflows:ActionNeededComment }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .

} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q16: number of review comments that are suggestions per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?suggestion
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment, linkflows:SuggestionComment }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .

} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### Q17: number of review comments that require no action, per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer COUNT(DISTINCT ?reviewComment) AS ?no_action
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment, linkflows:NoActionNeededComment }
  ?assertion prov:wasAttributedTo ?reviewer .

  ?reviewComment linkflows:refersTo  ?part .

} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```
#####################

### Q1+Q2+Q3: number of review comments per article, section, paragraph per reviewer
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer (COUNT(?reviewCommentArticle) AS ?article) (COUNT(?reviewCommentSection) AS ?section) (COUNT(?reviewCommentParagraph) AS ?paragraph)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  VALUES ?type {(?reviewCommentArticle)  (?reviewCommentSection) (?reviewCommentParagraph)}
  GRAPH ?assertion { ?type a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .

  {    
    ?reviewCommentArticle linkflows:refersTo  ?part .
    ?part a doco:Article .
  } UNION {
    ?reviewCommentSection linkflows:refersTo  ?part .
    ?part a doco:Section .
  } UNION {
    ?reviewCommentParagraph linkflows:refersTo  ?part .
    ?part a doco:Paragraph .
  }

} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```
