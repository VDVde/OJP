
# Generating OJP Documentation

This document describes the generation of documentation for the OJP XML schemas. There are two goals:

* Generate plain HTML documentation with a table of contents for reference purposes.
* Provide the HTML documentation in a format so it can be easily integrated into the associated CEN standards document which is maintained as an MS Word file.

## Generation of HTML documentation

## Prerequisites

A Java Runtime Environment is required to create the documentation.

On Linux, install a Java Runtime Environment using the command `apt-get install default-jre` (or the equivalent command in non-Debian-based distributions).

For Windows, you can find executable for Java at [https://www.oracle.com/java/technologies/downloads/](https://www.oracle.com/java/technologies/downloads/)

## Creating the HTML documentation

### Instructions

On Linux, provided the above requirements are met, you can run the script [`generate-tables.sh`](generate-tables.sh) to convert the XML schemas into a single HTML file [`index.html`](generated/index.html) in the `generated/` subdirectory.

On Windows, please refer to the file [`generate-tables.sh`](generate-tables.sh) to determine the necessary commands.

### How it works

[`generate-tables.sh`](generate-tables.sh) downloads [BaseX](https://basex.org/) and runs it.

BaseX uses the configuration in the [`generate_tables/`](generate_tables/) directory to convert the XML schema to HTML.
