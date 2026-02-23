#let article(
  title: none,
  subtitle: none,
  authors: none,
  keywords: none,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: "libertinus serif",
  fontsize: 11pt,
  title-size: 2.0em,
  subtitle-size: 1.25em,
  heading-family: "libertinus serif",
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  mathfont: none,
  codefont: none,
  linestretch: 1,
  sectionnumbering: none,
  number-depth: 3,
  linkcolor: none,
  citecolor: none,
  urlcolor: none,
  filecolor: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  set document(title: title, keywords: content-to-string(keywords.join(", ")))
  set document(
    author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()
  set par(
    justify: true,
    leading: linestretch * 0.65em
  )
  set text(
    lang: lang,
    region: region,
    size: fontsize,
    number-type: "old-style",
  )
  set text(font: font) if font != none
  show math.equation: set text(number-type: "lining", number-width: "tabular")
  show math.equation: set text(font: mathfont) if mathfont != none

  set heading(numbering: sectionnumbering)

  show ref: this => {
    if (citecolor != none and this.element == none) {
      text(this, fill: rgb(content-to-string(citecolor)))
    } else if (linkcolor != none and this.form != none) {
      text(this, fill: rgb(content-to-string(linkcolor)))
    } else {
      text(this)
    }
  }
  show link: this => {
    if filecolor != none and type(this.dest) == label {
      text(this, fill: rgb(content-to-string(filecolor)))
    } else if urlcolor != none and type(this.dest) == str {
      text(this, fill: rgb(content-to-string(urlcolor)))
    } else if (linkcolor != none) {
      text(this, fill: rgb(content-to-string(linkcolor)))
    } else {
      text(this)
    }
  }

  if title != none {
    align(center)[#block(inset: 2em)[
      #set par(leading: heading-line-height, justify: false)
      #set text(hyphenate: false)
      #if (heading-family != none or heading-weight != "bold" or heading-style != "normal"
           or heading-color != black) {
        set text(font: heading-family, weight: heading-weight, style: heading-style, fill: heading-color)
        text(size: title-size)[#title]
        if subtitle != none {
          parbreak()
          text(size: subtitle-size)[#subtitle]
        }
      } else {
        text(weight: "bold", size: title-size)[#title]
        if subtitle != none {
          parbreak()
          text(weight: "bold", size: subtitle-size)[#subtitle]
        }
      }
    ]]
  }
  show heading: it => {
    set text(font: heading-family, weight: heading-weight, style: heading-style,
             fill: heading-color, number-type: "lining")
    if (it.depth <= 3) {
      if it.numbering == none or it.depth > number-depth {
          block(it.body, inset: (top: 0.05em, bottom: 0.25em))
      } else {
          block(
            counter(heading).display(it.numbering) + h(1em) + it.body,
            inset: (top: 0.05em, bottom: 0.25em)
          )
      }
    } else {
      if it.numbering == none or it.depth > number-depth {
          it.body + h(1em)
      } else {
          counter(heading).display(it.numbering) + h(1em) + it.body + h(1em)
      }
    }
  }

  show figure.caption: it => [
    #set text(size: 0.9em, font: heading-family, number-type: "lining")
    // Bold the label part, regular text for the caption
    #context [#strong[#it.supplement #it.counter.display()]#it.separator #it.body]
  ]

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    align(center, grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      column-gutter: 0.1em,
      ..authors.map(author =>
          align(center)[
            #set text(hyphenate: false)
            #author.name \
            #author.affiliation
          ]
      )
    ))
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #v(-2em) // matching `inset`
    #set text(size: 0.9em)
    #align(center)[#text(weight: "semibold", font: heading-family)[#abstract-title]]
    #v(-0.25em)
    #abstract
    ]
  }
  if keywords != none {
    v(-2em) // should match `inset` of abstract block
    box(text(weight: 700, font: heading-family)[#skew(ax: -15deg)[Keywords]])
    h(1em)
    keywords.join(" " + sym.bullet + " ")
    v(0.5em)
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none
)
#let NormalTok(s) = text(fill: rgb("#000000"),raw(s))
