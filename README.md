
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

<img src="photographic_plate.jpeg" alt="A collection of glass plates from 1909 to 1922 capture the moon in different phases. Niels Bohr Institute, University of Copenhagen." width="75%" />
<p class="caption">
A collection of glass plates from 1909 to 1922 capture the moon in
different phases. Niels Bohr Institute, University of Copenhagen.
</p>

</div>

[Image source and more information about photographic
plates](https://www.smithsonianmag.com/science-nature/obsolete-art-mapping-skies-glass-plates-can-still-teach-us-180971890/)

## Installation

You can install the development version of photoplate from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("imperialnolini/photoplate")
```

## Example

This is a basic example of how to use the package:

``` r
library(photoplate)

# Let's estimate a linear model and reformat its stargazer LaTeX output.

# We'll estimate a model for y = b0 + b1*x1 + b2*x2 + e, where:
#  - b0 = 10
#  - b1 = -20
#  - b2 = 30
#  - e = error following a uniform distribution from 0.0001 to 1
 
# We begin by generating 10000 datapoints (let's sample with replacement
# from 0 to 10000000 for x1 and x2 and from 0 to 1 without replacement for e
# then calculate values of y per the betas defined above):
base::set.seed(1)
x1 = sample(0:10000000, 10000, TRUE)
x2 = sample(0:10000000, 10000, TRUE)
e = sample(1:10000, 10000, FALSE, rep(1/10000, 10000))/10000
y = 10 + (-20*x1) + (30*x2) + e
 
# We continue by estimating a model:
model <- lm(y ~ x1 + x2)
 
# We can feed the model to stargazer::stargazer() to look at its results:
stargazer::stargazer(model, type = "text")
#> 
#> =====================================================================
#>                                    Dependent variable:               
#>                     -------------------------------------------------
#>                                             y                        
#> ---------------------------------------------------------------------
#> x1                                     -20.000***                    
#>                                          (0.000)                     
#>                                                                      
#> x2                                      30.000***                    
#>                                          (0.000)                     
#>                                                                      
#> Constant                                10.491***                    
#>                                          (0.008)                     
#>                                                                      
#> ---------------------------------------------------------------------
#> Observations                             10,000                      
#> R2                                        1.000                      
#> Adjusted R2                               1.000                      
#> Residual Std. Error                 0.289 (df = 9997)                
#> F Statistic         646,745,117,735,764,099,082.000*** (df = 2; 9997)
#> =====================================================================
#> Note:                                     *p<0.1; **p<0.05; ***p<0.01

# Note you should always check that form of textual output - especially
# if you use the various stargazer::stargazer() parameters to format the
# output (e.g., renaming the variables) - prior to using photoplate().

# For this example, we'll save the .tex file in your temporary directory.
# Let's get that save filepath:
save_path = tempfile(pattern = "photoplate_example",
                    fileext = ".tex",
                    tmpdir = tempdir(check = TRUE))
# This code says we want a filename that's close to "photoplate_example" and
# has ".tex" as its extension, and we want it to go in your computer's
# temporary directory.

# Having verified that model output seems fine, we feed it to photoplate()
# with arguments for the additional parameters:
photoplate(
  stargazer::stargazer(model),
  "!h",
  save_path,
  "model_output_label_for_crossref"
  )
#> [1] "Saved .tex file to: C:\\Users\\imper\\AppData\\Local\\Temp\\Rtmpys9OMG\\photoplate_example13c88274535c7.tex"

# That code will make a .tex file with the stargazer::stargazer() output
# of the model we estimated and with "!h" as the table format argument.
# That file will save in your temporary directory with a filename like
# "photoplate_example.tex" and with "model_output_label_for_crossref"
# as its LaTeX-internal label for cross-referencing. When you run the
# function for real, you should specify the directory where you want the
# file to save and include the specific name you would like for the file.

# Running the function like this will return something like the following:
# "Saved .tex file to: **temporary directory**\photoplate_example.tex"

# To conclude, we remove that example file from your temporary directory:
file.remove(save_path)
#> [1] TRUE
```

## Notes about the function’s parameters

- *this_stargazer*: Call of stargazer::stargazer() on regression model
  output(s).

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
