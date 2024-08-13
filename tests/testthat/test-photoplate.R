# Tested separately when creating function; copied/pasted test code here
# for future reference. Passes all six of these tests.



# library(photoplate)
#
# # BEGINNING
# base::set.seed(1)
# x1 = sample(0:10000000, 10000, TRUE)
# x2 = sample(0:10000000, 10000, TRUE)
# e = sample(1:10000, 10000, FALSE, rep(1/10000, 10000))/10000
# y = 10 + (-20*x1) + (30*x2) + e
# model <- lm(y ~ x1 + x2)
# model_two <- lm(y ~ x1)
#
# # TEST ONE: model, no note
# stargazer::stargazer(model, type = "text")
# photoplate(
#   stargazer::stargazer(model),
#   "!h",
#   "model_output_label_for_crossref",
#   tempfile(pattern = "photoplate_example",
#            fileext = ".tex",
#            tmpdir = tempdir(check = TRUE))
# )
#
# # TEST TWO: model, one note
# stargazer::stargazer(model, notes = "Note", type = "text")
# photoplate(
#   stargazer::stargazer(model, notes = "Note"),
#   "!h",
#   "model_output_label_for_crossref",
#   tempfile(pattern = "photoplate_example",
#            fileext = ".tex",
#            tmpdir = tempdir(check = TRUE))
# )
#
# # TEST THREE: model, two notes
# stargazer::stargazer(model, notes = c("Note", "Note2"), type = "text")
# photoplate(
#   stargazer::stargazer(model, notes = c("Note", "Note2")),
#   "!h",
#   "model_output_label_for_crossref",
#   tempfile(pattern = "photoplate_example",
#            fileext = ".tex",
#            tmpdir = tempdir(check = TRUE))
# )
#
# # TEST FOUR: model AND model_two, no note
# stargazer::stargazer(model, model_two, type = "text")
# photoplate(
#   stargazer::stargazer(model, model_two),
#   "!h",
#   "model_output_label_for_crossref",
#   tempfile(pattern = "photoplate_example",
#            fileext = ".tex",
#            tmpdir = tempdir(check = TRUE))
# )
#
# # TEST FIVE: model AND model_two, one note
# stargazer::stargazer(model, model_two, notes = "Note", type = "text")
# photoplate(
#   stargazer::stargazer(model, model_two, notes = "Note"),
#   "!h",
#   "model_output_label_for_crossref",
#   tempfile(pattern = "photoplate_example",
#            fileext = ".tex",
#            tmpdir = tempdir(check = TRUE))
# )
#
# # TEST SIX: model AND model_two, two notes, title, DV label, new line, col labels, new line
# stargazer::stargazer(model, model_two, notes = c("Note", "Note2"),
#                      title = "Another table, this time with a test title",
#                      dep.var.labels = "Test DV",
#
#                      add.lines = list(c("For fun?", "Yes", "Yes")),
#
#                      column.labels   = c("1984", "1988"),
#                      column.separate = c(1,1),
#                      table.layout = "m=!ldc#-!t-!a-!s=!n",
#                      type = "text")
# photoplate(
#   stargazer::stargazer(model, model_two, notes = c("Note", "Note2"),
#                        title = "Another table, this time with a test title",
#                        dep.var.labels = "Test DV",
#
#                        add.lines = list(c("For fun?", "Yes", "Yes")),
#
#                        column.labels   = c("1984", "1988"),
#                        column.separate = c(1,1),
#                        table.layout = "m=!ldc#-!t-!a-!s=!n"),
#   "!h",
#   "model_output_label_for_crossref",
#   tempfile(pattern = "photoplate_example",
#            fileext = ".tex",
#            tmpdir = tempdir(check = TRUE))
# )




