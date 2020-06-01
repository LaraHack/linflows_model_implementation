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

### get total number of articles, paragraphs, sections, comments, tables, figures, etc.

```
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX linkflows: <https://github.com/LaraHack/linkflows_model/blob/master/Linkflows.ttl#>

SELECT ?part COUNT(?s) AS ?noS
WHERE {
  VALUES ?part {doco:Paragraph doco:Section doco:Article doco:Figure doco:Table doco:Formula doco:Footnote linkflows:ReviewComment}
  ?s ?p ?part .
} GROUP BY ?part
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

###  maximum and average number of comments on a paragraph


### ow many paragraphs are 0, 1, 2,3, etc. times linked from a review comment?
