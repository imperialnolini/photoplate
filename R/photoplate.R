photoplate <- function(this_stargazer, #test by running with text output first
                       position, #enter as string
                       filepath, #don't forget the ".tex" extension
                       label #enter as string
                       ){

  # s is stargazer output
  s <- capture.output(
    this_stargazer
  )

  # Make changes for position
  changes = c("[!htbp]" = glue("[{position}]"))
  # Position options (per https://stackoverflow.com/a/55863947):
  # -h Place the float here, i.e., approximately at the same point it occurs in the source text (however, not exactly at the spot)
  # -t Position at the top of the page.
  # -b Position at the bottom of the page.
  # -p Put on a special page for floats only.
  # -! Override internal parameters LaTeX uses for determining "good" float positions.
  # -H Places the float at precisely the location in the LATEX code. Requires the float package. This is somewhat equivalent to h!.

  # f is first pass at fixing output
  f <- gsub(names(changes), paste(changes), s, fixed = T)
  write_lines(f, filepath)

  # Read in saved output and manipulate dataframe
  # h is effectively f with rownums
  h <- read.delim2(filepath, header = F, sep = "\n", dec = ".") %>%
    dplyr::mutate(rownum = row_number())

  # Find rownum for \label() line
  label_row <- h %>%
    filter(grepl("label", V1)) %>%
    tail(1) %>%
    select(rownum) %>%
    as.integer()

  # Find rownum for last line before comment
  precomment_row <- h %>%
    filter(grepl("hline.*-1.8ex]", V1)) %>%
    tail(1) %>%
    select(rownum) %>%
    as.integer()

  # Find rownum for end of tabular environment
  postcomment_row <- h %>%
    filter(grepl("end\\{tabular", V1)) %>%
    tail(1) %>%
    select(rownum) %>%
    as.integer()

  # Rows with comment
  comment_rows <- (precomment_row + 1) : (postcomment_row - 1)

  # Pull comment
  comment = c("\\textit{Note:}")
  for (this_rownum in comment_rows) {
    this_row <- h %>% filter(rownum == this_rownum) %>% select(V1)
    # print(this_row)
    this_row <- this_row %>%
      # FOR P-VALUES:
      # Remove "\\textit{Note:}  & \\multicolumn{4}{r}{"
      str_replace("\\\\textit\\{Note:\\} *& *\\\\multicolumn\\{\\d+\\}\\{r\\}\\{",
                  "") %>%
      # Replace "} \\\\ " with "."
      str_replace("\\} *\\\\\\\\* *",
                  ".") %>%

      # FOR TEXT COMMENTS MANUALLED ADDED IN STARGAZER:
      # Remove " & \\multicolumn{4}{r}{"
      str_replace(" *& *\\\\multicolumn\\{\\d+\\}\\{r\\}\\{",
                  "") %>%
      # Remove "} \\\\"
      str_replace("\\} *\\\\\\\\* *",
                  "")

    # Could have ".." for last two characters because added period to p-values;
    # if that's the case, remove second period.
    if (str_sub(this_row, start = -2) == "..") {
      this_row <- str_sub(this_row, end = -2)
    }
    comment <- comment %>% paste(this_row)
  }

  # Save final file
  write_lines(c(
    apply(h %>% filter(rownum %in% 1 : (label_row - 1)) %>% select(V1),
          1, paste0, collapse = ""),
    paste0("  \\label{", label, "}"), #TO-DO: make customizable
    "  \\footnotesize",
    apply(h %>% filter(rownum %in% (label_row + 1) : precomment_row) %>% select(V1),
          1, paste0, collapse = ""),
    # Add two slashes (when back in Latex) to end of "\end{tabular} " line
    # Better to code that explicitly given I know that's what the line will/ should be?
    paste0(
      apply(h %>% filter(rownum %in% postcomment_row) %>% select(V1),
            1, paste0, collapse = ""),
      "\\\\"
    ),
    "\\footnotesize",
    paste0("\\caption*{\\footnotesize \\centering ", comment, "}"),
    apply(h %>% filter(rownum %in% (postcomment_row + 1) : nrow(h)) %>% select(V1),
          1, paste0, collapse = "")
  ),
  filepath)

}



