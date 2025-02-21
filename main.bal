import ballerina/http;
import ballerina/log;

service / on new http:Listener(9090) {
    resource function post .(RequestBody payload) returns SuccessResponseOk|ErrorResponseBadRequest|ErrorResponseInternalServerError {
        do {
            log:printDebug("Received a request to the service",payload = payload);
            RequestHeaders[]? additionalHeaders = payload.event?.request?.additionalHeaders;
            if !isMobileAppAuthRequest(additionalHeaders) {
                log:printDebug("Skip the request as it's not a mobile app auth request!");
                return <SuccessResponseOk>{body: {actionStatus: SUCCESS, operations: []}};
            }
            if payload.actionType == PRE_ISSUE_ACCESS_TOKEN {
                RequestParams[]? requestParams = payload.event?.request?.additionalParams;
                if requestParams is () {
                    string msg = "Required parameters for MFA validation are missing";
                    log:printDebug(msg);
                    return <ErrorResponseBadRequest>{body: {actionStatus: ERROR, errorMessage: msg, errorDescription: "userId & other params are mandatory to proceed the request"}};
                }
                log:printDebug("Extracted additional parameters from the request", requestParams = requestParams);
                return <SuccessResponseOk>{body: {actionStatus: SUCCESS, operations: []}};
            }
            return <ErrorResponseBadRequest>{body: {actionStatus: ERROR, errorMessage: "Invalid action type", errorDescription: "Support is available only for the PRE_ISSUE_ACCESS_TOKEN action type"}};
        } on fail error err {
            string msg = "Something went wrong while extracting additional parameters";
            log:printDebug(msg, 'error = err);
            return <ErrorResponseBadRequest>{body: {actionStatus: ERROR, errorMessage: msg, errorDescription: err.detail().toString()}};
        }
    }
}
