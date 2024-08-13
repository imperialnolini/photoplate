
<!-- README.md is generated from README.Rmd. Please edit that file -->

# photoplate

<!-- badges: start -->
<!-- badges: end -->

The goal of photoplate is to customize stargazer::stargazer() regression
tables for inclusion in LaTeX documents.

Until the later 1980s, astronomers used glass photographic plates to
record their observations. These plates made it possible for them to
share what they saw when gazing toward the stars; in that spirit, this
package’s eponymous function is named “photoplate.”

<figure>
<img src="%22photographic_plate.webp%22"
alt="“A collection of glass plates from 1909 to 1922 capture the moon in different phases. Niels Bohr Institute, University of Copenhagen,” source and further reading" />
<figcaption aria-hidden="true">“A collection of glass plates from 1909
to 1922 capture the moon in different phases. Niels Bohr Institute,
University of Copenhagen,” <a
href="https://www.smithsonianmag.com/science-nature/obsolete-art-mapping-skies-glass-plates-can-still-teach-us-180971890/">source
and further reading</a></figcaption>
</figure>

The below example illustrates the functionality of the package.

## Installation

You can install the development version of photoplate from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("imperialnolini/photoplate")
#> ℹ Loading metadata database✔ Loading metadata database ... done
#>  
#> → Will install 27 packages.
#> → Will update 1 package.
#> → Will download 25 CRAN packages (14.57 MB), cached: 2 (15.62 MB).
#> → Will download 1 package with unknown size.
#> + bit                     4.0.5      [dl] (1.13 MB)
#> + bit64                   4.0.5      [dl] (492.93 kB)
#> + cli                     3.6.2      [dl] (1.34 MB)
#> + clipr                   0.8.0      [dl] (54.74 kB)
#> + crayon                  1.5.2      [dl] (162.50 kB)
#> + dplyr                   1.1.4      [dl] (1.56 MB)
#> + fansi                   1.0.6      [dl] (313.99 kB)
#> + generics                0.1.3      [dl] (79.48 kB)
#> + glue                    1.7.0      [dl] (160.67 kB)
#> + hms                     1.1.3      [dl] (103.58 kB)
#> + lifecycle               1.0.4      [dl] (139.75 kB)
#> + magrittr                2.0.3      [dl] (227.09 kB)
#> + photoplate 0.0.0.9000 → 0.0.0.9000 [bld][cmp][dl] (GitHub: 3cd2ae1)
#> + pillar                  1.9.0      [dl] (659.10 kB)
#> + pkgconfig               2.0.3      [dl] (22.20 kB)
#> + R6                      2.5.1      [dl] (84.31 kB)
#> + readr                   2.1.5      [dl] (1.16 MB)
#> + rlang                   1.1.3      [dl] (1.58 MB)
#> + stargazer               5.2.3      
#> + stringi                 1.8.3      
#> + stringr                 1.5.1      [dl] (318.73 kB)
#> + tibble                  3.2.1      [dl] (690.23 kB)
#> + tidyselect              1.2.1      [dl] (225.39 kB)
#> + tzdb                    0.4.0      [dl] (1.02 MB)
#> + utf8                    1.2.4      [dl] (150.04 kB)
#> + vctrs                   0.6.5      [dl] (1.34 MB)
#> + vroom                   1.6.5      [dl] (1.31 MB)
#> + withr                   3.0.0      [dl] (245.68 kB)
#> ℹ Getting 25 pkgs (14.57 MB) and 1 pkg with unknown size, 2 (15.62 MB) cached
#> ✔ Cached copy of photoplate 0.0.0.9000 (source) is the latest build
#> ✔ Cached copy of R6 2.5.1 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of bit64 4.0.5 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of bit 4.0.5 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of cli 3.6.2 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of clipr 0.8.0 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of crayon 1.5.2 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of dplyr 1.1.4 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of fansi 1.0.6 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of generics 0.1.3 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of glue 1.7.0 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of hms 1.1.3 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of lifecycle 1.0.4 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of magrittr 2.0.3 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of pillar 1.9.0 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of pkgconfig 2.0.3 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of readr 2.1.5 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of rlang 1.1.3 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of stringr 1.5.1 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of tibble 3.2.1 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of tidyselect 1.2.1 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of tzdb 0.4.0 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of utf8 1.2.4 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of vctrs 0.6.5 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of vroom 1.6.5 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of withr 3.0.0 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Installed photoplate 0.0.0.9000 (github::imperialnolini/photoplate@3cd2ae1) (1.1s)
#> ✔ Installed R6 2.5.1  (1.1s)
#> ✔ Installed bit64 4.0.5  (1.1s)
#> ✔ Installed bit 4.0.5  (1.1s)
#> ✔ Installed cli 3.6.2  (1.1s)
#> ✔ Installed clipr 0.8.0  (1.1s)
#> ✔ Installed crayon 1.5.2  (1.1s)
#> ✔ Installed dplyr 1.1.4  (1.1s)
#> ✔ Installed fansi 1.0.6  (1.2s)
#> ✔ Installed generics 0.1.3  (1.2s)
#> ✔ Installed glue 1.7.0  (1.2s)
#> ✔ Installed hms 1.1.3  (1.2s)
#> ✔ Installed lifecycle 1.0.4  (1.2s)
#> ✔ Installed magrittr 2.0.3  (1.2s)
#> ✔ Installed pillar 1.9.0  (1.2s)
#> ✔ Installed pkgconfig 2.0.3  (1.2s)
#> ✔ Installed rlang 1.1.3  (1.2s)
#> ✔ Installed stargazer 5.2.3  (1.4s)
#> ✔ Installed readr 2.1.5  (1.7s)
#> ✔ Installed stringi 1.8.3  (1.7s)
#> ✔ Installed stringr 1.5.1  (676ms)
#> ✔ Installed tidyselect 1.2.1  (570ms)
#> ✔ Installed tibble 3.2.1  (706ms)
#> ✔ Installed utf8 1.2.4  (520ms)
#> ✔ Installed tzdb 0.4.0  (638ms)
#> ✔ Installed vctrs 0.6.5  (547ms)
#> ✔ Installed withr 3.0.0  (464ms)
#> ✔ Installed vroom 1.6.5  (638ms)
#> ✔ 1 pkg + 27 deps: upd 1, added 27 [9.5s]
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
#> [1] "Saved .tex file to: C:\\Users\\imper\\AppData\\Local\\Temp\\RtmpKEWx68\\photoplate_example137104f577f0f.tex"

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
