#' Customize stargazer::stargazer() regression tables for inclusion in LaTeX documents.
#'
#' @param stargazer_call Call of stargazer::stargazer() on regression model output(s).
#' @param position String. Position parameter for the table in LaTeX - e.g., "h", "t", "b", "p", "!", "H". Note "!h" is similar (though not necessarily identical to) "H" and using "H" is possible only if you first load the "float" package in your LaTeX document's preamble.
#' @param label String. LaTeX-internal label for the table. Can use it for cross referencing.
#' @param filepath String. Filepath on your computer where you want the final .tex file to save; include ending of "filename.tex" for the filename and file extension. For example, "path/to/folder/filename.tex" would be fine.
#'
#' @return Returns a string message with the filepath to the .tex file with your LaTeX-customized regression model output.
#' @export
#'
#' @details
#' Until the later 1980s, astronomers used glass photographic plates to record their observations. These plates made it possible for them to share what they saw when gazing toward the stars; in that spirit, this package's eponymous function is named "photoplate."
#'
#' Note this function was made with the intention to use it only for stargazer::stargazer() calls on regression models, though the stargazer::stargazer() function can do more than only format estimated models.
#'
#' For the stargazer::stargazer() call in photoplate(), there is no need to specify anything for the "type" or "out" parameters, though you can use the other parameters to change the default output of the function. It is worth verifying the output looks good by generating a textual output before running photoplate().
#'
#' For more information about LaTeX table position parameters, please see LaTeX's documentation.
#'
#'
#' @examples
#' ## Let's estimate a linear model and reformat its stargazer LaTeX output.
#'
#' ## We'll estimate a model for y = b0 + b1*x1 + b2*x2 + e, where:
#' ##  - b0 = 10
#' ##  - b1 = -20
#' ##  - b2 = 30
#' ##  - e = error following a uniform distribution from 0.0001 to 1
#'
#' ## We begin by generating 10000 datapoints (let's sample with replacement
#' ## from 0 to 10000000 for x1 and x2 and from 0 to 1 without replacement for e
#' ## then calculate values of y per the betas defined above):
#' base::set.seed(1)
#' x1 = sample(0:10000000, 10000, TRUE)
#' x2 = sample(0:10000000, 10000, TRUE)
#' e = sample(1:10000, 10000, FALSE, rep(1/10000, 10000))/10000
#' y = 10 + (-20*x1) + (30*x2) + e
#'
#' ## We continue by estimating a model:
#' model <- lm(y ~ x1 + x2)
#'
#' ## We can feed the model to stargazer::stargazer() to look at its results:
#' stargazer::stargazer(model,
#'                      title = "A table! With exclamation marks in the title!",
#'                      dep.var.labels = "Dependent variable we generated for testing",
#'                      add.lines = list(c("Was it fun to run this model?", "Yes")),
#'                      notes = c("This is a note ending in a period.",
#'                                "Here's another note.",
#'                                "Could also have written one long note instead.",
#'                                "About to end a note with --, and-- right here:, and",
#'                                "just so I can pick up that sentence on a new line.",
#'                                "We see there isn't a new period after the --and-- from that line.",
#'                                "Ending lines in other ways may add an extra period at the end."),
#'                      table.layout = "m=!ldc#-!t-!a-!s=!n",
#'                      type = "text")
#'
#' ## Note you should always check that form of textual output - especially
#' ## if you use the various stargazer::stargazer() parameters to format the
#' ## output (e.g., renaming the variables) - prior to using photoplate().
#'
#' ## For this example, we'll save the .tex file in your computer's temporary
#' ## directory with a name similar to "photoplate_example" and ".tex" as the
#' ## file's extension. When using the package for real, it's worth being more
#' ## intentional about where to save regression output tables; this is for the
#' ## sake of illustration. Let's generate that save filepath:
#' save_path = tempfile(pattern = "photoplate_example",
#'                      fileext = ".tex",
#'                      tmpdir = tempdir(check = TRUE))
#'
#' ## Returning to the model output, having verified it seems fine by looking at
#' ## the textual output earlier, it's time to run photoplate() for real.
#'
#' ## Note any call to the function makes a .tex file (1) with the
#' ## stargazer::stargazer() LaTeX-formatted output from the first argument
#' ## minus the argument for a textual output (2) and with the position
#' ## parameter as whatever you pass in as the second argument (3) in a file
#' ## saved at the filepath given as the third argument (4) with the
#' ## LaTeX-internal label of what you enter for the fourth argument (for
#' ## cross-referencing purposes). The function call will also return the save
#' ## filepath.
#'
#' ## Let's run it:
#' photoplate(
#'   stargazer::stargazer(
#'     model,
#'     title = "A table! With exclamation marks in the title!",
#'     dep.var.labels = "Dependent variable we generated for testing",
#'     add.lines = list(c("Was it fun to run this model?", "Yes")),
#'     notes = c("This is a note ending in a period.",
#'               "Here's another note.",
#'               "Could also have written one long note instead.",
#'               "About to end a note with --, and-- right here:, and",
#'               "just so I can pick up that sentence on a new line.",
#'               "We see there isn't a new period after the --and-- from that line.",
#'               "Ending lines in other ways may add an extra period at the end."),
#'     table.layout = "m=!ldc#-!t-!a-!s=!n"),
#'   position = "!h",
#'   label = "model_output_label_for_crossref",
#'   filepath = save_path
#'   )
#'  ## In general, the function seems to work best when you DON'T include
#'  ## "stargazer_call =" in the function call, so best to leave that out and
#'  ## simply enter the stargazer call as the first parameter without explicitly
#'  ## identifying it. Also, you may get an extra period in your comment if you
#'  ## end a line in something other than a period or --, and-- in the case of
#'  ## splitting a compound sentence across separate elements in the notes()
#'  ## parameter of stargazer::stargazer().  Also note the usual comment of the
#'  ## keys for stars re: p-value significance levels will be at the end of the
#'  ## comment. Future versions of this package may make an option to suppress
#'  ## that line in case you don't want to include p-values and their
#'  ## corresponding significance stars in your output (e.g., if you'd prefer
#'  ## to include standard errors with no stars instead).
#'
#'  ## Running the function like this will return something like the following:
#'  ## "Saved .tex file to: **temporary directory**\photoplate_example.tex"
#'
#'  ## All done! The file is there, and it compiles correctly in LaTeX. To
#'  ## conclude, we can remove that example file from the temporary
#'  ## directory, though normally we would keep it for use when writing.
#'  file.remove(save_path)
photoplate <- function(stargazer_call, #stargazer::stargazer() call on regression model(s)
                       position, #enter as string
                       label, #enter as string
                       filepath #don't forget the ".tex" extension
                       ){

  # s is stargazer output
  s <- utils::capture.output(
    stargazer_call
  )

  # Make changes for position
  changes = c("[!htbp]" = glue::glue("[{position}]"))

  # f is first pass at fixing output
  f <- base::gsub(names(changes), base::paste(changes), s, fixed = T)
  readr::write_lines(f, filepath)

  # Read in saved output and manipulate dataframe
  # h is effectively f with rownums
  h <- utils::read.delim2(filepath, header = F, sep = "\n", dec = ".") %>%
    dplyr::mutate(rownum = dplyr::row_number())

  # Add row at top with info about version of photoplate() used
  h <- base::rbind(tibble::tribble(~V1, ~rownum,
                                   "% Edits to stargazer::stargazer() table made by photoplate::photoplate() v.0.0.0.9000 by Nolan Siegel, nolan.s.siegel at gmail.com", 0),
                   h)

  # Get name of column with model information
  latex_column <- colnames(h)[1]

  # Find rownum for \label() line
  label_row <- h %>%
    dplyr::filter(base::grepl("label", !!base::as.name(latex_column))) %>%
    utils::tail(1) %>%
    dplyr::select(rownum) %>%
    as.integer()

  # Find rownum for last line before comment
  precomment_row <- h %>%
    dplyr::filter(base::grepl("hline.*-1.8ex]", !!base::as.name(latex_column))) %>%
    utils::tail(1) %>%
    dplyr::select(rownum) %>%
    as.integer()

  # Find rownum for end of tabular environment
  postcomment_row <- h %>%
    dplyr::filter(base::grepl("end\\{tabular", !!base::as.name(latex_column))) %>%
    utils::tail(1) %>%
    dplyr::select(rownum) %>%
    as.integer()

  # Rows with comment
  # Note: row at (precomment_row + 1) is key for p-value stars. Want that at the
  # end of the table's comment, so looking at comment rows in these two pieces.
  # Later, may want to add new parameter for if don't want p-values so look from
  # (precomment_row + 1) to (postcomment_row - 1) without moving first row to end
  # (but will have to test and see how to turn off stargazer stars and p-value
  # stars key in comment). If make that change, update "Future versions of this
  # package may make an option to suppress ..." bit in README and documentation.
  comment_rows <- c(
    (precomment_row + 2) : (postcomment_row - 1),
    (precomment_row + 1)
    )

  # Pull comment
  comment = c("\\textit{Note:}")
  for (this_rownum in comment_rows) {
    this_row <- h %>% dplyr::filter(rownum == this_rownum) %>% dplyr::select(!!base::as.name(latex_column))
    # print(this_row)
    this_row <- this_row %>%
      # FOR P-VALUES:
      # Remove "\\textit{Note:}  & \\multicolumn{4}{r}{"
      stringr::str_replace("\\\\textit\\{Note:\\} *& *\\\\multicolumn\\{\\d+\\}\\{r\\}\\{",
                           "") %>%
      # Replace "} \\\\ " with "."
      stringr::str_replace("\\} *\\\\\\\\* *",
                           ".") %>%

      # FOR TEXT COMMENTS MANUALLY ADDED IN STARGAZER:
      # Remove " & \\multicolumn{4}{r}{"
      stringr::str_replace(" *& *\\\\multicolumn\\{\\d+\\}\\{r\\}\\{",
                           "") %>%

      # Remove "} \\\\"
      stringr::str_replace("\\} *\\\\\\\\* *",
                           "")

    # Could have ".." for last two characters because added period to p-values;
    # if that's the case, remove second period.
    if (stringr::str_sub(this_row, start = -2) == "..") {
      this_row <- stringr::str_sub(this_row, end = -2)
    }
    comment <- comment %>% base::paste(this_row)
  }

  # FOR ENDING INDIVIDUAL COMMENT LINES WITH ", and":
  # Adding periods at line breaks may result in periods being added to comments,
  # such as "xxxx , and. xxxx" if one comment line ends with ", and"; want
  # to avoid having extra periods.
  comment <- comment  %>% stringr::str_replace(", and. ", ", and ")

  # Save final file
  readr::write_lines(c(
    base::apply(h %>% dplyr::filter(rownum %in% 0 : (label_row - 1)) %>% dplyr::select(!!base::as.name(latex_column)),
                1, base::paste0, collapse = ""),
    base::paste0("  \\label{", label, "}"),
    "  \\footnotesize",
    base::apply(h %>% dplyr::filter(rownum %in% (label_row + 1) : precomment_row) %>% dplyr::select(!!base::as.name(latex_column)),
                1, base::paste0, collapse = ""),
    # Add two slashes (when back in Latex) to end of "\end{tabular} " line
    # Necessary to do this given that's what the line will/ should be?
    base::paste0(
      base::apply(h %>% dplyr::filter(rownum %in% postcomment_row) %>% dplyr::select(!!base::as.name(latex_column)),
                  1, base::paste0, collapse = ""),
      "\\\\"
    ),
    "\\footnotesize",
    paste0("\\caption*{\\footnotesize \\centering ", comment, "}"),
    base::apply(h %>% dplyr::filter(rownum %in% (postcomment_row + 1) : nrow(h)) %>% dplyr::select(!!base::as.name(latex_column)),
                1, base::paste0, collapse = "")
  ),
  filepath)

  # Confirmation message
  base::print(base::paste("Saved .tex file to:", filepath))

}



