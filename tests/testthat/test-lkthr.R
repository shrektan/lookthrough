context("test-lkthr.R")

data(lkthr_sample)
ptfs <- as_lkthr(lkthr_sample$ptfs)
funds <- as_lkthr(lkthr_sample$funds)

test_that("match will alter the input", {
  ptfs2 <- Clone(ptfs)
  res <- lkthr_match(ptfs2, funds, 5L)
  expect_reference(res, ptfs2)
})

test_that("won't match anything if max layer <= 1", {
  res <- lkthr_match(Clone(ptfs), funds, 1L)
  expect_equal(ptfs, res)
  res <- lkthr_match(Clone(ptfs), funds, 2L)
  expect_failure(expect_equal(ptfs, res))
})

test_that("match recursively", {
  res <- lkthr_match(Clone(ptfs), funds, 2L)
  expect_true(any(purrr::map_lgl(res$leaves, ~grepl("fund", .$name))))
  res <- lkthr_match(Clone(ptfs), funds, 5L)
  expect_false(any(purrr::map_lgl(res$leaves, ~grepl("fund", .$name))))
})

test_that("set works and alters the input", {
  ptfs2 <- Clone(ptfs)
  res <- lkthr_set(ptfs2, list("asset3" = list(issuer = "abc")))
  expect_equal(
    unique(ptfs2$Get("issuer", filterFun = function(node) !is.null(node$issuer))),
    "abc"
  )
  expect_reference(res, ptfs2)
})

test_that("filter works and won't alter the input", {
  ptfs2 <- lkthr_set(lkthr_match(Clone(ptfs), funds), lkthr_sample$attributes)
  res <- lkthr_filter(ptfs2, function(node) {"company_g" %in% node$issuer})
  expect_equal(
    unique(purrr::map_chr(res$leaves, ~.$name)),
    "asset7"
  )
  expect_equal(
    res$ptf3$fund3$asset7$exposure,
    res$ptf3$fund3$exposure
  )
})

