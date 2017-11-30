%w(
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmp/caching-dev.txt
  .env
).each { |path| Spring.watch(path) }
