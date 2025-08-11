#let fakesc(s, scaling: 0.75) = {
  show regex("\p{Ll}+"): it => {
    context text(scaling * 1em, stroke: 0.01em + text.fill, upper(it))
  }
  text(s)
}
#set page(
  paper: $if(papersize)$"$papersize$"$else$"us-letter"$endif$,
  margin: $if(margin)$($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$)$else$(x: 1.25in, y: 1.25in)$endif$,
  numbering: $if(page-numbering)$"$page-numbering$"$else$none$endif$,
  header: context if counter(page).get().first() > 1 {fakesc[
    $if(title-meta)$$title-meta$$else$$title$$endif$
    #h(1fr)
    $if(date)$$date$$endif$
    ]},
)
$if(logo)$
#set page(background: align($logo.location$, box(inset: $logo.inset$, image("$logo.path$", width: $logo.width$$if(logo.alt)$, alt: "$logo.alt$"$endif$))))
$endif$