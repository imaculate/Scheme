# Helper files for Functional Programming Assignment

A collection of helper files to help complete the 3rd Year Functional
Programming assignment for UCT 3rd years, 2015.

Pull requests are encouraged.

## Contents

### Automarker

A simple automarking script. The tutors will be using this (with a more
comprehensive suite of tests) to check the correctness of your program. Provided
is a sample spec giving some basic tests, giving you the input and output
formats expected.

Please feel free to branch off and modify the spec to test your own program's
correctness!

This was designed with [Gambit](http://gambitscheme.org/) in mind - mileage may
vary with other scheme distributions.  To run on assignment3.scm included in
this directory with the included sample spec,

    ./mark.sh

Alternatively, you can run

    gsi automarker/automarker.scm SPEC ASSIGNMENT


Where:
* `SPEC` - the tests defined in the format specified at the beginning of
  `automarker/automarker.scm`. See `automarker/spec.scm` for an example spec.
* `ASSIGNMENT` - the location of your scheme assignment implementing all the
  functions defined in `assignment3.scm` and expected in your spec.
