## Summary

[Change!] Describe your feature, problems you had, notes, improvements and others.

-----------------

Before submitting the PR make sure the following are checked:

## Suggested
* [ ] Wrote [good commit messages](https://chris.beams.io/posts/git-commit/).
* [ ] Squashed related commits together.

## Required

### Before pushing
* [ ] Feature branch is up-to-date with `master` (if not - rebase it).
* [ ] Added tests.
* [ ] Run rubocop lint with this following command `bundle exec rubocop lib spec --format simple`
* [ ] Run rspec tests with this following command `bundle exec rspec`
* [ ] Added an entry to the [Changelog](https://github.com/Wolox/errors_savior/blob/master/CHANGELOG.md) if the new code introduces user-observable changes. See [changelog entry format](https://github.com/Wolox/errors_savior/blob/master/CHANGELOG.md#changelog-entry-format).

### When creating a pull request
* [ ] Assign properly label depending on the category of the pull request. It should be one of [**BUG**, **FEATURE**, **ENHANCEMENT**, **GEM RELEASE**]
* [ ] Fix problems if the CI fails
