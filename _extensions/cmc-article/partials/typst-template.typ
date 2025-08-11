

#let article(
  title: none,
  subtitle: none,
  authors: none,
  blinded: false,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  lang: "en",
  region: "US",
  keywords: none,
  font: "libertinus serif",
  fontsize: 11pt,
  title-size: 2.0em,
  subtitle-size: 1.25em,
  heading-family: "libertinus serif",
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize,
           number-type: "old-style",
           )
  show math.equation: set text(number-type: "lining", number-width: "tabular")
  set heading(numbering: sectionnumbering)
  if title != none {
    align(center)[#block(inset: 2em)[
      #set par(leading: heading-line-height)
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
    if it.numbering == none {
        it
    } else {
        block(counter(heading).display(it.numbering) + h(1em) + it.body)
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
      columns: (30%,) * ncols,
      row-gutter: 1.5em,
      column-gutter: 0.1em,
      ..authors.map(author =>
          align(center)[
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

