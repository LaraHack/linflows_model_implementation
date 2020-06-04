# Competency Question as SPARQL Queries

## General Queries

### get total number of triples in the ts

```
SELECT (COUNT(*) as ?Triples)
WHERE {
  ?s ?p ?o
}
```

### get list of all papers

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>

SELECT *
WHERE {
  ?article a doco:Article .
  ?article dcterms:title ?title .
}
```

### get total number of paragraphs/sections

```
PREFIX doco: <http://purl.org/spar/doco/>

SELECT (COUNT(*) as ?o)
WHERE {
  ?s ?p doco:Paragraph #doco:Section, doco:Article, doco:Figure, doco:Table, doco:Formula, doco:Footnote
}
```

### get total number of paragraphs/sections per article

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>

SELECT ?title, (COUNT(*) as ?sections), (COUNT(*) as ?paragraphs)
WHERE {
  ?article a doco:Article ;
    (po:contains)* ?section ;
    dcterms:title ?title .
  ?section a doco:Section .
  ?section po:contains ?paragraph .
} GROUP BY ?title
```

### total number of main sections per article

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>

SELECT ?title, (COUNT(*) as ?sections)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    dcterms:title ?title ;
    po:contains ?section .

  ?section a doco:Section .
}
```

### get main sections (section number and section title) per article (ordered by section number ascending)

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX c4o: <http://purl.org/spar/c4o/>

SELECT ?sectionNumberLiteral AS ?Section, ?sectionTitleLiteral AS ?Title
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    dcterms:title ?title ;
    po:contains ?section .

  ?section a doco:Section ;
     po:containsAsHeader ?sectionNumber, ?sectionTitle .
  ?sectionNumber a doco:SectionLabel ;
     c4o:hasContent ?sectionNumberLiteral .
  ?sectionTitle a doco:SectionTitle ;
     c4o:hasContent ?sectionTitleLiteral .
} ORDER BY ASC(?sectionNumberLiteral)
```

### total number of sections and subsections per article
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX c4o: <http://purl.org/spar/c4o/>```


PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>

SELECT ?title, (COUNT(*) as ?sections)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    dcterms:title ?title ;
    (po:contains)* ?section .

  ?section a doco:Section .
}
```

### get all the numbers and names of sections of an article

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX c4o: <http://purl.org/spar/c4o/>

SELECT ?sectionNumber, ?sectionName
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?section .

  ?section a doco:Section .
  ?section po:containsAsHeader ?sectionLabel, ?sectionTitle .
  ?sectionLabel a doco:SectionLabel ;
     c4o:hasContent ?sectionNumber.
  ?sectionTitle a doco:SectionTitle ;
     c4o:hasContent ?sectionName.
}
```
### get all paragraphs per section
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX c4o: <http://purl.org/spar/c4o/>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?sectionNumberLiteral AS ?Section, ?sectionTitleLiteral AS ?Title, (COUNT (*) AS ?comment)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    dcterms:title ?title ;
    po:contains ?section .

  ?section a doco:Section ;
     po:containsAsHeader ?sectionNumber, ?sectionTitle .
  ?sectionNumber a doco:SectionLabel ;
     c4o:hasContent ?sectionNumberLiteral .
  ?sectionTitle a doco:SectionTitle ;
     c4o:hasContent ?sectionTitleLiteral .

  ?comment a linkflows:ReviewComment ;
    linkflows:refersTo ?section.  

  ?section po:contains ?paragraph, ?subSection .
  ?paragraph a doco:Paragraph .
  ?subSection a doco:Section .
} ORDER BY ASC(?sectionNumberLiteral)
```

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX c4o: <http://purl.org/spar/c4o/>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT DISTINCT ?sectionNumberLiteral AS ?Section, ?sectionTitleLiteral AS ?Title, ?reviewComment, ?aspect, ?posNeg, ?impact, ?actionNeeded, ?commentText
  WHERE {
    <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1> dcterms:title ?title ;  
      po:contains ?section .
    ?section a doco:Section ;
      po:containsAsHeader ?sectionNumber, ?sectionTitle .
    ?sectionNumber a doco:SectionLabel ;
      c4o:hasContent ?sectionNumberLiteral .
    ?sectionTitle a doco:SectionTitle ;
      c4o:hasContent ?sectionTitleLiteral .
    ?section (po:contains)* ?subpart .
    ?reviewComment a linkflows:ReviewComment ;
     linkflows:refersTo ?subpart.
    ?subpart a ?part .
    VALUES ?part { doco:Section doco:Paragraph }
    VALUES ?aspect { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
    ?reviewComment a ?aspect .
    VALUES ?posNeg { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
    ?reviewComment a ?posNeg .
    ?reviewComment linkflows:hasImpact ?impact .
    VALUES ?actionNeeded { linkflows:ActionNeededComment linkflows:SuggestionComment linkflows:NoActionNeededComment}
    ?reviewComment a ?actionNeeded .
    ?reviewComment linkflows:hasCommentText ?commentText .
  } ORDER BY ASC(?sectionNumberLiteral)
```

