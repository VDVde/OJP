
# OJP - *O*pen API for distributed *J*ourney *P*lanning

## Content
This repository contains the XSD, examples and documentation tables for the 
"**O**pen API for distributed **J**ourney **P**lanning" published as 
*"CEN/TS 17118:2017: "Intelligent transport systems - Public transport - Open API for distributed journey planning"*.

OJP consists of a set of services that can be addressed using HTTP requests.

The main services to request information are:
* Place information
* Stop events (arrival and departure boards)
* Searching for trips
* Information about a given trip
* Information about fares for trips
* Changing of trips
* Refining of trips
* Availability for trip legs
* Information about lines

OJP systems interacting with each other additionally use:
* Getting information about Exchange Points (places when a Trip switches from one OJP system to another)
* Using a multi point trip service (n origins and m destinations)


## Standard document
OJP is a CEN standard. Obtain a copy of the standard document
["CEN/TS 17118:2017: "Intelligent transport systems - Public transport - Open API for distributed journey planning"](https://standards.cen.eu/dyn/www/f?p=204:110:0::::FSP_PROJECT:62236&cs=1985DBD613F25D179FB65A73B0FDA4DB7)
at [CEN](https://www.cen.eu).

OJP is part of the [Transmodel](https://www.transmodel-cen.eu/)) family of standards together with [NeTEx](https://netex-cen.eu/), [SIRI](https://www.transmodel-cen.eu/siri-standard/)  and OPRA. It also contains elements from [DATEX II](https://datex2.eu/).

## Releases
* [OJP 1.0](https://github.com/VDVde/OJP/releases/tag/v1.0): The version described in CEN/TS 17118:2017
* [OJP 1.0.1](https://github.com/VDVde/OJP/releases/tag/v1.0.1): Bug fix release
 * OJP 2.0 in preparation. See the following [branch](https://github.com/VDVde/OJP/tree/changes_for_v1.1) .

## Github Repository

Download the XSD schema files and examples in the git repository found at https://github.com/VDVde/OJP and take a look at the [documentation tables](https://vdvde.github.io/OJP/index.html).

### Branches
* The master branch is currently set to OJP 1.0.1
* Development occurs currently in the changes_for_v1.1 branch.

### Wiki
OJP uses the [wiki](https://github.com/VDVde/OJP/wiki) on github for some resources and examples.

### White papers
The [white papers](https://github.com/VDVde/OJP/wiki/Whitepapers-on-OJP) are published in the wiki as well. 

### Other sources
The wiki also contains links to other sources and [implementations](https://github.com/VDVde/OJP/wiki/Implementations-and-Tests).

## Regulatory environment of OJP
The ITS Directive Delegated Regulation for provision of EU-wide multimodal travel information services is the legal framework for travel data access and distributed journey planning in Europe. This initiative will provide the necessary requirements to make EU-wide multimodal travel information services accurate and available across borders. One of the key requirements concerns linking travel information services for distributed journey planning. Upon request, travel information service providers shall provide to another information service provider "routing results" based on static, and where possible, dynamic information. The "routing results" shall be based on:
* the enquirers start and end points of a journey along with the specific time and date of departure or arrival, or both;
* possible travel options along with the specific time and date of departure or arrival, or both, including any possible connections;
* the handover point between travel information services;
* in case of disturbances, alternative possible travel options along with the specific time and date of departure or arrival, or both, and any connections, where available.

The Delegated Regulation recommends that the CEN OPEN API standard for distributed journey planning is used by local, regional and national travel information service providers.
