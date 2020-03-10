'use strict'

let marky = require('marky-markdown')

// Process a README from GitHub
// @param `pkg` must have a name, description and repo
function processReadMe(html, pkg) {
  // Options for `marky-markdown`, that helps us process READMEs
  let markyOptions = {
    sanitize: false,           // False since it's already done by GitHub
    highlightSyntax: false,    // Also done by GitHub
    prefixHeadingIds: false,   // Prevent DOM id collisions
    serveImagesWithCDN: false, // Use npm's CDN to proxy images over HTTPS
    debug: false,              // console.log() all the things
    enableHeadingLinkIcons: true,
    // NPM package metadata to rewrite relative URLs, etc.
    package: {
      name: pkg.name,
      description: pkg.description,
      repository: {
        type: 'git',
        url: `https://github.com/${pkg.repo}`
      }
    },
  };

  return marky(String(html), markyOptions)
}

module.exports = processReadMe;

// If being executed from the command-line
if (!module.parent) {
  let fs = require('fs')

  let readmeFilename = process.argv[2]
  let packageFilename = process.argv[3]

  let readme = fs.readFileSync(readmeFilename)
  let pkg = JSON.parse(fs.readFileSync(packageFilename))

  let result = processReadMe(readme, pkg)

  process.stdout.write(result)
}
