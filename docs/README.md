
# Generating OJP Documentation

This document describes the generation of documentation for the OJP XML schemas. There are two goals:

* Generate plain HTML documentation with a table of contents for reference purposes.
* Provide the HTML documentation in a format so it can be easily integrated into the associated CEN standards document which is maintained as an MS Word file.

## Prerequisites

The documentation generation process requires an Java runtime.

On Linux, install a Java runtime running `apt-get install default-jre` (or the required equivalent in non-Debian based distributions).

For Windows, you'll find Windows binaries for Java at https://www.oracle.com/java/technologies/downloads/

## Generation of HTML documentation

### Instructions

On Linux and with the above prerequisites at hand, you can run `generate-tables.sh` to convert the XML schemas into a single HTML file [`index.html`](generated/index.html) in the `generated` subdirectory.

The generated HTML file requires the file `asciidoc.css` to be in the same directory. The above script makes sure it's there.

On Windows, please refer to the `generate-tables.sh` to figure out the necessary program invocations.

### Inner workings

`generate-tables.sh` runs `basex`, which does a direct transformation from XML Schema directly to HTML.
The code for this is available under the `generate_tables` folder.
