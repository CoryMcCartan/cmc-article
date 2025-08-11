$page.typ()$

// Modified from <https://github.com/quarto-dev/quarto-cli/blob/main/src/resources/formats/typst/pandoc/quarto/typst-show.typ>
// to add support for:
// - more complex author affiliations TODO
// - short titles TODO
// - font options
#show: doc => article(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(journal.blinded)$
  authors: (( name: [Anonymzied Authors], affiliation: [], email: [], ), ),
$else$
$if(by-author)$
  authors: (
$for(by-author)$
$if(it.name.literal)$
    (
      name: [*$it.name.literal$*$if(it.attributes.corresponding)$#footnote(numbering: "*")[
        To whom correspondence should be addressed.
        $if(it.email)$Email: #link("mailto:$it.email$".replace("\\", ""), raw("$it.email$".replace("\\", ""))).$endif$
        $if(it.url)$Website: #link("$it.url$".replace("\\", ""), raw("$it.url$".replace("\\", ""))).$endif$
        $for(it.affiliations/first)$$if(it.address)$Address:
        $it.address$, $it.city$, $if(it.region)$$it.region$$else$$it.country$$endif$ $it.postal-code$.
        $endif$$endfor$$if(thanks)$$thanks$$endif$
        ]$endif$],
      affiliation: [
        $for(it.affiliations)$$if(it.department)$$it.department$\ $endif$
        $if(it.name)$$it.name$$endif$
        #v(2pt)$endfor$
      ],
    ),
$endif$
$endfor$
    ),
$endif$
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(abstract)$
  abstract: [$abstract$],
  abstract-title: "$labels.abstract$",
$endif$
$if(keywords)$
  keywords: ($for(keywords)$[$keywords$]$sep$, $endfor$),
$endif$
$if(font-serif-crimson)$
  font: ("Cochineal",),
$elseif(mainfont)$
  font: ("$mainfont$",),
$else$
  font: ("Palatino",),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(title)$
$if(font-headings-sans)$
$if(font-sans-biolinum)$
  heading-family: ("Linux Biolinum", "Helvetica", "Arial",),
$else$
  heading-family: ("Helvetica", "Arial",),
$endif$
$else$
$if(font-serif-crimson)$
  heading-family: ("Cochineal",),
$elseif(mainfont)$
  heading-family: ("$mainfont$",),
$else$
  heading-family: ("Palatino",),
$endif$
$endif$
  heading-weight: "bold",
$endif$
$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$
$if(toc)$
  toc: $toc$,
$endif$
$if(toc-title)$
  toc_title: [$toc-title$],
$endif$
$if(toc-indent)$
  toc_indent: $toc-indent$,
$endif$
  toc_depth: $toc-depth$,
  cols: $if(columns)$$columns$$else$1$endif$,
  doc,
)