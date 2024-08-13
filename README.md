


<!-- README.md is generated from README.Rmd. Please edit that file -->

# photoplate

<!-- badges: start -->
<!-- badges: end -->

The goal of photoplate is to customize stargazer::stargazer() regression
tables for inclusion in LaTeX documents. The example below illustrates
the functionality of the package.

Until the later 1980s, astronomers used glass photographic plates to
record their observations. These plates made it possible for them to
share what they saw when gazing toward the stars; in that spirit, this
package’s eponymous function is named “photoplate.”

<div class="figure" style="text-align: center">

<img src="auxiliaries/photographic_plate.jpeg" alt="A collection of glass plates from 1909 to 1922 capture the moon in different phases. Niels Bohr Institute, University of Copenhagen." width="75%" />
<p class="caption">
A collection of glass plates from 1909 to 1922 capture the moon in
different phases. Niels Bohr Institute, University of Copenhagen.
</p>

</div>

[Image source and more information about photographic
plates](https://www.smithsonianmag.com/science-nature/obsolete-art-mapping-skies-glass-plates-can-still-teach-us-180971890/)

## Installation

You can install the development version of photoplate from GitHub by
running the following:

``` r
# install.packages("pak")
pak::pak("imperialnolini/photoplate")
```

## Example

What follows is a walkthrough of how to use the package. We begin by
loading it:

``` r
library(photoplate)
```

Let’s estimate a linear model and reformat its stargazer LaTeX output.

We’ll estimate a model for y = b0 + b1*x1 + b2*x2 + e, where: \* b0 = 10
\* b1 = -20 \* b2 = 30 \* e = error following a uniform distribution
from 0.0001 to 1

We’ll generate 10000 datapoints for our analysis. Let’s sample with
replacement from 0 to 10000000 for x1 and x2, our two explanatory
variables, and from 0.0001 to 1 without replacement for e, our error.
Then, we’ll calculate values of y per the betas defined above. The data
generation:

``` r
base::set.seed(1)
x1 = sample(0:10000000, 10000, TRUE)
x2 = sample(0:10000000, 10000, TRUE)
e = sample(1:10000, 10000, FALSE, rep(1/10000, 10000))/10000
y = 10 + (-20*x1) + (30*x2) + e
```

We continue by estimating a model:

``` r
model <- lm(y ~ x1 + x2)
```

We can feed the model to stargazer::stargazer() to look at its results:

``` r
stargazer::stargazer(model,
                     title = "A table! With exclamation marks in the title!",
                     dep.var.labels = "Dependent variable we generated for testing",
                     add.lines = list(c("Was it fun to run this model?", "Yes")),
                     notes = c("This is a note.",
                               "Here's another note.",
                               "Could also have written one long note instead.",
                               "Just make sure each note has a period at the end."),
                     table.layout = "m=!ldc#-!t-!a-!s=!n",
                     type = "text")
#> 
#> A table! With exclamation marks in the title!
#> ===============================================================================
#>                                              Dependent variable:               
#>                               -------------------------------------------------
#>                                  Dependent variable we generated for testing   
#> -------------------------------------------------------------------------------
#> x1                                               -20.000***                    
#>                                                    (0.000)                     
#>                                                                                
#> x2                                                30.000***                    
#>                                                    (0.000)                     
#>                                                                                
#> Constant                                          10.491***                    
#>                                                    (0.008)                     
#>                                                                                
#> -------------------------------------------------------------------------------
#> Was it fun to run this model?                        Yes                       
#> -------------------------------------------------------------------------------
#> Observations                                       10,000                      
#> R2                                                  1.000                      
#> Adjusted R2                                         1.000                      
#> Residual Std. Error                           0.289 (df = 9997)                
#> F Statistic                   646,745,117,735,764,099,082.000*** (df = 2; 9997)
#> ===============================================================================
#> Note:                                               *p<0.1; **p<0.05; ***p<0.01
#>                                                                 This is a note.
#>                                                            Here's another note.
#>                                  Could also have written one long note instead.
#>                               Just make sure each note has a period at the end.
```

Note you should always check that form of textual output - especially if
you use the various stargazer::stargazer() parameters to format the
output (e.g., renaming things and/or adding notes, as done here) - prior
to using photoplate().

Having verified the model output seems fine by looking at that textual
output, it’s time to run photoplate() for real. This time, however, we
won’t pass in arguments for the “type” or “out” keyword parameters.

**Note any call to the function makes a .tex file (1) with the
stargazer::stargazer() LaTeX-formatted output from the first argument
minus the argument for a textual output (2) and with the position
parameter as whatever you pass in as the second argument (3) in a file
saved at the filepath given as the third argument (4) with the
LaTeX-internal label of what you enter for the fourth argument (for
cross-referencing purposes). The function call will also return the save
filepath.**

Let’s run it:

``` r
photoplate(
  this_stargazer = stargazer::stargazer(
    model,
    title = "A table! With exclamation marks in the title!",
    dep.var.labels = "Dependent variable we generated for testing",
    add.lines = list(c("Was it fun to run this model?", "Yes")),
    notes = c("This is a note.",
              "Here's another note.",
              "Could also have written one long note instead.",
              "Just make sure each note has a period at the end."),
    table.layout = "m=!ldc#-!t-!a-!s=!n"),
  position = "!h",
  filepath = "auxiliaries/example_output.tex",
  label = "model_output_label_for_crossref"
  )
#> [1] "Saved .tex file to: auxiliaries/example_output.tex"
```

All done! Let’s look at the LaTeX rendering of the photoplate() LaTeX
table we made (see [here](auxiliaries/latex_file.tex) for the .tex file
used to create this document and [here](auxiliaries/latex_file.pdf) for
the PDF of it):

<img src="auxiliaries/latex_file_image.jpg" width="75%" style="display: block; margin: auto;" />

## Notes about the function’s parameters

- *this_stargazer*: Call of stargazer::stargazer() on regression model
  output(s). DO NOT enter arguments for the keyword parameters “type”
  and “out” (though technically it’s ok to have values for them which
  would yield a latex output, but it’s probably easier to leave them out
  entirely).

- *position*: String. Position parameter for the table in LaTeX - e.g.,
  “h”, “t”, “b”, “p”, “!”, “H”. Note “!h” is similar (though not
  necessarily identical to) “H” and using “H” is possible only if you
  first load the “float” package in your LaTeX document’s preamble.

- *filepath*: String. Filepath on your computer where you want the final
  .tex file to save; include ending of “filename.tex” for the filename
  and file extension. For example, “path/to/folder/filename.tex” would
  be fine.

- *label*: String. LaTeX-internal label for the table. Can use it for
  cross referencing.

## Additional notes

Note this function was made with the intention to use it only for
stargazer::stargazer() calls on regression models, though the
stargazer::stargazer() function can do more than only format estimated
models.

For the stargazer::stargazer() call in photoplate(), there is no need to
specify anything for the “type” or “out” parameters, though you can use
the other parameters to change the default output of the function. It is
worth verifying the output looks good by generating a textual output
before running photoplate().

For more information about LaTeX table position parameters, please see
LaTeX’s documentation.
