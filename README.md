
# <%= title %>

## Creating a New Article

To create a new article using this format:

```bash
quarto use template CoryMcCartan/<%= filesafename %>
```

This will create a new directory with an example document that uses this format.

## Using with an Existing Document

To add this format to an existing document:

```bash
quarto add CoryMcCartan/<%= filesafename %>
```

Then, add the format to your document options:

```yaml
format:
  <%= filesafename %>-pdf: default
```    

## Options

*TODO*: If your format has options that can be set via document metadata, describe them.

### To change the font 

### To change the font size


## Example

Here is the source code for a minimal sample document: [template.qmd](template.qmd).

