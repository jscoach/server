'use strict'

const remark = require('remark');
const guide = require('remark-preset-lint-markdown-style-guide');
const Html = require('remark-html');
const emoji = require('remark-emoji');
const highlight = require('remark-highlight.js');

// Process a README from GitHub
// @param `pkg` must have a name, description and repo
function processReadMe(html, pkg, cb) {
  return remark()
    .use(guide)
    .use(Html)
    .use(emoji)
    .use(highlight)
    .process(html, function (err, file) {
      cb(String(file))
    })

}

module.exports = processReadMe

// If being executed from the command-line
if (!module.parent) {
  let fs = require('fs')

  let readmeFilename = process.argv[2]
  let packageFilename = process.argv[3]

  let readme = fs.readFileSync(readmeFilename)
  let pkg = JSON.parse(fs.readFileSync(packageFilename))

  processReadMe(readme, pkg, function (result) {
    process.stdout.write(result)
  })


}
