#' Customize stargazer::stargazer() regression tables for inclusion in LaTeX documents.
#'
#' @param this_stargazer Call of stargazer::stargazer() on regression model output(s).
#' @param position String. Position parameter for the table in LaTeX - e.g., "h", "t", "b", "p", "!", "H". Note "!h" is similar (though not necessarily identical to) "H" and using "H" is possible only if you first load the "float" package in your LaTeX document's preamble.
#' @param filepath String. Filepath on your computer where you want the final .tex file to save; include ending of "filename.tex" for the filename and file extension. For example, "path/to/folder/filename.tex" would be fine.
#' @param label String. LaTeX-internal label for the table. Can use it for cross referencing.
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
#' stargazer::stargazer(model, type = "text")
#'
#' ## Note you should always check that form of textual output - especially
#' ## if you use the various stargazer::stargazer() parameters to format the
#' ## output (e.g., renaming the variables) - prior to using photoplate().
#'
#' ## For this example, we'll save the .tex file in your temporary directory.
#' ## Let's get that save filepath:
#' save_path = tempfile(pattern = "photoplate_example",
#'                      fileext = ".tex",
#'                      tmpdir = tempdir(check = TRUE))
#' ## This code says we want a filename that's close to "photoplate_example" and
#' ## has ".tex" as its extension, and we want it to go in your computer's
#' ## temporary directory.
#'
#' ## Having verified that model output seems fine, we feed it to photoplate()
#' ## with arguments for the additional parameters:
#' photoplate(
#'    stargazer::stargazer(model),
#'    "!h",
#'    save_path,
#'    "model_output_label_for_crossref"
#'    )
#'
#'  ## That code will make a .tex file with the stargazer::stargazer() output
#'  ## of the model we estimated and with "!h" as the table format argument.
#'  ## That file will save in your temporary directory with a filename like
#'  ## "photoplate_example.tex" and with "model_output_label_for_crossref"
#'  ## as its LaTeX-internal label for cross-referencing. When you run the
#'  ## function for real, you should specify the directory where you want the
#'  ## file to save and include the specific name you would like for the file.
#'
#'  ## Running the function like this will return something like the following:
#'  ## "Saved .tex file to: **temporary directory**\photoplate_example.tex"
#'
#'  ## To conclude, we remove that example file from your temporary directory:
#'  file.remove(save_path)
photoplate <- function(this_stargazer, #stargazer::stargazer() call on regression model(s)
                       position, #enter as string
                       filepath, #don't forget the ".tex" extension
                       label #enter as string
                       ){

  # s is stargazer output
  s <- utils::capture.output(
    this_stargazer
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
  comment_rows <- (precomment_row + 1) : (postcomment_row - 1)

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

      # FOR TEXT COMMENTS MANUALLED ADDED IN STARGAZER:
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

  # Save final file
  readr::write_lines(c(
    base::apply(h %>% dplyr::filter(rownum %in% 1 : (label_row - 1)) %>% dplyr::select(!!base::as.name(latex_column)),
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



