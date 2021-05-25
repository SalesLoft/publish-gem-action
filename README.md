# Publish Gem Github Action

This Github action publishes a new version of a ruby gem when the version is tagged.

## Setup

See [test-gem](https://github.com/SalesLoft/test-gem/blob/master/.github/workflows/salesloft.yml) for a full example.

Update your workflow to run on pushes to `tags: [ 'v*' ]`. It should end up looking something like:

```yaml
on:
  push:
    branches: [ master ]
    tags: [ 'v*' ]
  pull_request:
```

Add the following job to your workflow:

```yaml
publish:
  name: Publish Gem
  needs: rspec
  if: startsWith(github.ref, 'refs/tags/v')
  runs-on: ubuntu-18.04
  steps:
    - name: Clone Repo
      uses: actions/checkout@v2

    - name: Publish Gem
      uses: SalesLoft/publish-gem-action@v1.0.0
      with:
        gem_repo_url: ${{ secrets.GEM_REPO_UPLOAD_URL }}
```

the `needs` key should include every check that should pass before publishing.

If your default branch is named something other than `master`, add the following to the `with` section:

```yaml
with:
  gem_repo_url: ${{ secrets.GEM_REPO_UPLOAD_URL }}
  default_branch_name: main
```

If your gem is in a subdirectory, specify the `working_directory` in the `with` section:

```yaml
with:
  gem_repo_url: ${{ secrets.GEM_REPO_UPLOAD_URL }}
  working_directory: ./ruby
```

## Usage

This will run every time a new tag starting with `v` is pushed.

This does not update code. You mush already have the correct version set in your gemspec or it will refuse to publish.

When you are ready to publish a new version, do one of the following:

* Create a release on Github and link it to a new tag matching the version in your gem. (recommended)
* Directly push a tag in the format `vX.Y.Z`.

### Prereleases

This action will enforce that releases are made from master. If you want to cut a test release from a feature branch, give it a [prerelease version](https://guides.rubygems.org/patterns/#prerelease-gems) and then follow the normal steps.
