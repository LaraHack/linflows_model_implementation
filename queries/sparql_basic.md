# Competency Question as SPARQL Queries

## General Queries

### get total number of triples in the ts

output: 2955

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
  ?s ?p doco:Paragraph #doco:Section
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
  <http://purl.org/np/RAC2uy68IF6HASObYpPo0r9sLIwt3XXDU7Yd8QtyKpwI0#articleVersion1>
    (po:contains)* ?section .

  ?reviewComment a linkflows:ReviewComment .
  ?reviewComment linkflows:refersTo  ?section .
}
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
  <http://purl.org/np/RAC2uy68IF6HASObYpPo0r9sLIwt3XXDU7Yd8QtyKpwI0#articleVersion1>
    (po:contains)* ?section .

  ?reviewComment a linkflows:ReviewComment .
  ?reviewComment linkflows:refersTo  ?section .
}
```

Distribution of positivity using UNION:

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT (count(?pos) as ?poscount) (count(?neutr) as ?neutrcount) (count(?neg) as ?negcount)
WHERE {
  <http://purl.org/np/RAC2uy68IF6HASObYpPo0r9sLIwt3XXDU7Yd8QtyKpwI0#articleVersion1>
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

Distribution of positivity using VALUES:

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX po: <http://www.essepuntato.it/2008/12/pattern#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewer ?type (count(?c) AS ?typecount)
WHERE {
  <http://purl.org/np/RAC2uy68IF6HASObYpPo0r9sLIwt3XXDU7Yd8QtyKpwI0#articleVersion1>
    (po:contains)* ?part .
  ?c linkflows:refersTo ?part .

  VALUES ?type { linkflows:PositiveComment linkflows:NeutralComment linkflows:NegativeComment }
  GRAPH ?assertion { ?c a ?type . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?type ?reviewer
```

Distribution of all review comment dimension using VALUES:

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

## Queries for Competency Questions

### 1. How many comments were positive/negative per review?

output;  14 negative, 0 positive, 4 neutral

```
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT (COUNT(*) as ?reviewComments)
WHERE {
  ?s a linkflows:NegativeComment #positiveComment
}
```

### 2. How many negative review comments had an impact higher than 3?

```
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewComment
WHERE {
  ?reviewComment a linkflows:NegativeComment .
  ?reviewComment linkflows:hasImpact ?impact .
  FILTER (?impact > "3"^^xsd:positiveInteger) .
}
```

### 3. Which reviewer focused more on content/style/syntax?

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

  VALUES ?type { linkflows:SyntaxComment linkflows:StyleComment linkflows:ContentComment }
  GRAPH ?assertion { ?c a ?type . }
  ?assertion prov:wasAttributedTo ?reviewer .
} GROUP BY ?article ?reviewer ?type ORDER BY ?article ?reviewer ?type
```

### 4. Comparing papers: which of the papers was more controversial?

### 5. Which part is most (positively/negatively) commented?

### 6. {How many high impact comments that needed to be addressed were not addressed?}

### 7. What are important points that need fixing?

```
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?reviewComment
WHERE {
  ?reviewComment a linkflows:ActionNeeded .
  ?reviewComment linkflows:hasImpact ?impact .
  FILTER (?impact > "3"^^xsd:positiveInteger) .
}
```