### total number of review comments

```
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT (COUNT(*) as ?reviewComments)
WHERE {
  ?s ?p linkflows:ReviewComment .
}
```

### review comments per article

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT *
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
  #<http://purl.org/np/RAq9AhYfJUi3yeiCm1zf8DmL_hPaXG7JayEC380WHYMK4#articleVersion1>
  #<http://purl.org/np/RA8GWEOa9M60KPWBvk012dBRZeOKKyjeNy3vYYJRTx5rw#articleVersion1>
    (po:contains)* ?section .

  ?reviewComment a linkflows:ReviewComment .
  ?reviewComment linkflows:refersTo  ?section .
}
```

### number of review comments per chosen article

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT COUNT(?reviewComment) AS ?noReviewComments
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
  #<http://purl.org/np/RAq9AhYfJUi3yeiCm1zf8DmL_hPaXG7JayEC380WHYMK4#articleVersion1>
  #<http://purl.org/np/RA8GWEOa9M60KPWBvk012dBRZeOKKyjeNy3vYYJRTx5rw#articleVersion1>
    (po:contains)* ?section .

  ?reviewComment a linkflows:ReviewComment .
  ?reviewComment linkflows:refersTo  ?section .
}
```

### number of review comments per article, per reviewer

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer (COUNT(?reviewComment) AS ?noReviewComments)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?reviewComment linkflows:refersTo ?part .

  GRAPH ?assertion { ?reviewComment a linkflows:ReviewComment . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer
```

### get the number of review comments for all sections of an article

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX deo: <http://purl.org/spar/deo/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX c4o: <http://purl.org/spar/c4o/>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?sectionNumber, ?sectionName, COUNT(?reviewComment) AS ?noReviewComments
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?section .

  ?section a doco:Section .
  ?section po:containsAsHeader ?sectionLabel, ?sectionTitle .
  ?sectionLabel a doco:SectionLabel ;
     c4o:hasContent ?sectionNumber.
  ?sectionTitle a doco:SectionTitle ;
     c4o:hasContent ?sectionName.

   ?reviewComment a linkflows:ReviewComment .
   ?reviewComment linkflows:refersTo  ?section .
} ORDER BY ?sectionNumber
```

### distribution of review comments

Distribution of part that they target per article:

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT *
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?section .

  ?reviewComment a linkflows:ReviewComment .
  ?reviewComment linkflows:refersTo  ?section .
}
```

### number of review comments that target different parts of an article

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?type, COUNT(?reviewComment) AS ?noReviewComments
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?section .

  ?reviewComment a linkflows:ReviewComment .
  ?reviewComment linkflows:refersTo  ?section .
  ?section a ?type .
} GROUP BY ?type
```

