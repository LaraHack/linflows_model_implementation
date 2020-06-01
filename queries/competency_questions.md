### Q1: What is the number of positive comments and the number of negative comments per reviewer?

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?posNeg (COUNT(DISTINCT ?reviewComment) AS ?noReviewComments)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?reviewComment linkflows:refersTo ?part .

  VALUES ?posNeg { linkflows:PositiveComment linkflows:NegativeComment }
  ?reviewComment a ?posNeg .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?posNeg
ORDER BY ?reviewer ?posNeg
```

### Q2: What is the number of positive comments and the number of negative comments per section of the article?

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?posNeg (COUNT(DISTINCT ?reviewComment) AS ?noReviewComments)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
    ?reviewComment linkflows:refersTo doco:Section .

    VALUES ?partType { doco:Section doco:Paragraph }
    ?part a doco:Section .

  VALUES ?posNeg { linkflows:PositiveComment linkflows:NegativeComment }
  ?reviewComment a ?posNeg .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?posNeg
ORDER BY ?reviewer ?posNeg
```

### Q3: What is the distribution of the review comments with respect to whether they address the content or the presentation (syntax and style) of the article?

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?aspect (COUNT(DISTINCT ?reviewComment) AS ?noReviewComments)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?reviewComment linkflows:refersTo ?part .

  VALUES ?aspect { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
  ?reviewComment a ?aspect .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?aspect
ORDER BY ?reviewer ?aspect
```

### Q4: What  is  the  nature  of  the  review  comments  with  respect  to  whether they  refer  to  a  specific  paragraph  or  a  larger  structure  such  as  a  section  or the whole article?

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?part ?reviewComment
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?reviewComment linkflows:refersTo ?part .

  VALUES ?partType { doco:Article doco:Section doco:Paragraph }
  ?part a ?partType .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?part
ORDER BY ?reviewer ?part
```

### Q5: What  are  the  critical  points  that  were  raised  by  the  reviewers  in  the sense of negative comments with a high impact on the quality of the paper?

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?impact ?reviewComment
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?reviewComment linkflows:refersTo ?part .

  ?reviewComment linkflows:hasImpact ?impact .
  FILTER (?impact = "4"^^xsd:positiveInteger || ?impact = "5"^^xsd:positiveInteger) .

  ?reviewComment a linkflows:NegativeComment .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?impact
ORDER BY ?reviewer ?impact
```

### Q6: How many points were raised that need to be addressed by the authors, as an estimate for the amount of work needed for a revision?

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?part ?aspect ?posNeg ?impact ?reviewComment
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?reviewComment linkflows:refersTo ?part .

  ?reviewComment a linkflows:ActionNeededComment.

  VALUES ?partType { doco:Article doco:Section doco:Paragraph }
  ?part a ?partType .

  VALUES ?aspect { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
  ?reviewComment a ?aspect .

  VALUES ?posNeg { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
  ?reviewComment a ?posNeg .

  ?reviewComment linkflows:hasImpact ?impact .
  FILTER (?impact = "1"^^xsd:positiveInteger || ?impact = "2"^^xsd:positiveInteger || ?impact = "3"^^xsd:positiveInteger || ?impact = "4"^^xsd:positiveInteger || ?impact = "5"^^xsd:positiveInteger) .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?part ?aspect ?posNeg ?impact ?reviewComment
ORDER BY ?reviewer ?part ?aspect ?posNeg ?impact ?reviewComment
```

### Q7: How  do  the  review  comments  cover  the  different  sections  and  paragraphs of the paper?

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?reviewComment ?part ?aspect ?posNeg ?impact  ?actionNeeded
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?reviewComment linkflows:refersTo ?part .

  VALUES ?partType { doco:Section doco:Paragraph }
  ?part a ?partType .

  VALUES ?aspect { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
  ?reviewComment a ?aspect .

  VALUES ?posNeg { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
  ?reviewComment a ?posNeg .

  ?reviewComment linkflows:hasImpact ?impact .
  FILTER (?impact = "1"^^xsd:positiveInteger || ?impact = "2"^^xsd:positiveInteger || ?impact = "3"^^xsd:positiveInteger || ?impact = "4"^^xsd:positiveInteger || ?impact = "5"^^xsd:positiveInteger) .

  VALUES ?actionNeeded { linkflows:ActionNeededComment linkflows:SuggestionComment linkflows:NoActionNeededComment}

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?part ?aspect ?posNeg ?impact ?actionNeeded
ORDER BY ?reviewer ?part ?aspect ?posNeg ?impact ?actionNeeded
