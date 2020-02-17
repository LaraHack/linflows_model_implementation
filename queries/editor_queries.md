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

#### Helpers Q1

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?posNeg ?c ?part ?impact ?aspect ?actionNeeded
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .

  ?c linkflows:hasImpact ?impact .

  VALUES ?aspect { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
  ?c a ?aspect .

  VALUES ?actionNeeded { linkflows:ActionNeededComment linkflows:SuggestionComment linkflows:NoActionNeededComment}

  VALUES ?posNeg { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
  GRAPH ?assertion { ?c a ?posNeg . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?posNeg ORDER BY ?reviewer ?posNeg
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

[//]: # (get the number of review comments belonging to a specific article that references the whole article, the sections and the paragraphs grouped by reviewer)

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>


CONSTRUCT {
  ?reviewer ?aspect ?aspectCount .
}
WHERE {
  SELECT ?reviewer ?aspect (COUNT(DISTINCT ?c) AS ?aspectCount)
  WHERE {
    <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
      (po:contains)* ?part .
    ?c linkflows:refersTo ?part .

    VALUES ?aspect { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
    GRAPH ?assertion { ?c a ?aspect . }
    ?assertion prov:wasAttributedTo ?reviewer .
  } GROUP BY ?reviewer ?aspect ORDER BY ?reviewer ?aspect
}
```


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

  GRAPH ?assertion { ?reviewCommentArticle, ?reviewCommentSection, ?reviewCommentParagraph a linkflows:ReviewComment . }
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

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer AS ?Reviewer (COUNT(?reviewCommentArticle) AS ?commentsPerArticle) (COUNT(?reviewCommentSection) AS ?commentsPerSections) (COUNT(?reviewCommentParagraph) AS ?commentsPerParagraph) (COUNT(?reviewCommentFigure) AS ?commentsPerFigure) (COUNT(?reviewCommentTable) AS ?commentsPerTable) (COUNT(?reviewCommentFootnote) AS ?commentsPerFootnote) (COUNT(?reviewCommentFormula) AS ?commentsPerFormula)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?subpart .

  GRAPH ?assertion { ?c a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .

  {
    ?reviewCommentArticle a linkflows:ReviewComment .
    ?reviewCommentArticle linkflows:refersTo  ?subpart .
    ?subpart a doco:Article .
  } UNION {
    ?reviewCommentSection a linkflows:ReviewComment .
    ?reviewCommentSection linkflows:refersTo ?subpart .
    ?subpart a doco:Section .
  } UNION {
    ?reviewCommentParagraph a linkflows:ReviewComment .
    ?reviewCommentParagraph linkflows:refersTo ?subpart .
    ?subpart a doco:Paragraph .
  } UNION {
    ?reviewCommentFigure a linkflows:ReviewComment .
    ?reviewCommentFigure linkflows:refersTo ?subpart .
    ?subpart a doco:Figure .
  } UNION {
    ?reviewCommentTable a linkflows:ReviewComment .
    ?reviewCommentTable linkflows:refersTo ?subpart .
    ?subpart a doco:Table .
  } UNION {
    ?reviewCommentFootnote a linkflows:ReviewComment .
    ?reviewCommentFootnote linkflows:refersTo ?subpart .
    ?subpart a doco:Footnote .
  } UNION {
    ?reviewCommentFormula a linkflows:ReviewComment .
    ?reviewCommentFormula linkflows:refersTo ?subpart .
    ?subpart a doco:Formula .
  }
} GROUP BY ?reviewer  ORDER BY ASC(?reviewer)
```

### example query from form, built dynamically from Javascript

Assumptions (checked checkboxes):

Article level: section, paragraph
Aspect: syntax, content
Pos/Neg: negative, neutral, positive
Impact: 3, 4, 5
Action needed: compulsory

#### Query logic (declarative)

Retrieve number of review comments per reviewer that:
 - target a certain part of the given article URI ```AND```
 - the part targeted in the article is a section or a paragraph ```AND```
 - the review comments are about syntax or content ```AND```
 - the review comments are negative or neutral or positive ```AND```
 - the impact is 3 or 4 or 5 ```AND```
 - the action needed by author is compulsory to be addressed

#### Query logic with some pseudo-SPARQL

 Retrieve number of review comments per reviewer (```GROUP BY ?reviewer  ORDER BY ASC(?reviewer)``` )
 ```
 GRAPH ?assertion {...}
 ?assertion prov:wasAttributedTo ?reviewer .
 ...
 ?reviewComment a linkflows:ReviewComment .
 ```
 that:
  - target a certain part of the given article URI ```AND```
    ```
    <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
      (po:contains)* ?subpart .
    ```

  - the part targeted in the article is a section or a paragraph ```AND```
    ```
    ?reviewComment linkflows:refersTo ?subpart .
    ...
    ?subpart a doco:Section OR ?subpart a doco:Paragraph .
      ```

  - the review comments are about syntax or content ```AND```
  - the review comments are negative or neutral or positive ```AND```
  - the impact is 3 or 4 or 5 ```AND```
    ```
    VALUES ?type { linkflows:NegativeComment linkflows:NeutralComment linkflows:PositiveComment }
    GRAPH ?assertion { ?c a ?type ; linkflows:hasImpact ?impact . }
    FILTER (?impact = "3"^^xsd:positiveInteger || ?impact = "4"^^xsd:positiveInteger || ?impact = "5"^^xsd:positiveInteger) .
    ```

  - the action needed by author is compulsory to be addressed
    ```
    GRAPH ?assertion { ?reviewComment a linkflows:ActionNeededComment }
    ```

#### Putting it all together:

```
GRAPH ?assertion {...}
?assertion prov:wasAttributedTo ?reviewer .

```


#### Helpers Questions 1 and 2

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?part ?aspect ?impact ?action
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?reviewComment linkflows:refersTo ?part .

  VALUES ?aspect { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
  ?reviewComment a ?aspect .

  ?reviewComment linkflows:hasImpact ?impact .

  VALUES ?action { linkflows:ActionNeededComment linkflows:SuggestionComment linkflows:NoActionNeededComment }
  ?reviewComment a ?action .

  GRAPH ?assertion { ?reviewComment a linkflows:NegativeComment . }
  FILTER (?impact = "3"^^xsd:positiveInteger || ?impact = "4"^^xsd:positiveInteger || ?impact = "5"^^xsd:positiveInteger) .
  ?assertion prov:wasAttributedTo ?reviewer .
}
GROUP BY ?reviewer ?part ?aspect ?impact
ORDER BY ?reviewer ?part ?aspect ?impact
```


#### Helpers Question 3

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?part ?aspect ?posNeg ?impact ?action
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  VALUES ?aspect { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
  ?reviewComment a ?aspect .

  VALUES ?posNeg { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
  ?reviewComment a ?posNeg .

  ?reviewComment linkflows:hasImpact ?impact .

  VALUES ?action { linkflows:ActionNeededComment linkflows:SuggestionComment linkflows:NoActionNeededComment }
  ?reviewComment a ?action .

  GRAPH ?assertion { ?reviewComment linkflows:refersTo ?part . }
  ?assertion prov:wasAttributedTo ?reviewer .
}
GROUP BY ?reviewer ?part ?aspect ?posNeg ?impact
ORDER BY ?reviewer ?part ?aspect ?posNeg ?impact
```


#### Helpers Question 4

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?part ?aspect ?posNeg ?impact
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?reviewComment linkflows:refersTo ?part .

  VALUES ?aspect { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
  ?reviewComment a ?aspect .

  VALUES ?posNeg { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
  ?reviewComment a ?posNeg .

  ?reviewComment linkflows:hasImpact ?impact .

  GRAPH ?assertion { ?reviewComment a linkflows:ActionNeededComment . }
  ?assertion prov:wasAttributedTo ?reviewer .
}
GROUP BY ?reviewer ?part ?aspect ?posNeg ?impact
ORDER BY ?reviewer ?part ?aspect ?posNeg ?impact
```

#### Helpers Question 5

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX c4o: <http://purl.org/spar/c4o/>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?sectionNumber, ?sectionName, ?aspect,  ?posNeg, ?impact, ?action
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?section .

  ?section a doco:Section .
  ?section po:containsAsHeader ?sectionLabel, ?sectionTitle .
  ?sectionLabel a doco:SectionLabel ;
     c4o:hasContent ?sectionNumber.
  ?sectionTitle a doco:SectionTitle ;
     c4o:hasContent ?sectionName.

   ?reviewComment linkflows:refersTo ?section .

   VALUES ?aspect { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
   ?reviewComment a ?aspect .

   VALUES ?posNeg { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
   ?reviewComment a ?posNeg .

   ?reviewComment linkflows:hasImpact ?impact .

   VALUES ?action { linkflows:ActionNeededComment linkflows:SuggestionComment linkflows:NoActionNeededComment }
   ?reviewComment a ?action .

   GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
   ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?sectionNumber ORDER BY ?sectionNumber
```


#### Helpers: no. of distinct review comments per certain reviewer

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT (COUNT(DISTINCT ?reviewComment) AS ?noReviewComments)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  VALUES ?aspect { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
  ?reviewComment a ?aspect .

  VALUES ?posNeg { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
  ?reviewComment a ?posNeg .

  ?reviewComment linkflows:hasImpact ?impact .

  VALUES ?action { linkflows:ActionNeededComment linkflows:SuggestionComment linkflows:NoActionNeededComment }
  ?reviewComment a ?action .

  GRAPH ?assertion { ?reviewComment linkflows:refersTo ?part . }
  ?assertion prov:wasAttributedTo <https://orcid.org/0000-0001-9962-7193> .
}
```

#### Helper query template

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

  VALUES ?partType { doco:Article doco:Section doco:Paragraph }
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
```
