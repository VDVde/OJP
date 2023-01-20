# Changelog of CEN OJP XSD

This document contains an overview of the changes between the versions of CEN OJP.

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),

The releases can be found at https://github.com/VDVde/OJP/releases

Currently active is [1.0.2]

## [2.0]

### Added

### Changed

### Removed

## [1.1] - Not released yet (will be released as part of 2.0)

### Added

* Added `IncludeHierarchy` in `StopEventRequest` to allow including either parts, or the complete hierarchy of the stop point/stop place if known.
  [#96](https://github.com/VDVde/OJP/pull/96)
* Added `NoBoardingAtStop` and `NoAlightingAtStop` to `Call` structures.
  [#91](https://github.com/VDVde/OJP/pull/91)
* Added parameters `ExcludePlacesContext` and `ExcludeSituationsContext` to allow excluding `PlacesContext` and `SituationsContext`.
  [#83](https://github.com/VDVde/OJP/pull/83)
* Added parameter `NoSight` to `BaseTripMobilityFilterGroup` to allow requesting a trip for a blind user.
  [#36](https://github.com/VDVde/OJP/pull/36)
* Added a `TripStatusGroup` consisting of parameters which describe the current status of a trip, e.g. `Cancelled` / `Delayed` / `Infeasible`. 
  [#116](https://github.com/VDVde/OJP/pull/116)
* Added an optional `ProductCategory` of a `Service`. As defined in NeTEx and SIRI, a product category is a classification for VEHICLE JOURNEYs 
  to express some common properties of journeys for marketing and fare products.
  [#95](https://github.com/VDVde/OJP/pull/95) [#113](https://github.com/VDVde/OJP/pull/113)
* Added `DistributorInterchangeId` in `LegBoardStructure` and `FeederInterchangeId` in `LegAlightStructure` to allow transporting an arbitrary
  identifier for feeding service at alighting and distributing service at boarding, which is independent of JourneyRef.  
  [#61](https://github.com/VDVde/OJP/pull/61)
* Added `AdditionalTime` in `Mode` to allow adding time to the actual travel time needed to use a specific mode. 
  [#30](https://github.com/VDVde/OJP/pull/30)
* Added `MimeType` and `Embeddable` to `WebLinkStructure`.
  [#59](https://github.com/VDVde/OJP/pull/59)
* Added `WaitDuration` to `ExchangePointsResultStructure` to allow defining a duration needed at an exchange point to change from one service
  to another.
  [#58](https://github.com/VDVde/OJP/pull/58)
* Added `Extension` to `DatedJourneyStructure` and `ContinuousServiceStructure`.
  [#92](https://github.com/VDVde/OJP/pull/92)
* Added `AllowedSystemId` to `InitialInputStructure`: In a distributed environment, a place information request can refer to several regional
  systems. This parameter allows the client to restrict the request to a specific system.
  [#63](https://github.com/VDVde/OJP/pull/63)
* Added `ReferredSystemId` in `TopographicPlaceStructure`: In a distributed environment, the process of place identification can be a two-step
  process. In the first step, a topographic place (e.g. city, municipality) is identified from the user input, in the second step, the system
  related to the topographic place is queried for places. In order to do so, the topographic places from the first step need to carry the
  information which system they relate to.
  [#62](https://github.com/VDVde/OJP/pull/62)
* Added `ProtoProduct` in `FareProductStructure` to allow carrying product related information to be processed further and used for tariffing
  in a distributed environment, where OJP services can deliver only parts of a fare product.
  [#60](https://github.com/VDVde/OJP/pull/60)
* Added private modes to `PlaceContextStructure/IndividualTransportOptions` (allowing for scooter, ride-pool-car, car-sharing, cycle-sharing, scooter-sharing)
  [#127](https://github.com/VDVde/OJP/pull/127)
* Added valid v1.1 examples of OJP requests and responses.
  [#115](https://github.com/VDVde/OJP/pull/115) [#126](https://github.com/VDVde/OJP/pull/126)
* Added `OJP_All.xsd` and changed directory structure.
  [#117](https://github.com/VDVde/OJP/pull/117)
* Added scripts to generate documentation tables HTML from XSD.
 [#131](https://github.com/VDVde/OJP/pull/131) [#154](https://github.com/VDVde/OJP/pull/154)


### Changed

* Renamed `Location` to `Place`:
  According to TRANSMODEL a "location" is only a geographical position, while a "place" consists of a location and other attributes. 
  This change distinguishes the two terms properly, which were used inconsistently in OJP. In most cases the term "location" was 
  replaced by the term "place". This applies to type and element names but also to annotations.
  [#82](https://github.com/VDVde/OJP/pull/82) [#99](https://github.com/VDVde/OJP/pull/99)
* Renamed `PrivateCode` to `DomainCode`.
  [#94](https://github.com/VDVde/OJP/pull/94)
* Renamed `PublishedLineName` to `PublishedServiceName`.
  [#89](https://github.com/VDVde/OJP/pull/89)
* Replaced `AcceptDeferredDelivery` in `TripPolicyFilterGroup` by `TripSummaryOnly` in `TripContentFilterGroup` as the parameter to control 
  whether to deliver complete trips or only trip summaries. The concept of a deferred delivery has been removed. Additionally, replaced 
  `MultiPointTripContentFilterGroup` in `MultiPointTripParamStructure` by `TripContentFilterGroup` as legs are mandatory within trip results.
  [#109](https://github.com/VDVde/OJP/pull/109)
* Allow multiple languages to be requested and returned.
  [#32](https://github.com/VDVde/OJP/pull/32)
* Simplified all ResponseContexts to use a single `ResponseContextStructure`.
  [#39](https://github.com/VDVde/OJP/pull/39)
* Renamed `InfoURL` to `InfoUrl`.
  [#31](https://github.com/VDVde/OJP/pull/31)
* Changed `BookingUrl` and `InfoUrl` in `BookingArrangementStructure` to contain a `Label` and a `Url` instead of only referring to `xs:anyURI`,
  changed `InfoUrl` in `GeneralAttributeStructure` to `Url`.
  [#123](https://github.com/VDVde/OJP/pull/123)
* Set the default value `anyPoint` for `MultiPointType` in `MultiPointTripPolicyGroup` so the default response does not have to contain a trip
  result for each of the given origins and destinations but only for one of them.
  [#98](https://github.com/VDVde/OJP/pull/98)
* Allowed `TransferLimit` to be `0` to allow requesting a multi trip without transfers.
  [#123](https://github.com/VDVde/OJP/pull/123)
* Aligned annotation with the CEN documentation.
  [#57](https://github.com/VDVde/OJP/pull/57)
* Clarified only referenced places and situations should be put into the `ResponseContext`.
  [#107](https://github.com/VDVde/OJP/pull/107)
* Moved `ResponseContextStructure` to `OJP_RequestSupport.xsd`.
  [#110](https://github.com/VDVde/OJP/pull/110)
* Optimized formatting of the files.
  [#74](https://github.com/VDVde/OJP/pull/74)
* Allow `TransferLimit` to be 0 in `MultiPointTripRequest` as well (like done for `TripRequest` in v1.0.1).
  [#129](https://github.com/VDVde/OJP/pull/129)
* Changed `Places` to new type `PlacesStructure` in `ResponseContextStructure`.
  [#150](https://github.com/VDVde/OJP/pull/150)
* Changed `TopographicPlaceStructureArea` to new type `AreaStructure`, changed `LegTrackStructure/LinkProjection` to new type `LinkProjectionStructure`.
  [#155](https://github.com/VDVde/OJP/pull/155)
* Changed `CallAtStopStructure`, `LegBoardStructure`, `LegAlightStructure` and `LegIntermediateStructure` to new types
  `ServiceArrivalStructure` and `ServiceDepartureStructure`.
  [#156](https://github.com/VDVde/OJP/pull/156)  

### Removed
* Omit unused requests and responses.
  [#76](https://github.com/VDVde/OJP/pull/76)
* Removed unused structures.
  [#55](https://github.com/VDVde/OJP/pull/55)


## [1.0.1] - 2019-02-26

### Changed
* Allowed `TransferLimit` to be `0` to allow requesting a trip without transfers.
  [#7](https://github.com/VDVde/OJP/pull/7)
* Allowed `NumberOfResultsBefore` and `NumberOfResultsAfter` to be `0` to allow requesting trips only before or after a given time.
  [#3](https://github.com/VDVde/OJP/pull/3)


## [1.0.0] - 2018-06-08

Initial release, published as [CEN/TS 17118:2017](https://standards.cen.eu/dyn/www/f?p=204:110:0::::FSP_PROJECT:62236&cs=1985DBD613F25D179FB65A73B0FDA4DB7)
