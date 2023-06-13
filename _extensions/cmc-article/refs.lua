-- Move references and handle appendices

seen_app = false
seen_div = false

local proc_app = function(el) 
  if el.attr.classes:includes("appendix") and not seen_app then
    seen_app = true
    if quarto.doc.isFormat("latex") then
      if not seen_div then
        return pandoc.List({
          pandoc.RawInline("latex", "\\hypertarget{refs}{}\n"),
          pandoc.RawInline("latex", "\\begin{CSLReferences}{0}{0}\\end{CSLReferences}\n\n"),
          pandoc.RawBlock("latex", "\\appendix\n"),
          el
        })
      else
        return pandoc.List({
          pandoc.RawBlock("latex", "\\appendix\n"),
          el
        })
      end
    end
  end
end

local proc_div = function(el) 
  if quarto.doc.isFormat("latex") and el.attr.identifier == "refs" then
    seen_div = true
    return pandoc.List({
      pandoc.RawInline("latex", "\\hypertarget{refs}{}\n"),
      pandoc.RawInline("latex", "\\begin{CSLReferences}{0}{0}\\end{CSLReferences}\n\n"),
    })
  end
end

return {
  { Div = proc_div },
  { Header = proc_app }
}
