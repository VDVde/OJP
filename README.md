# OJP - *O*pen API for distributed *J*ourney *P*lanning  XSD

## Content ##
This repository contains the XSD and examples for the Standard "CEN/TS 17118:2017: "Intelligent transport systems - Public transport - Open API for distributed journey planning".

OJP consists of a set of services that can be addressed by Request / Response or by subscription.

The main services are:
* Location Information
* Stop Events (arrival and departure boards)
* Searching for Trips
* Information about a given Trips
* Information about Fares for Trips

For the interaction between different OJP additionally there are:
* Getting information about Exchange Points (places when a Trip switches from one OJP system to another)
* MultiPointTripRequest: Allows for searching of n x m Trips



## Standard document

Obtain a copy of the standard document
["CEN/TS 17118:2017: "Intelligent transport systems - Public transport - Open API for distributed journey planning"](https://standards.cen.eu/dyn/www/f?p=204:110:0::::FSP_PROJECT:62236&cs=1985DBD613F25D179FB65A73B0FDA4DB7)
at [CEN](https://www.cen.eu).

## Repository

Download the XSD schema files and examples in the git repository found at https://github.com/VDVde/OJP 

## Regulatory environment of OJP ##
The ITS Directive Delegated Regulation for provision of EU-wide multimodal travel information services is the legal framework for travel
data access and distributed journey planning in Europe. This initiative will provide the necessary requirements to make EU-wide multimodal
travel information services accurate and available across borders. One of the key requirements concerns linking travel information services
for distributed journey planning. Upon request, travel information service providers shall provide to another information service provider
"routing results" based on static, and where possible, dynamic information. The "routing results" shall be based on:
* the enquirers start and end points of a journey along with the specific time and date of departure or arrival, or both;
* possible travel options along with the specific time and date of departure or arrival, or both, including any possible connections;
* the handover point between travel information services;
* in case of disturbances, alternative possible travel options along with the specific time and date of departure or arrival, or both, and
  any connections, where available.

The Delegated Regulation recommends that the CEN OPEN API standard for distributed journey planning is used by local, regional and national
travel information service providers.
