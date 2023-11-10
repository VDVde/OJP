# Changelog of CEN OJP XSD

This document contains an overview of the changes between the versions of CEN OJP.

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),

The releases can be found at https://github.com/VDVde/OJP/releases

## [2.0]


### New Services

* New sub-request structures `PlaceFareRequest` and `PlaceFareResult`. [#414](https://github.com/VDVde/OJP/pull/414)
* New `OJPTripChangeRequest`and `OJPTripChangeDelivery`. [#381](https://github.com/VDVde/OJP/pull/381), [#384](https://github.com/VDVde/OJP/pull/384)
* New `OJPStatusRequest`and `OJPStatusDelivery`. [#216](https://github.com/VDVde/OJP/pull/216)
* New `OJPLineInformationRequest` and `OJPLineInformationDelivery`. [#243](https://github.com/VDVde/OJP/pull/243), [#308](https://github.com/VDVde/OJP/pull/308)
* New `OJPAvailabilityRequest` and `OJPAvailabilityDelivery`. [#262](https://github.com/VDVde/OJP/pull/262), [#241](https://github.com/VDVde/OJP/pull/241), [#322](https://github.com/VDVde/OJP/pull/322)
* New `OJPTripRefineRequest` and `OJPTripRefineDelivery`. [#247](https://github.com/VDVde/OJP/pull/247)


### Added

* Added clarifying examples for parallel services, park and ride, journey relations, transport options, restricted lines. [#399](https://github.com/VDVde/OJP/pull/399), [#414](https://github.com/VDVde/OJP/pull/414), [#423](https://github.com/VDVde/OJP/pull/423), [#379](https://github.com/VDVde/OJP/pull/379), [#349](https://github.com/VDVde/OJP/pull/349)
* Added `JourneyRelations` to `DatedJourneyStructure`, `ContinuousServiceStructure`, `ParallelServiceStructure`, `AlternativeServiceStructure`, `BookingPtLegStructure`. [#423](https://github.com/VDVde/OJP/pull/423)
* Added `PlaceFareRequestStructure` and `PlaceFareResultStructure`, added access modes to `FareParamStructure`. [#414](https://github.com/VDVde/OJP/pull/414)
* Added definitions to all requests and responses based on Transmodel. [#413](https://github.com/VDVde/OJP/pull/413)
* Clarified behavior induced by `Location` parameter in `StopEventRequest`. [#412](https://github.com/VDVde/OJP/pull/412)
* **[breaking]** Added and improved `GeneralAttributeStructure` to `LegBoardStructure`, `LegAlightStructure`, `LegIntermediateStructure`. [#406](https://github.com/VDVde/OJP/pull/406)
* Added OJP-Transmodel mapping table. [#402](https://github.com/VDVde/OJP/pull/402), [404](https://github.com/VDVde/OJP/pull/404)
* Additional passenger categories (dog, bicycle, car, …). [#389](https://github.com/VDVde/OJP/pull/389)
* **[breaking]** Added handling of lines with special restrictions (access modes, passenger categories) and of motorised main travel mode. [#349](https://github.com/VDVde/OJP/pull/349), [#425](https://github.com/VDVde/OJP/pull/425), [#426](https://github.com/VDVde/OJP/pull/426)
* Extended `TripFareResult` to contain `TripId` and `BookingId`, and to handle `FareProduct`s covering non-consecutive legs of a trip. [#395](https://github.com/VDVde/OJP/pull/395), [#400](https://github.com/VDVde/OJP/pull/400)
* **[breaking]** New `ParallelService` in `TimedLegService`to describe, for instance, coupled trains with different destinations. Abandoned `ServiceSection`. [#396](https://github.com/VDVde/OJP/pull/396)
* New elements `InterchangeRef`, `ExtraInterchange`, `InterchangeCancellation`, `siri:InterchangePropertyGroup` in `TransferLegStructure` and `UndefinedDelay` in `DatedJourneyStructure`. [#390](https://github.com/VDVde/OJP/pull/390)
* `OJPTripInfoRequest`: added parameters to search by train number and operator. [#378](https://github.com/VDVde/OJP/pull/378)
* More examples. [#373](https://github.com/VDVde/OJP/pull/373), [#374](https://github.com/VDVde/OJP/pull/374), [#375](https://github.com/VDVde/OJP/pull/375), [#376](https://github.com/VDVde/OJP/pull/376)
* Added `FareQuota` to indicate a limited number of remaining tickets. [#371](https://github.com/VDVde/OJP/pull/371)
* Allow for multiple `BookingNote`s. [#370](https://github.com/VDVde/OJP/pull/370)
* Added extension points for several parameter structures. [#369](https://github.com/VDVde/OJP/pull/369)
* Improved mapping to Transmodel by textual descriptions in annotations and additional elements (`LegStructure.Duration`, `TimeWindow`). [#361](https://github.com/VDVde/OJP/pull/361), [#372](https://github.com/VDVde/OJP/pull/372)
* **[breaking]** Additional optimisation methods and filter options for passengers with sensory or mobility restrictions. Modified / clarified behaviour of `NoSingleStep`. Abandoned the option to specify multiple optimisation methods. [#353](https://github.com/VDVde/OJP/pull/353), [#368](https://github.com/VDVde/OJP/pull/368), [#361](https://github.com/VDVde/OJP/pull/361)
* **[breaking]** Added formation information from SIRI. It can be requested in `TripInformationRequest`. SIRI data structures to transmit the information: `siri:JourneyFormationGroup`, `siri:DepartureFormationAssignment`, `siri:ArrivalFormationAssignment`, `siri:ServiceInfoGroup`. [#328](https://github.com/VDVde/OJP/pull/328), [#367](https://github.com/VDVde/OJP/pull/367)
* Added `AreaGeometry` to `LineResultStructure`.  [#337](https://github.com/VDVde/OJP/pull/337)
* New `OJPErrorStructure` both at the level of the `xDelivery` and at the level of the `xResult`. [#336](https://github.com/VDVde/OJP/pull/336)
* Added `IsAlternativeOption` to `TripResultStructure`.  [#326](https://github.com/VDVde/OJP/pull/326)
* Added `FareEstimated` to `FareResultStructure`.  [#324](https://github.com/VDVde/OJP/pull/324)
* Added `TripContext` to `TripFareRequestStructure` and `MultiTripFareRequestStructure`.  [#323](https://github.com/VDVde/OJP/pull/323)
* New `OperatorFilter`and `SystemId` in `TripRefineRequest` to indicate the system to be queried. [#298](https://github.com/VDVde/OJP/pull/298)
* Added `ExpectedDepartureOccupancy` and `ExpectedDepartureCapacities` (from SIRI) to Legs.  [#264](https://github.com/VDVde/OJP/pull/264)
* **[breaking]** Intoduced `ServiceSection`, removed `ServiceGroup` in `DatedJourneyStructure`, `ContinuousServiceStructure`. [#263](https://github.com/VDVde/OJP/pull/263); see also [#396](https://github.com/VDVde/OJP/pull/396)
* Additional `OptimisationMethod`s for trip planning (`leastDistance`, `environmentalSafety`, `extraSafe`, `extraReliable`, `scenic`, `quietTravel`), new `HikingProfile` and `CyclingProfile`, support for mutiple `OptimisationMethod`s, new filter `IncludeAlternativeOptions` to show second-best routes. [#302](https://github.com/VDVde/OJP/pull/302), [#271](https://github.com/VDVde/OJP/pull/271), [#242](https://github.com/VDVde/OJP/pull/242), [#427](https://github.com/VDVde/OJP/pull/427)
* New place sorting options (`PlaceSortingGroup`) for `OJPPlaceInformationRequest`. [#301](https://github.com/VDVde/OJP/pull/301), [#287](https://github.com/VDVde/OJP/pull/287)
* Added switches to request accessibility information (`IncludeAccessFeatureStatus`, `IncludeAccessibilityDetails`) in `OJPTripRequest`. [#291](https://github.com/VDVde/OJP/pull/291)
* Added support for real-time information about access features: `AccessFeatureStatus` in `Leg`, `Feasibility` in `Leg` and `Trip`. [#238](https://github.com/VDVde/OJP/pull/238)
* Added `ConsiderElevationData` switch for `OJPTripRequest` (walking, cycling). [#287](https://github.com/VDVde/OJP/pull/287), [#277](https://github.com/VDVde/OJP/pull/277)
* Added `TariffZoneFilter` for `OJPTripRequest`. [#282](https://github.com/VDVde/OJP/pull/282)
* New individual mode `park-ride-car`, added `POIAdditionalInformation` for information related to parking or vehicle-sharing. [#280](https://github.com/VDVde/OJP/pull/280)
* Added `ReservationNeeded` for dated journeys to indicate if and what aspect of a jouney (operation of a service, call at a stop) needs a reservation. [#272](https://github.com/VDVde/OJP/pull/272)
* Added `SituationFullRefs` for all deliveries. [#268](https://github.com/VDVde/OJP/pull/268)
* Richer data in `PathGuidance`. [#265](https://github.com/VDVde/OJP/pull/265)
* **[breaking]** Added `UseRealTimeData` switch in `OJPTripRequest` to specify whether and how real-time data is taken into account for the trips returned. [#259](https://github.com/VDVde/OJP/pull/259)
* Additional enumeration values for `MultiPointType` (`OJPMultiPointTripRequest`), added `ViaSytem` for `OJPTripRequest` and `OJPMultiPointTripRequest`, added `SustainabilityGroup` with `EmissionCO2`, added `Priority` for exchange points. [#244](https://github.com/VDVde/OJP/pull/244), [#344](https://github.com/VDVde/OJP/pull/344)
* Added `VehicleFilter` to `TripParamStructure`. [#240](https://github.com/VDVde/OJP/pull/240)
* Added `PathLinkEndStructure` to indicate levels and places connected by `PathLink`s. [#239](https://github.com/VDVde/OJP/pull/239)
* Added `AccessibilityFeature`s (values like `stepFreeAccess`, `visualSigns`, etc.) and additional `AccessFeature`s (`singleStep`, `shuttle`, etc.) for `PathLink`s. [#237](https://github.com/VDVde/OJP/pull/237)
* **[breaking]** Heavily extended `BookingArrangements` for better alignment with NeTEx. [#232](https://github.com/VDVde/OJP/pull/232)
* Added `Operators` in `PlaceResultStructure` and `ResponseContext`, added `IncludeOperators` for `OJPPlaceInformationRequest`. [#220](https://github.com/VDVde/OJP/pull/220)
* Added `siri:VehicleRef`to `ServiceGroup`. [#214](https://github.com/VDVde/OJP/pull/214)
* Added `AllowedSystemId`s to `PlaceRefStructure`, specifiying the systems to be queried by `OJPPlaceInformationRequest`. [#204](https://github.com/VDVde/OJP/pull/204)
* Added `PublicCode` of the journey to `DatedJourney` and `ContinuousService`. [#201](https://github.com/VDVde/OJP/pull/201)
* Added permalinks to headers in gnerated html documentation. [#246](https://github.com/VDVde/OJP/pull/246)
* Added *README.md* and this *CHANGELOG.md* files. [#130](https://github.com/VDVde/OJP/pull/130)
* Added `IncludeHierarchy` in `StopEventRequest` to allow including either parts, or the complete hierarchy of the stop point/stop place if known.
  [#96](https://github.com/VDVde/OJP/pull/96)
* Added `NoBoardingAtStop` and `NoAlightingAtStop` to `Call` structures.
  [#91](https://github.com/VDVde/OJP/pull/91)
* Added parameters `ExcludePlacesContext` and `ExcludeSituationsContext` to allow excluding `PlacesContext` and `SituationsContext`.
  [#83](https://github.com/VDVde/OJP/pull/83)
* Added parameter `NoSight` to `BaseTripMobilityFilterGroup` to allow requesting a trip for a blind user.
  [#36](https://github.com/VDVde/OJP/pull/36)
* Added a `TripStatusGroup` consisting of parameters which describe the current status of a trip, e.g., `Cancelled` / `Delayed` / `Infeasible`. 
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

* Changed `NumberOfResultsBefore` and `NumberOfResultsAfter` to optional with default value 0. [#421](https://github.com/VDVde/OJP/pull/421)
* Changed several annotations so as to align the definitions of mode and leg  with Transmodel. [#419](https://github.com/VDVde/OJP/pull/419)
* **[breaking]** Changed  `LegIntermediates` to `LegIntermediate` (typographic error). [#399](https://github.com/VDVde/OJP/pull/399)
* **[breaking]** Completely reorganised `ContinuousModesEnumeration`, `PrivateModesEnumeration`, `TransferModesEnumeration`, `SharingModelEnumeration` into new `TransferTypeEnumeration`, `PersonalModesEnumeration`, `PersonalModesOfOperationEnumeration`, `ConventionalModesOfOperationEnumeration`, and `AlternativeModesOfOperationEnumeration` - together with accompanying wide-ranging changes in several structures: `ContinuousServiceStructure`,  `SharingServiceStructure` (removed),  `AlternativeServiceStructure` (new),  `ParallelServiceStructure` , `DatedJourneyStructure`, `TransferLegStructure`,  `ContinuousLegStructure`,  `LegBoardStructure`,  `BookingPtLegStructure`, `PlaceRefStructure`, `ItModesStructure` (new), `ModeAndModeOfOperationFilterStructure` (new), `PrivateModeFilterStructure` (removed), `ModeFilterStructure` (new), `PtModeFilterStructure` (removed), `IndividualTransportOptionStructure` (new), `IndividualTransportOptionsStructure` (removed), `PlaceContextStructure`, `TripParamStructure`, `MultiPointTripParamStructure`, `StopEventParamStructure`, `PlaceParamStructure`, `ModeStructure`. [#379](https://github.com/VDVde/OJP/pull/379), [#420](https://github.com/VDVde/OJP/pull/420)
* **[breaking]** Made `MultiPointType` a required parameter in `OJPMultiPointTripRequest`. [#353](https://github.com/VDVde/OJP/pull/353)
* **[breaking]** Changed main namespace from `SIRI` to `OJP`. [#347](https://github.com/VDVde/OJP/pull/347)
* Updated all examples to new request and response structures, added to GitHub. [#334](https://github.com/VDVde/OJP/pull/334)
* **[breaking]** Replaced `TravelClass` with `siri:FareClass` which uses the NeTEx enumeration values. [#354](https://github.com/VDVde/OJP/pull/354), [#359](https://github.com/VDVde/OJP/pull/359)
* Reorganised `BaseTripPolicyGroup` so as to align the parameters in `MultiPointTripPolicyGroup` with `TripPolicyGroup` [#333](https://github.com/VDVde/OJP/pull/333)
* **[breaking]** Updated to SIRI 2.1 using a copy and adapted imports. [#330](https://github.com/VDVde/OJP/pull/330)
* Done and then largely undone. First change: Renamed `Location` to `Place`: According to TRANSMODEL a "location" is only a geographical position, while a "place" consists of a location and other attributes. This change distinguishes the two terms properly, which were used inconsistently in OJP. In most cases the term "location" was 
  replaced by the term "place". This applies to type and element names but also to annotations. [#82](https://github.com/VDVde/OJP/pull/82) [#99](https://github.com/VDVde/OJP/pull/99). Second change: Renamed `OJP_Places.xsd` to `OJP_Location.xsd`, `OJP_PlaceSupport.xsd` to `OJP_LocationSupport.xsd`, `OJPPlaceInformationRequest` to `OJPLocationInformationRequest`, as well as the related Delivery, structures and groups; renamed `Place` to `Location` in the StopEvent service and `TripPlace` to `TripLocation`. [#231](https://github.com/VDVde/OJP/pull/231)
* Corrected several typos. [#320](https://github.com/VDVde/OJP/pull/320),  [#343](https://github.com/VDVde/OJP/pull/343)
* **[breaking]** Renamed elements in `ExchangePointsResponseGroup`: `ExchangePointResponseContext` to `ExchangePointsResponseContext`, `Place` to `ExchangePointsResult`. [#295](https://github.com/VDVde/OJP/pull/295)
* Removed obsolete code in *OJPRequestSupport.xsd*. [#294](https://github.com/VDVde/OJP/pull/294)
* `WaitDuration`: changed to standard order of attributes. [#286](https://github.com/VDVde/OJP/pull/286)
* **[breaking]** Renamed `ReferredSystemId` and `AllowedSystemId` to `ReferredSystem` and `AllowedSystem`, respectively. [#244](https://github.com/VDVde/OJP/pull/244)
* **[breaking]** Renamed \*`TripLeg`\* to \*`Leg`\*. [#230](https://github.com/VDVde/OJP/pull/230) 
* **[breaking]** Replaced `EntitlementProductRef`s with a `EntitlementProductListStructure`, allowing for data like `EntitlementProductName` or `ValidityPeriod` for each `EntitlementProduct` in the list. [#229](https://github.com/VDVde/OJP/pull/229)
* **[breaking]** Redefined `VatRate` as a percentage instead of an enumeration. [#228](https://github.com/VDVde/OJP/pull/228)
* **[breaking]** Replaced `coord` with `location` in `PlaceTypeEnumeration`. [#218](https://github.com/VDVde/OJP/pull/218)
* **[breaking]** Renamed `PointOfInterestCode` and `AddressCode` to `PublicCode`, `PointOfInterestName` and `AddressName` to `Name`. [#217](https://github.com/VDVde/OJP/pull/217)
* **[breaking]** Renamed `ResultId`s in `ResultStructure`s to `Id`, as well as `LegId` in `LegStructure` and `TripId` in `TripStructure`. [#215](https://github.com/VDVde/OJP/pull/215)
* Corrected `schemaLocation` for *siri_reference-v2.0.xsd*. [#211](https://github.com/VDVde/OJP/pull/211)
* **[breaking]** Renamed `ErrorMessage` to `Problem`, `Code` to `Type`, `Text` to `Title` and added `Details` and `LogData`; added dedicated \*`ProblemStructure`s for each request, enumerating the possible types, some of which were previously only defined in the documentation, some not defined at all; added the `Problem` element to the \*`ResultStructure`s. Renamed some problem types, e.g., `FARES_`\* to `FARE_`\*, `MULTIPOINTTRIP_TOOMANYPOINTS` to `TRIP_MULTIPOINT_TOOMANYPOINTS`. [#203](https://github.com/VDVde/OJP/pull/203)
* Bug fix: renamed `MinimumBookingPeriod.` to `MinimumBookingPeriod`. [#163](https://github.com/VDVde/OJP/pull/163)
* Introduced more specific ObjectIdTypes for NeTEx objects: `FareResultObjectIdType`, `StopEventResultObjectIdType`, `TripResultObjectIdType`, `MultiPointTripResultObjectIdType`, `TripObjectIdType`, `LegObjectIdType`, `PlaceObjectIdType`. [#316](https://github.com/VDVde/OJP/pull/316),  [#348](https://github.com/VDVde/OJP/pull/348)
* New OJP.spp (XML Spy project file). [#297](https://github.com/VDVde/OJP/pull/297)
* Changed location of automatically generated documentation. [#279](https://github.com/VDVde/OJP/pull/279)
* Migrated from *Travis* to *GitHub Actions*. [#274](https://github.com/VDVde/OJP/pull/274)
* Renamed `FareProductCodeType` to `FareProductIdType`. [#267](https://github.com/VDVde/OJP/pull/267)
* Improved *title* attribute and cardinality in generated HTML documentation. [#233](https://github.com/VDVde/OJP/pull/233)
* **[breaking]** Renamed `PrivateCode` to `DomainCode`.
  [#94](https://github.com/VDVde/OJP/pull/94)
* **[breaking]** Renamed `PublishedLineName` to `PublishedServiceName`.
  [#89](https://github.com/VDVde/OJP/pull/89)
* **[breaking]** Replaced `AcceptDeferredDelivery` in `TripPolicyFilterGroup` by `TripSummaryOnly` in `TripContentFilterGroup` as the parameter to control 
  whether to deliver complete trips or only trip summaries. The concept of a deferred delivery has been removed. Additionally, replaced 
  `MultiPointTripContentFilterGroup` in `MultiPointTripParamStructure` by `TripContentFilterGroup` as legs are mandatory within trip results.
  [#109](https://github.com/VDVde/OJP/pull/109)
* Allow multiple languages to be requested and returned.
  [#32](https://github.com/VDVde/OJP/pull/32)
* Simplified all ResponseContexts to use a single `ResponseContextStructure`.
  [#39](https://github.com/VDVde/OJP/pull/39)
* **[breaking]** Renamed `InfoURL` to `InfoUrl`.
  [#31](https://github.com/VDVde/OJP/pull/31)
* **[breaking]** Changed `BookingUrl` and `InfoUrl` in `BookingArrangementStructure` to contain a `Label` and a `Url` instead of only referring to `xs:anyURI`,
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
* Allow `TransferLimit` to be 0 in `MultiPointTripRequest` as well (like done for c in v1.0.1).
  [#129](https://github.com/VDVde/OJP/pull/129)
* Changed `Places` to new type `PlacesStructure` in `ResponseContextStructure`.
  [#150](https://github.com/VDVde/OJP/pull/150)
* Changed `TopographicPlaceStructureArea` to new type `AreaStructure`, changed `LegTrackStructure/LinkProjection` to new type `LinkProjectionStructure`.
  [#155](https://github.com/VDVde/OJP/pull/155)
* Changed `CallAtStopStructure`, `LegBoardStructure`, `LegAlightStructure` and `LegIntermediateStructure` to new types
  `ServiceArrivalStructure` and `ServiceDepartureStructure`.
  [#156](https://github.com/VDVde/OJP/pull/156), [#367](https://github.com/VDVde/OJP/pull/367)
* Allowed `TransferLimit` to be `0` to allow requesting a trip without transfers.
  [#7](https://github.com/VDVde/OJP/pull/7)
* Allowed `NumberOfResultsBefore` and `NumberOfResultsAfter` to be `0` to allow requesting trips only before or after a given time.
  [#3](https://github.com/VDVde/OJP/pull/3)
 

### Removed
* Removed duplicate `EMailAddressType`. [#403](https://github.com/VDVde/OJP/pull/403)
* Removed annotations in `choice` constructs.
  [#157](https://github.com/VDVde/OJP/pull/157)
* Omit unused requests and responses.
  [#76](https://github.com/VDVde/OJP/pull/76)
* Removed unused structures.
  [#55](https://github.com/VDVde/OJP/pull/55)


## [1.0.0] - 2018-06-08

Initial release, published as [CEN/TS 17118:2017](https://standards.cen.eu/dyn/www/f?p=204:110:0::::FSP_PROJECT:62236&cs=1985DBD613F25D179FB65A73B0FDA4DB7)
