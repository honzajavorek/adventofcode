# aoc

My [adventofcode.com](https://adventofcode.com/) experiments 🎄

## Testing

To be able to test puzzles in various languages, I'm using [bats](https://github.com/bats-core/bats-core) 🦇, a testing framework in Bash. Someone [packaged it as an npm package](https://www.npmjs.com/package/bats), so I'm using npm here for dependencies and for running tasks around the repository:

```
$ npm install  # installs bats
$ npm test     # runs tests
```
