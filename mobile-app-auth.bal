import ballerina/log;

isolated function isMobileAppAuthRequest(RequestHeaders[]? additionalHeaders) returns boolean {
    log:printDebug("Checking if the request is a mobile app auth request", additionalHeaders = additionalHeaders);
    if additionalHeaders is () {
        return false;
    } else if additionalHeaders.length() == 0 {
        return false;
    } else {
        foreach RequestHeaders header in additionalHeaders {
            string[]? value = header.value;
            string? name = header.name;
            boolean hasMobileAppAuthHeader = name is string && name == "mobileappauth" &&
                value is string[] && value.length() > 0 && value[0] == "true";
            if hasMobileAppAuthHeader {
                return true;
            }
        }
        return false;
    }
}