### distribution of positivity using UNION

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT (count(?pos) as ?poscount) (count(?neutr) as ?neutrcount) (count(?neg) as ?negcount)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  {
    ?pos linkflows:refersTo  ?part .
    ?pos a linkflows:PositiveComment .
  } UNION {
    ?neutr linkflows:refersTo  ?part .
    ?neutr a linkflows:NeutralComment .
  } UNION {
    ?neg linkflows:refersTo  ?part .
    ?neg a linkflows:NegativeComment .
  }
}
```

### distribution of positivity using VALUES

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?type (count(?c) AS ?typecount)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .

  VALUES ?type { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
  GRAPH ?assertion { ?c a ?type . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?type ?reviewer
```

### distribution of all review comment dimensions

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?article ?reviewer ?type (COUNT(DISTINCT ?c) AS ?typecount)
WHERE {
  ?article a doco:Article ;
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .

  GRAPH ?assertion { ?c a ?type . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?article ?reviewer ?type ORDER BY ?article ?reviewer ?type
```


### get total number of review comments per article

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?title, (COUNT(*) as ?sections), (COUNT(*) as ?paragraphs), (COUNT(*) as ?reviewComments)
WHERE {
  ?article a doco:Article ;
    (po:contains)* ?section ;
    dcterms:title ?title .

  ?reviewComment a linkflows:ReviewComment .
  ?reviewComment linkflows:refersTo  ?section .
} GROUP BY ?title
```

### Free-text queries on review comments:

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?article ?reviewcomment ?text
WHERE {
  ?article a doco:Article ;
    (po:contains)* ?part .
  ?reviewcomment linkflows:refersTo ?part .

  ?reviewcomment linkflows:hasCommentText ?text .
  ?text <bif:contains> "data" .
} GROUP BY ?article ?reviewcomment ORDER BY ?article ?reviewcomment
```

### Comments positive/negative per review for all articles:

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?article ?reviewer ?type (COUNT(DISTINCT ?c) AS ?typecount)
WHERE {
  ?article a doco:Article ;
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .

  VALUES ?type { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
  GRAPH ?assertion { ?c a ?type . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?article ?reviewer ?type ORDER BY ?article ?reviewer ?type
```

### Type of action needed:

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?type (COUNT(DISTINCT ?c) AS ?typecount)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .

  VALUES ?type { linkflows:ActionNeededComment linkflows:NoActionNeededComment linkflows:SuggestionComment }
  GRAPH ?assertion { ?c a ?type . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?type ORDER BY ?reviewer ?type
```

### Impact per reviewer:

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?impact (COUNT(DISTINCT ?c) AS ?typecount)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .

  GRAPH ?assertion { ?c linkflows:hasImpact ?impact . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?impact ORDER BY ?reviewer ?impact
```

## Queries for Competency Questions

### 1. What is the distribution of positive and negative comments per reviewer?

Comments positive/negative per review for a chosen article:

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?type (COUNT(DISTINCT ?c) AS ?typecount)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .

  VALUES ?type { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
  GRAPH ?assertion { ?c a ?type . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?type ORDER BY ?reviewer ?type
```

### 2. What is the nature of the review comments with respect to whether they address the content or the presentation of the article, and whether they refer to a specific paragraph or a larger structure such as a section or the whole article?

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?type (COUNT(DISTINCT ?c) AS ?typecount)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .

  VALUES ?type { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
  GRAPH ?assertion { ?c a ?type . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?type ORDER BY ?reviewer ?type
```

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT (COUNT(?reviewCommentArticle) AS ?commentsPerArticle) (COUNT(?reviewCommentSection) AS ?commentsPerSections) (COUNT(?reviewCommentParagraph) AS ?commentsPerParagraph) (COUNT(?reviewCommentFigure) AS ?commentsPerFigure) (COUNT(?reviewCommentTable) AS ?commentsPerTable) (COUNT(?reviewCommentFootnote) AS ?commentsPerFootnote) (COUNT(?reviewCommentFormula) AS ?commentsPerFormula)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?subpart .

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
}
```

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?level (COUNT(DISTINCT ?c) AS ?typecount)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .
  ?part a ?level .

  GRAPH ?assertion { ?c a ?type . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?level ORDER BY ?reviewer
```

# does not return anything now
```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT *
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .

  ?reviewComment a linkflows:ReviewComment .
  ?reviewComment linkflows:refersTo  ?part .

  VALUES ?type {doco:Article doco:Section doco:Paragraph doco:Figure doco:Table doco:Footnote doco:Formula}
  GRAPH ?assertion {?reviewComment a ?type} .
}
```


### 3. What are the critical points that were raised by the reviewers in the sense of negative comments with a high impact on the quality of the paper?

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer (COUNT(DISTINCT ?c) AS ?typecount)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .

  GRAPH ?assertion { ?c a linkflows:NegativeComment ; linkflows:hasImpact ?impact . }
  FILTER (?impact > "3"^^xsd:positiveInteger) .
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ORDER BY ?reviewer
```


### 4. How many points were raised that need to be addressed by the authors, as an estimate for the amount of work needed for a revision?

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer (COUNT(DISTINCT ?c) AS ?typecount)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .

  GRAPH ?assertion { ?c a linkflows:ActionNeededComment ; linkflows:hasImpact ?impact . }
  FILTER (?impact > "3"^^xsd:positiveInteger) .
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ORDER BY ?reviewer
```

### 5.  How do the review comments cover the different parts of the paper?

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?part (COUNT(DISTINCT ?c) AS ?commentcount)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?part (po:contains)* ?subpart .
  ?c linkflows:refersTo ?subpart .
  # ?part a doco:Section .

} GROUP BY ?part ORDER BY ?part
```

### 6.  Which parts of the paper seem controversial in the sense that they have both positive and negative comments?

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?type (COUNT(DISTINCT ?c) AS ?typecount)
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .

  VALUES ?type { linkflows:PositiveComment linkflows:NegativeComment }
  GRAPH ?assertion { ?c a ?type ; linkflows:hasImpact ?impact . }
  FILTER (?impact > "3"^^xsd:positiveInteger) .
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?reviewer ?type ORDER BY ?reviewer ?type
```
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

### Helper table data

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX c4o: <http://purl.org/spar/c4o/>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT DISTINCT ?sectionNumberLiteral AS ?Section, ?sectionTitleLiteral AS ?Title, ?reviewComment, ?aspect, ?posNeg, ?impact, ?actionNeeded, ?commentText
WHERE {
  <http://purl.org/np/RAnVHrB5TSxLeOc6XTVafmd9hvosbs4c-4Ck0XRh_CgGk#articleVersion1>
    dcterms:title ?title ;
    po:contains ?section .

  ?section a doco:Section ;
     po:containsAsHeader ?sectionNumber, ?sectionTitle .
  ?sectionNumber a doco:SectionLabel ;
     c4o:hasContent ?sectionNumberLiteral .
  ?sectionTitle a doco:SectionTitle ;
     c4o:hasContent ?sectionTitleLiteral .

  ?section (po:contains)* ?subpart.

  ?reviewComment a linkflows:ReviewComment ;
    linkflows:refersTo ?subpart.  

  ?subpart a ?part .
  VALUES ?part { doco:Section doco:Paragraph }

  VALUES ?aspect { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
  ?reviewComment a ?aspect .

  VALUES ?posNeg { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
  ?reviewComment a ?posNeg .

  ?reviewComment linkflows:hasImpact ?impact .

  VALUES ?actionNeeded { linkflows:ActionNeededComment linkflows:SuggestionComment linkflows:NoActionNeededComment}
  ?reviewComment a ?actionNeeded .

  ?reviewComment linkflows:hasCommentText ?commentText .

} ORDER BY ASC(?sectionNumberLiteral)
```
