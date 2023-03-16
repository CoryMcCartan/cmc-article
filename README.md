
# `cmc-article` Quarto Format

## Creating a New Article

To create a new article using this format:

```bash
quarto use template CoryMcCartan/cmc-article
```

This will create a new directory with an example document that uses this format.

## Using with an Existing Document

To add this format to an existing document:

```bash
quarto add CoryMcCartan/cmc-article
```

Then, add the format to your document options:

```yaml
format:
  cmc-article-pdf: default
```    

## Options

Most Quarto PDF options are supported here, with the primary exception of
alternative font families and anything to do with CSL references or `biblatex`.
Additional package-specific options are described below.

### Blinded versions

Provide the following key under `cmc-article-pdf` to produce a blinded version of the article.
```yaml
journal:
  blinded: true
```

### Serif title headings

By default, the title and section headings are set in a sans-serif font. 
Provide the following key under `cmc-article-pdf` to use a serif font:
```yaml
serif-only: true
```

### Physics package

By default, the [`physics`](http://mirrors.ibiblio.org/CTAN/macros/latex/contrib/physics/physics.pdf) package is included.
Provide the following key under `cmc-article-pdf` to remove it:
```yaml
physics: false
```

### To change the font 

### To change the font size

## Example

Here is the source code for a minimal sample document: [template.qmd](template.qmd).

