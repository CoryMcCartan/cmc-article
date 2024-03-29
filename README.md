
# `cmc-article` Quarto Format

The `cmc-article` format is designed for scholarly articles, especially preprints.
Its goal is to be lightweight yet customizable, with thoughtful typography and layout.
Detailed word-counting functionality is also included.

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

## Example

Here is the source code for a minimal sample document: [template.qmd](template.qmd).
This produces the following document (click for a full preview):

<p align="center">
<a href="template.pdf">
<kbd> <img src="thumb.png" width=306 style="border: 1px solid #444"> </kbd>
</a>
</p>

## Word Counting

During rendering a table like the following will be included in the render log.

```
 WORD COUNT
-----------------------------------
 Section             Words   Cuml.
-----------------------------------
 Title                   6       
 Abstract              163    163
  (Introduction...)    609
  (Formalizing ...)   1305
[further section titles and word counts]
  (Conclusion  ...)    158
 Body                 2909   3072
 References            375   3447
 Appendices            428   3875
-----------------------------------
```

To exclude a block element (image or table caption, div, code block) or entire
section (demarcated by a header) from any word-counting, simply add the
`{.nowords}` class to the element. 


## Template Options

Most Quarto PDF options are supported here, with the primary exception of
alternative font families (see below for font customization)
and anything to do with CSL references.
Additional package-specific options are described below.

### Blinded versions

Provide the following key under `cmc-article-pdf` to produce a blinded version of the article.
```yaml
journal:
  blinded: true
```

### Physics package

By default, the [`physics`](http://mirrors.ibiblio.org/CTAN/macros/latex/contrib/physics/physics.pdf) package is included.
Provide the following key under `cmc-article-pdf` to remove it:
```yaml
physics: false
```

### Fonts

#### Serif font
The default serif font is Cochineal, based on the Crimson font family.
If you would rather not use this font, either for file size or aesthetic reasons, you can provide the following flag.
Palatino will be used instead for the body text and mathematics.
```yaml
font-serif-cochineal: false
```

#### Sans-serif font
The default sans-serif font is Biolinium, part of the `libertine` package.
If you would rather not use this font, either for file size or aesthetic reasons, you can provide the following flag.
Helvetica will be used instead.
```yaml
font-sans-biolinium: false
```

#### Serif title headings

By default, the title and section headings are set in a sans-serif font. 
Provide the following key under `cmc-article-pdf` to use a serif font:
```yaml
font-serif-only: true
```

