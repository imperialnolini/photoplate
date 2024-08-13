
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

The below example illustrates the functionality of the package.

## Installation

You can install the development version of photoplate from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("imperialnolini/photoplate")
#> ! Using bundled GitHub PAT. Please add your own PAT using `gitcreds::gitcreds_set()`.
#> ✔ Updated metadata database: 5.30 MB in 15 files.
#> ℹ Updating metadata database✔ Updating metadata database ... done
#>  
#> → Will install 27 packages.
#> → Will update 1 package.
#> → Will download 27 CRAN packages (30.19 MB).
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
#> + photoplate 0.0.0.9000 → 0.0.0.9000 [bld][cmp][dl] (GitHub: 96c572a)
#> + pillar                  1.9.0      [dl] (659.10 kB)
#> + pkgconfig               2.0.3      [dl] (22.20 kB)
#> + R6                      2.5.1      [dl] (84.31 kB)
#> + readr                   2.1.5      [dl] (1.16 MB)
#> + rlang                   1.1.3      [dl] (1.58 MB)
#> + stargazer               5.2.3      [dl] (617.47 kB)
#> + stringi                 1.8.3      [dl] (15.01 MB)
#> + stringr                 1.5.1      [dl] (318.73 kB)
#> + tibble                  3.2.1      [dl] (690.23 kB)
#> + tidyselect              1.2.1      [dl] (225.39 kB)
#> + tzdb                    0.4.0      [dl] (1.02 MB)
#> + utf8                    1.2.4      [dl] (150.04 kB)
#> + vctrs                   0.6.5      [dl] (1.34 MB)
#> + vroom                   1.6.5      [dl] (1.31 MB)
#> + withr                   3.0.0      [dl] (245.68 kB)
#> ℹ Getting 27 pkgs (30.19 MB) and 1 pkg with unknown size
#> ✔ Got clipr 0.8.0 (i386+x86_64-w64-mingw32) (54.73 kB)
#> ✔ Got R6 2.5.1 (i386+x86_64-w64-mingw32) (84.20 kB)
#> ✔ Got photoplate 0.0.0.9000 (source) (11.34 kB)
#> ✔ Got crayon 1.5.2 (i386+x86_64-w64-mingw32) (162.60 kB)
#> ✔ Got bit64 4.0.5 (x86_64-w64-mingw32) (494.37 kB)
#> ✔ Got generics 0.1.3 (i386+x86_64-w64-mingw32) (79.65 kB)
#> ✔ Got fansi 1.0.6 (x86_64-w64-mingw32) (313.55 kB)
#> ✔ Got bit 4.0.5 (x86_64-w64-mingw32) (1.13 MB)
#> ✔ Got pillar 1.9.0 (i386+x86_64-w64-mingw32) (658.89 kB)
#> ✔ Got rlang 1.1.3 (x86_64-w64-mingw32) (1.58 MB)
#> ✔ Got stargazer 5.2.3 (i386+x86_64-w64-mingw32) (617.47 kB)
#> ✔ Got tidyselect 1.2.1 (i386+x86_64-w64-mingw32) (225.40 kB)
#> ✔ Got withr 3.0.0 (i386+x86_64-w64-mingw32) (246.01 kB)
#> ✔ Got cli 3.6.2 (x86_64-w64-mingw32) (1.34 MB)
#> ✔ Got stringr 1.5.1 (i386+x86_64-w64-mingw32) (318.81 kB)
#> ✔ Got pkgconfig 2.0.3 (i386+x86_64-w64-mingw32) (22.42 kB)
#> ✔ Got dplyr 1.1.4 (x86_64-w64-mingw32) (1.56 MB)
#> ✔ Got tibble 3.2.1 (x86_64-w64-mingw32) (690.09 kB)
#> ✔ Got utf8 1.2.4 (x86_64-w64-mingw32) (149.95 kB)
#> ✔ Got readr 2.1.5 (x86_64-w64-mingw32) (1.16 MB)
#> ✔ Got glue 1.7.0 (x86_64-w64-mingw32) (160.73 kB)
#> ✔ Got vroom 1.6.5 (x86_64-w64-mingw32) (1.31 MB)
#> ✔ Got tzdb 0.4.0 (x86_64-w64-mingw32) (1.02 MB)
#> ✔ Got vctrs 0.6.5 (x86_64-w64-mingw32) (1.34 MB)
#> ✔ Got hms 1.1.3 (i386+x86_64-w64-mingw32) (103.41 kB)
#> ✔ Got lifecycle 1.0.4 (i386+x86_64-w64-mingw32) (139.79 kB)
#> ✔ Got magrittr 2.0.3 (x86_64-w64-mingw32) (227.22 kB)
#> ✔ Got stringi 1.8.3 (x86_64-w64-mingw32) (15.01 MB)
#> ✔ Installed R6 2.5.1  (1.4s)
#> ✔ Installed bit64 4.0.5  (1.5s)
#> ✔ Installed bit 4.0.5  (1.7s)
#> ✔ Installed cli 3.6.2  (1.7s)
#> ✔ Installed clipr 0.8.0  (1.9s)
#> ✔ Installed crayon 1.5.2  (2.1s)
#> ✔ Installed dplyr 1.1.4  (2.1s)
#> ✔ Installed fansi 1.0.6  (2.2s)
#> ✔ Installed generics 0.1.3  (2.4s)
#> ✔ Installed glue 1.7.0  (2.4s)
#> ✔ Installed hms 1.1.3  (2.6s)
#> ✔ Installed lifecycle 1.0.4  (2.7s)
#> ✔ Installed magrittr 2.0.3  (2.9s)
#> ✔ Installed pillar 1.9.0  (2.8s)
#> ✔ Installed pkgconfig 2.0.3  (3s)
#> ✔ Installed readr 2.1.5  (3.1s)
#> ✔ Installed rlang 1.1.3  (3.1s)
#> ✔ Installed stargazer 5.2.3  (3.2s)
#> ✔ Installed stringr 1.5.1  (3.2s)
#> ✔ Installed stringi 1.8.3  (3.6s)
#> ✔ Installed tibble 3.2.1  (599ms)
#> ✔ Installed tidyselect 1.2.1  (627ms)
#> ✔ Installed tzdb 0.4.0  (748ms)
#> ✔ Installed utf8 1.2.4  (652ms)
#> ✔ Installed vctrs 0.6.5  (703ms)
#> ✔ Installed withr 3.0.0  (610ms)
#> ✔ Installed vroom 1.6.5  (881ms)
#> ℹ Packaging photoplate 0.0.0.9000
#> ✔ Packaged photoplate 0.0.0.9000 (1.6s)
#> ℹ Building photoplate 0.0.0.9000
#> ✔ Built photoplate 0.0.0.9000 (2.5s)
#> ✔ Installed photoplate 0.0.0.9000 (github::imperialnolini/photoplate@96c572a) (259ms)
#> ✔ 1 pkg + 27 deps: upd 1, added 27, dld 28 (NA B) [44s]
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
#> [1] "Saved .tex file to: C:\\Users\\imper\\AppData\\Local\\Temp\\RtmpAPlxr4\\photoplate_example1050c5e5375c7.tex"

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
