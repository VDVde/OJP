# Release Notes CEN OJP XSD v1.1 (DRAFT)

This is in introduction to the changes from CEN OJP XSD v1.0 to v1.1



## Repository

The XSDs can be found on: https://github.com/VDVde/OJP

## Breaking / Major
* Location was changed to Place: This is breaking. According to TRANSMODEL a location is only a geographical position, while a place has a location along with other attributes. Within OJP the two terms were used inconsistently. This commit distinguishes the two terms properly. In most cases the term location was replaced by the term place. This applies to type and element names but also to annotations. This commit addresses issue [#44](https://github.com/VDVde/OJP/issues/44).(https://github.com/VDVde/OJP/pull/82 https://github.com/VDVde/OJP/pull/99)
* PrivateCode is renamed to DomainCode (https://github.com/VDVde/OJP/pull/94)
* * PublishedLineName becomes now PublishedServiceName (https://github.com/VDVde/OJP/pull/89/files)

## Relevant 
* Lates SIRI version is included.  TODO Describe some more
* A TripStatusGroup was added. This allows for "flags" forUnplanned/Cancelled/Deviation/Delayed/Infeasible to be added to a trip.  (https://github.com/VDVde/OJP/pull/116)
* ProductCategory of a Service is added and optional (https://github.com/VDVde/OJP/pull/95 https://github.com/VDVde/OJP/pull/113)
* Removed AcceptDeferredDelivery from TripPolicyFilterGroup. Instead added TripSummaryOnly into TripContentFilterGroup as the parameter to control whether complete trips or only trip summaries shall be delivered. There is no relation to a deferred delivery anymore.   Removed IncludeLegs from MultiPointTripContentFilterGroup, as legs are mandatory within trip results. Removed MultiPointTripContentFilterGroup, as there is no need have different content filters for MultiPointTrip or Trip respectively. (https://github.com/VDVde/OJP/pull/109)
* Add a parameter IncludeHierarchy in StopEventRequest that allows to include parts or all of the hierarchy of the stop point/stop place if known. So if you only know one stop point in the meta station, it can grab all data, if this is intended. It has three values: "local" (default) local server setting, "no" includes no hierarchy , "down" (includes all lower StopPoints/StopPlaces) according to the stop hierarchy, "all" (includes all StopPoints/StopPlaces in the meta station) (https://github.com/VDVde/OJP/pull/96)
* NoBoardingAtStop / NoAlightingAtStop now allowed for Calls (https://github.com/VDVde/OJP/pull/91)
* Filters that allow the Exclusion of PlacesContext and SituationsContext (ExcludePlacesContext and ExcludeSituationsContext (https://github.com/VDVde/OJP/pull/83)
* In a distributed environment, a place  information request can refer to several regional systems. In order to allow the requesting client to restrict the meant system, a filter of system IDs can be used in InitialInputStructure. (https://github.com/VDVde/OJP/pull/63 )
* In an distributed environment, the process of place identification can be a two-steps process. In the first step, a topographic place (e.g. city, municipality) is identified from the user's input. In the second step, the system related to the topographic place is queried for places. In order to do so, the topographic places from the first step need to carry the information, to which system they relate. (https://github.com/VDVde/OJP/pull/62)
* Added LineIdAtBoarding in LegBoardStructure and LineIdAtAlighting in LegAlightStructure. This way, an arbitrary identifier for a service at boarding and alighting can be transported, which is independent from JourneyRef. This can be used in distributed environments in order to recognize, that two systems refer the same line/service while they still use their own internal references. (https://github.com/VDVde/OJP/pull/61)
* AdditionalTime added to Mode: Additional time added to the actual traveling time needed to use a specific mode. (https://github.com/VDVde/OJP/pull/30)
* 
## Minor Changes
* MultiTripFareResultStructure is now a WebLinkStructure
* Example XML are added that are valid v1.1.  (https://github.com/VDVde/OJP/pull/115)
* OJP_All.xsd was added and directory structure changed. (https://github.com/VDVde/OJP/pull/117)
* ResponseContextStructure moved to OJP_RequestSupport.xsd (https://github.com/VDVde/OJP/pull/110)
* Formatting of the files was optimized.
* Only reference places and situations should be put into the Context (https://github.com/VDVde/OJP/pull/107)
* Set a default value of "anyPoint" for MultiPointType within MultiPointTripPolicyGroup. This default causes that the response doesn't necessarily have to contain a trip result for each of the given origins or destinations. (https://github.com/VDVde/OJP/pull/98)
* Extensions allowed now in Service and Mode (https://github.com/VDVde/OJP/pull/92/files)
* Added ProtoProduct into FareProductStructure: A proto product is a fare product, which shall not be shown to the user directly. Instead it carries fare product related information, which can be processed further. Can be used for tariffing in a distributed environment, where OJP services can deliver only parts of a fare product. (https://github.com/VDVde/OJP/pull/60)
* Added MIME type and embeddability to WebLinkStructure (https://github.com/VDVde/OJP/pull/59)
* Added WaitDuration to ExchangePointsResultStructure: Duration needed at this exchange point to change from one service to another. If a journey planning orchestrator puts together a trip at this exchange point, it has to take care, that feeding arrival and fetching departure are at least this duration apart. (https://github.com/VDVde/OJP/pull/58)
* Change all ResponseContexts to a single structure (https://github.com/VDVde/OJP/pull/39)
* Fixed some annotations to be conform with the CEN documentation and cleanup   (https://github.com/VDVde/OJP/pull/57 https://github.com/VDVde/OJP/pull/55)
* InfoURL renamed to InfoUrl (https://github.com/VDVde/OJP/pull/31)
* Feature visually impaired. NoSight added and also IncludeTactilePaving (https://github.com/VDVde/OJP/pull/36)
* TransferLimit should be a xs:nonNegativeInteger (https://github.com/VDVde/OJP/pull/7)
* Allow NumberOfResultsBefore or NumberOfResultsAfter to be 0(https://github.com/VDVde/OJP/pull/3)
* Add PrivateModeChoiceGroup to select type of taxi: At this moment it is possible to select the user wants to take a taxi, but the user is unable to select a specific TaxiSubmode.  It might be better to resolve this using a Mode Group like tas been done for PtMode. (https://github.com/VDVde/OJP/pull/2)
 
